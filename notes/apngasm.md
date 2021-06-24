# apngasm (APNG Assembler)#
[Github](https://github.com/apngasm/apngasm)

Library for turning images into APNG sequences.

```bash
# Get build dependencies
sudo apt install cmake libpng-dev libboost-program-options-dev libboost-regex-dev libboost-system-dev libboost-filesystem-dev build-essential
cd github/
# Clone the repo
git clone https://github.com/apngasm/apngasm.git
cd apngasm/
# Make the build directory
mkdir build
cd build/
# Compile with CMake
cmake ../
# Build the package
make
# Install the package
sudo make install
# Make an installable package for future use
make package
# Set environment
export LD_LIBRARY_PATH=/usr/local/lib
```
