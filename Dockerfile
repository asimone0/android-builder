FROM bitnami/minideb:stretch

# Note: ANDROID_TOOLS_DOWNLOAD should reflect the latest android for linux tools 
# found on https://developer.android.com/studio/index.html#downloads

ENV ANDROID_TOOLS_DOWNLOAD=sdk-tools-linux-4333796.zip \
    ANDROID_SDK_PATH=/usr/local/bin/android-sdk \
    ANDROID_HOME=/usr/local/bin/android-sdk

ENV PATH=${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin:${ANDROID_HOME}/platform-tools

RUN install_packages \
        ca-certificates \
        openssl \
        wget \
        openjdk-8-jdk \
        unzip && \
        mkdir -p ${ANDROID_SDK_PATH} && \
        wget https://dl.google.com/android/repository/${ANDROID_TOOLS_DOWNLOAD} && \
        unzip ${ANDROID_TOOLS_DOWNLOAD} && \
        mv tools ${ANDROID_SDK_PATH} && \
        rm ${ANDROID_TOOLS_DOWNLOAD} && \
        yes | sdkmanager --update && \
        yes | sdkmanager "build-tools;25.0.0" && \
        yes | sdkmanager "build-tools;25.0.1" && \
        yes | sdkmanager "build-tools;25.0.2" && \
        yes | sdkmanager "build-tools;25.0.3" && \
        yes | sdkmanager "build-tools;26.0.0" && \
        yes | sdkmanager "build-tools;26.0.1" && \
        yes | sdkmanager "build-tools;26.0.2" && \
        yes | sdkmanager "build-tools;27.0.2" && \
        yes | sdkmanager "build-tools;27.0.3" && \
        yes | sdkmanager "build-tools;28.0.0" && \
        yes | sdkmanager "platforms;android-25" && \
        yes | sdkmanager "platforms;android-26" && \
        yes | sdkmanager "platforms;android-27" && \
        yes | sdkmanager "platforms;android-28" && \
        yes | sdkmanager --licenses && \
        mkdir /project

WORKDIR /project