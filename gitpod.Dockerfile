FROM gitpod/flutter

USER gitpod

# Install additional dependencies for web support
RUN sudo apt-get update && \
    sudo apt-get install -y \
      clang \
      cmake \
      ninja-build \
      libwebkit2gtk-4.0-dev

# Install webdev and create a dummy project to warm up pub cache
RUN pub global activate webdev && \
    mkdir warmup && \
    cd warmup && \
    flutter create . && \
    flutter packages get && \
    cd .. && \
    rm -rf warmup

# Configure Flutter for web
RUN flutter config --enable-web
