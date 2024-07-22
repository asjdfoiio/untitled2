FROM fedora:latest
LABEL authors="sviatoslav"

WORKDIR /app

RUN sudo dnf groupinstall "Development tools"

RUN sudo dnf install mpfr-devel gmp-devel libmpc-devel \
zlib-devel glibc-devel.i686 glibc-devel isl-devel \
g++ gcc-gnat gcc-gdc libgphobos-static

RUN wget https://ftp.gwdg.de/pub/misc/gcc/releases/gcc-13.2.0/gcc-13.2.0.tar.xz \
https://ftp.gwdg.de/pub/misc/gcc/releases/gcc-13.2.0/gcc-13.2.0.tar.xz.sig

RUN tar xvf gcc-13.2.0.tar.xz

RUN cd gcc-13.2.0

RUN mkdir build

RUN cd build

RUN ../configure --enable-bootstrap \
--enable-languages=c,c++,fortran,objc,obj-c++,ada,go,d,lto \
--prefix=/usr --program-suffix=-13.2 --mandir=/usr/share/man \
--infodir=/usr/share/info --enable-shared --enable-threads=posix \
--enable-checking=release --enable-multilib --with-system-zlib \
--enable-__cxa_atexit --disable-libunwind-exceptions \
--enable-gnu-unique-object --enable-linker-build-id \
--with-gcc-major-version-only --enable-libstdcxx-backtrace \
--with-libstdcxx-zoneinfo=/usr/share/zoneinfo --with-linker-hash-style=gnu \
--enable-plugin --enable-initfini-array --with-isl \
--enable-offload-targets=nvptx-none --enable-offload-defaulted \
--enable-gnu-indirect-function --enable-cet --with-tune=generic \
--with-arch_32=i686 --build=x86_64-redhat-linux \
--with-build-config=bootstrap-lto --enable-link-serialization=1 \
--with-default-libstdcxx-abi=new --with-build-config=bootstrap-lto

RUN make -j6


CMD ["gcc", "--version"]