# Build project
RUN make

FROM ubuntu:24.04

# Install dependencies
RUN apt-get update && apt-get install -y \
    build-essential cmake gdb git \
    freeglut3-dev libglew-dev libglfw3-dev libglm-dev

# Install OpenFrameworks dependencies
RUN git clone --depth=1 https://github.com/openframeworks/openFrameworks.git /openFrameworks

# Set working directory
WORKDIR /openFrameworks/apps/myApps/openFrameworksProjectTemplate

# Copy project files
# COPY . .

# Build project
# RUN make
