FROM ubuntu:22.04

# Avoid interactive prompts during package installations
ENV DEBIAN_FRONTEND=noninteractive

# Install essential tools and dependencies
RUN apt-get update && apt-get install -y \
    curl \
    git \
    unzip \
    xz-utils \
    zip \
    libglu1-mesa \
    openjdk-11-jdk \
    wget \
    xvfb \
    libpulse0 \
    android-tools-adb \
    lib32stdc++6 \
    npm \
    x11-xserver-utils \
    libgconf-2-4

# Set up Flutter
RUN git clone https://github.com/flutter/flutter.git -b stable /flutter
ENV PATH="/flutter/bin:$PATH"

# Install Android SDK
ENV ANDROID_SDK_ROOT /opt/android-sdk-linux
ENV PATH ${PATH}:${ANDROID_SDK_ROOT}/cmdline-tools/latest/bin:${ANDROID_SDK_ROOT}/platform-tools

# Download Android SDK tools
RUN mkdir -p ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
    wget -q https://dl.google.com/android/repository/commandlinetools-linux-8512546_latest.zip -O /tmp/commandlinetools.zip && \
    unzip -q /tmp/commandlinetools.zip -d /tmp && \
    mv /tmp/cmdline-tools/* ${ANDROID_SDK_ROOT}/cmdline-tools/latest && \
    rm -rf /tmp/commandlinetools.zip /tmp/cmdline-tools

# Accept licenses and install necessary components
RUN yes | sdkmanager --licenses && \
    sdkmanager "platform-tools" \
    "platforms;android-33" \
    "build-tools;33.0.1" \
    "system-images;android-33;google_apis;x86_64" \
    "emulator"

# Set up emulator
RUN echo "no" | avdmanager create avd -n test_emulator -k "system-images;android-33;google_apis;x86_64"

# Clean up
RUN apt-get clean && \
    rm -rf /var/lib/apt/lists/*

# Pre-download Flutter dependencies
RUN flutter precache && \
    flutter doctor