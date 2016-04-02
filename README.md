# mpvrift

This repository contains a GLSL shader which can be used for watching side by side 3D movies or images at the Oculus Rift.
It was created as I was unable to find a usable solution for watching 3D movies at the Rift at Linux.
The shader implements just the barrel distortion which is needed to see the movie undistorted through the Rifts lenses.

There is no "extended" support like chromatic abberation or similar. So you will most likely see color blurring at the edges.

The people at mpv suggested to create an own repository for the shader, so here it is.

## Steps to use the shader file
1. Download and build mpv (use the scripts at https://github.com/mpv-player/mpv-build for good build support, my steps were:)
1a. git clone https://github.com/mpv-player/mpv-build.git
1b. cd mpv-build
1c. ./update
1d. ./use-mpv-master
1e. ./update
1f. ./build
1g. (solve all dependency issues like missing *-dev libraries and repeat 1f)
2. Download mpvrift: git clone https://github.com/masand/mpvrift.git
3. Run mpv with rift shader:
   <path-to-mpv-build>/mpv/build/mpv -vo=opengl:post-shaders=<path-to-mpvrift>/mpvrift.glsl <some-side-by-side-3D-video-file>
4. Enjoy!
