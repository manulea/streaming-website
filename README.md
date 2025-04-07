# streaming-website
used to connect obs to my own personal website. an example website, to test out the code and change the UI and layout etc, also to just be active and provide quality material if it proves positive in the direction that I'm choosing to go with it. But also to add to the list of achivements and successful projects.


# Streaming Website with NGINX and Node.js

Welcome to the **Streaming Website**! This project allows you to create your own live streaming platform using NGINX, Node.js, and HLS (HTTP Live Streaming) technology. Below, you'll find instructions for setting up the project, running the servers, and linking OBS for live streaming.

---

## Table of Contents
- [Requirements](#requirements)
- [Installation](#installation)
- [Running the Server](#running-the-server)
- [Linking OBS to Your Server](#linking-obs-to-your-server)
- [Configuration Files](#configuration-files)
- [License](#license)

---

## Requirements
Before starting, ensure you have the following installed:
1. **Node.js** (Latest stable version)  
   Download from [Node.js official website](https://nodejs.org).
   
2. **OBS Studio** (For live streaming)  
   Download from [OBS Studio official website](https://obsproject.com).

---

## Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/YourUsername/streaming-website.git
   cd streaming-website

2. Install the necessary packages:

```bash
npm install
```

3. Add Video,js
```bash
npm install video.js
```

4. Ensure NGINX is properly set up:
Use the prebuilt NGINX binaries in the repository, or download [NGINX](https://nginx.org/en/download.html)

#Running the Server
##Using the Batch Script

1. Run the  file `start-servers.bat` file:
* Right-click the file and select Run as administrator.

2. The script will:
* Start the NGINX server
* Launch the Node.js server

##Manual Commands

If you prefer manual commands:

1. Start the NGINX server:

```bash
cd nginx-rtmp-httpflv-1.17.1-windows-prebuilt/release
nginx.exe
```
2. Start the Node.js server:

```bash
node server.js
```

#Linking OBS to Your Server
##OBS Settings:
1. Open OBS Studio and navigate to Settings > Stream.
2. Configure the stream settings
* Service: Custom
* Server: `rtmp://localhost/live`
* Stream Key: test (or the key defined in your nginx.conf file).
3. Apply changes and start streaming. The video files will be generated in the  directory.

#Configuration File

`nginx.conf`

The main NGINX configuration file is located at

`nginx-rtmp-httpflv-1.17.1-windows-prebuilt/release/conf/nginx.conf`

Key sections to update:

* RTMP Stream:

application live {
     live on;
     record off;
     hls on;
     hls_path C:/Users/Sione/Documents/OneDrive/Desktop/GitHub/streaming-website/hls;
     hls_fragment 2s;
}

* location /hls/ {
     root C:/Users/Sione/Documents/OneDrive/Desktop/GitHub/streaming-website;
     add_header Cache-Control no-cache;
     add_header Access-Control-Allow-Origin *;
     types {
         application/vnd.apple.mpegurl m3u8;
         video/mp2t ts;
     }
}

## Notes
* If you encounter issues with playback, check browser console logs for errors (press F12).

* Use VLC Media Player for troubleshooting  playback.

## License

This project is open-source and licensed under MIT License. Feel free to use, modify, and share!

Happy streaming! 🎥
