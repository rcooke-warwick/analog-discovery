FROM debian:latest

# Update and install necessary packages
RUN apt-get update && apt-get dist-upgrade --yes
RUN apt-get install -y wget libqt5script5 libusb-1.0-0 xdg-utils libqt5multimedia5-plugins libqt5scripttools5 libqt5network5

# Fix for xdg-desktop-menu error
# Source: https://askubuntu.com/questions/405800/installation-problem-xdg-desktop-menu-no-writable-system-menu-directory-found
RUN mkdir /usr/share/desktop-directories/

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

# Install Python3 and DWF library to automate waveforms operations
RUN apt-get install -y python3 python3-pip
RUN pip3 install pytest xunitparser dwf
COPY test.py .
COPY wave.py
COPY entry.sh .
RUN chmod +x entry.sh

CMD ["./entry.sh"]
