FROM debian:latest

# Update and install necessary packages
RUN apt-get update && apt-get dist-upgrade --yes
RUN apt-get install -y wget libqt5script5 libusb-1.0-0 xdg-utils procps libqt5multimedia5-plugins libqt5scripttools5 libqt5network5 x11vnc x11-utils xvfb wmctrl supervisor

# Fix for xdg-desktop-menu error
# Source: https://askubuntu.com/questions/405800/installation-problem-xdg-desktop-menu-no-writable-system-menu-directory-found
RUN mkdir /usr/share/desktop-directories/

# ARG TARGETPLATFORM
# RUN echo "building for $TARGETPLATFORM"
# RUN if [ $TARGETPLATFORM = "linux/arm64" ]; then echo "arm64" > arch; elif [ $TARGETPLATFORM = "linux/arm/v7" ]; then echo "armhf" > arch; else echo "amd64" > arch; fi;
# Set the OS version to pull the debian packages from (using a "variable file")
RUN echo "arm64" > arch;

# Get the Adept and Waveforms installers
RUN wget https://digilent.s3-us-west-2.amazonaws.com/Software/Adept2+Runtime/2.21.3/digilent.adept.runtime_2.21.3-$(cat arch).deb
RUN wget https://digilent.s3-us-west-2.amazonaws.com/Software/Waveforms2015/3.16.3/digilent.waveforms_3.16.3_$(cat arch).deb

# Install Adept and Waveforms
RUN dpkg -i digilent.adept.runtime_2.21.3-$(cat arch).deb
RUN dpkg -i digilent.waveforms_3.16.3_$(cat arch).deb

# Remove installers
RUN rm digilent.adept.runtime_2.21.3-$(cat arch).deb
RUN rm digilent.waveforms_3.16.3_$(cat arch).deb

# Remove the arch "variable file"
RUN rm arch

WORKDIR /usr/app
# Install Python3 and DWF library to automate waveforms operations
RUN apt-get install -y python3 python3-pip python3-dev
RUN pip3 install pytest xunitparser dwf jupyter matplotlib

COPY ./examples ./examples/
RUN ln -s /usr/share/digilent/waveforms/samples/py ./examples/python

COPY entry.sh .
RUN chmod +x entry.sh

COPY supervisor /etc/supervisor

CMD ["./entry.sh"]
