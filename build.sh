#!/bin/sh

# iOS & simulator running on arm64
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
            -B out/simulatorarm64

# macOS on arm64
cmake -S ./ -DCMAKE_BUILD_TYPE=RelWithDebInfo \
            -DPLATFORM=MAC_ARM64 \
            -DCMAKE_TOOLCHAIN_FILE=ios.toolchain.cmake \
            -DHAVE_SOCKET_LIBSOCKET=FALSE \
            -DHAVE_LIBSOCKET=FALSE \
            -B out/mac_arm64

cmake --build ./out/os64 --config RelWithDebInfo --parallel 8
cmake --build ./out/simulatorarm64 --config RelWithDebInfo --parallel 8
cmake --build ./out/mac_arm64 --config RelWithDebInfo --parallel 8

rm -rf libchuckle.xcframework

xcodebuild -create-xcframework \
  -library "out/os64/chuckle/libchuckle.a" \
  -library "out/simulatorarm64/chuckle/libchuckle.a" \
  -library "out/mac_arm64/chuckle/libchuckle.a" \
  -output libchuckle.xcframework

# copy Header
mkdir -p libchuckle.xcframework/Headers
cp include/chuckle/chuckle.h libchuckle.xcframework/Headers