#!/bin/sh

# iOS & simulator running on arm64 & x86_64
cmake -S ./ -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DPLATFORM=OS64 \
            -DDEPLOYMENT_TARGET=14.0 \
            -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
            -DHAVE_SOCKET_LIBSOCKET=FALSE \
            -DHAVE_LIBSOCKET=FALSE \
            -B out/os64
cmake -S ./ -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DPLATFORM=SIMULATORARM64 \
            -DDEPLOYMENT_TARGET=14.0 \
            -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
            -DHAVE_SOCKET_LIBSOCKET=FALSE \
            -DHAVE_LIBSOCKET=FALSE \
            -B out/simulator_arm64
cmake -S ./ -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DPLATFORM=SIMULATOR64 \
            -DDEPLOYMENT_TARGET=14.0 \
            -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
            -DHAVE_SOCKET_LIBSOCKET=FALSE \
            -DHAVE_LIBSOCKET=FALSE \
            -B out/simulator_x86_64

# macOS on arm64
cmake -S ./ -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DPLATFORM=MAC_ARM64 \
            -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
            -DHAVE_SOCKET_LIBSOCKET=FALSE \
            -DHAVE_LIBSOCKET=FALSE \
            -B out/mac_arm64

# macOS on x86_64
cmake -S ./ -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DPLATFORM=MAC \
            -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
            -DHAVE_SOCKET_LIBSOCKET=FALSE \
            -DHAVE_LIBSOCKET=FALSE \
            -B out/mac_x86_64

cmake --build ./out/os64 --config RelWithDebInfo --parallel 8
cmake --build ./out/simulator_arm64 --config RelWithDebInfo --parallel 8
cmake --build ./out/simulator_x86_64 --config RelWithDebInfo --parallel 8
cmake --build ./out/mac_arm64 --config RelWithDebInfo --parallel 8
cmake --build ./out/mac_x86_64 --config RelWithDebInfo --parallel 8

rm -rf libchuckle.xcframework

mkdir -p "out/mac/chuckle/"
mkdir -p "out/simulator/chuckle/"

lipo -create out/mac_arm64/chuckle/libchuckle.a \
             out/mac_x86_64/chuckle/libchuckle.a \
     -output out/mac/chuckle/libchuckle.a

lipo -create out/simulator_arm64/chuckle/libchuckle.a \
             out/simulator_x86_64/chuckle/libchuckle.a \
     -output out/simulator/chuckle/libchuckle.a

xcodebuild -create-xcframework \
  -library "out/os64/chuckle/libchuckle.a" \
  -library "out/simulator/chuckle/libchuckle.a" \
  -library "out/mac/chuckle/libchuckle.a" \
  -output libchuckle.xcframework

# copy Header
mkdir -p libchuckle.xcframework/Headers
cp include/chuckle/chuckle.h libchuckle.xcframework/Headers

# copy xcframework into Swift package
mkdir -p ChuckleWrapper/lib
cp -a libchuckle.xcframework ChuckleWrapper/lib
