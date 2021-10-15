# Analog Discovery 2 block
**A block that can be used to interface with an analog discovery 2 oscilloscope remotely**

## Highlights

- **Remotely accesible Waveform GUI**: Remotely view the scope output
- **Jupyter notebook support**: Use the dwf python SDK to write scripts that use the AD2, and run them remotely

## Setup and configuration

Use this as standalone with the button below:

[![template block deploy with balena](https://balena.io/deploy.svg)](https://dashboard.balena-cloud.com/deploy?repoUrl=https://github.com/rcooke-warwick/analog-discovery)

Or add the following service to your `docker-compose.yml`:

```yaml
version: "2.1"
volumes:
  jupyter:
services:
  analog-discovery:
    restart: always
    image: ghcr.io/rcooke-warwick/analog-discovery:latest
    privileged: true
    volumes:
      - "jupyter:/data"
    ports:
      - "8080:5900"
      - "80:8888"

```

## Documentation

This block can be used to remotely control an [Analog Discovery 2 oscilloscope](https://digilent.com/reference/test-and-measurement/analog-discovery-2/start) with a balena device.

Firstly, you must ensure that your balena device is connected to the AD2 via USB. We recommend powering the AD2 with a seperate power source, as some devices may struggle to provide enough current to the AD2 through their USB port.

When the block is running on your balena device, you can access the Waveform GUI using a VNC viewer (for example Remmina or RealVNC), one of two ways.

### Connecting to the GUI over your local network

If your laptop/desktop is on the same network as your balena device, you can access the GUI by connecting to the VNC server at:

```bash
<DEVICE_LOCAL_IP_ADDRESS>:8080
```

Connecting this way will allow you to use the GUI with a lower latency

### Connecting to the GUI via balena cloud

You can also connect to the GUI over the internet instead, allowing you to access devices anywhere. To do this, you mirst first establish a tunnel to the balena device:

```bash
balena tunnel <DEVICE_UUID> -p 8080:8080
```

When this is successful, you will see:

```bash
[Info]    Opening a tunnel to <DEVICE_UUID>...
[Info]     - tunnelling localhost:8080 to <DEVICE_UUID>:8080
[Info]    Waiting for connections...
```

At which point, you can access the VNC server using your VNC viewer via:

```bash
localhost:8080
```

### Using Jupyter notebooks

You can also use the `dwf` python [SDK](https://github.com/amuramatsu/dwf) to swrite scripts to interact with your AD2. This block will allow you to connect to a jupyter notebook server running on the balena device, so you can create and run scripts on the device remotely.

To connect to the jupyter notebook, simply enable the public URL on your balena device, and then in a web browser connect to `https://<DEVICE_UUID>.balena-devices.com/`
There will be 2 example notebooks visible, that demonstrate digital and analog data capture.

## Getting Help

If you're having any problem, please [raise an issue](https://github.com/balenablocks/template/issues/new) on GitHub and we will be happy to help.

## Contributing

Do you want to help make balenablock-template better? Take a look at our [Contributing Guide](https://balenablocks.io/template/contributing). Hope to see you around!

## License

balenablock-template is free software, and may be redistributed under the terms specified in the [license](https://github.com/balenablockstemplate/blob/master/LICENSE).
