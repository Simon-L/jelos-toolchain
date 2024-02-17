FROM justenoughlinuxos/jelos-build:latest

ARG source_path
ARG target_path
ARG symlink

WORKDIR /work
RUN echo "Copying $source_path to $target_path"
COPY $source_path $target_path

ENV TOOLCHAIN_PATH="$target_path"
ENV TOOLCHAIN_SYSROOT="$target_path/aarch64-jelos-linux-gnueabi/sysroot"
RUN if [ -n "$symlink" ] ; then mkdir -p $(dirname $symlink) && ln -s $target_path $symlink ; fi

ENV CC="$target_path/bin/aarch64-jelos-linux-gnueabi-gcc"
ENV CXX="$target_path/bin/aarch64-jelos-linux-gnueabi-g++"
ENV PATH="$TOOLCHAIN_PATH/bin:$PATH"

RUN echo "Path is $PATH"
RUN echo "CC is $CC"
RUN echo "CXX is $CXX"

USER docker
WORKDIR /home/docker
