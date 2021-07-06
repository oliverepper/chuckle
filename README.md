# chuckle

Very simple C++ demo library that downloads and returns a joke from
[chucknorris.io](https://api.chucknorris.io/jokes/random).
The build script builds the library for iOS, iOS simulator and macOS on Apple Silicon and Intel Macs.
It's meant to be included in a Swift package for easy integration into an application.
The build-system links every required object file into the library.

For [reasons](https://github.com/leetal/ios-cmake/issues/110) that I don't understand, yet build.sh
needs to be run two times.
