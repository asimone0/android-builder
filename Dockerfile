FROM bitnami/minideb:stretch

ENV ANDROID_CONFIG_DIR=/usr/local/bin/android-sdk-config \
    ANDROID_SDK_PATH=/usr/local/bin/android-sdk \
    ANDROID_HOME=/usr/local/bin/android-sdk

ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

RUN install_packages \
        ca-certificates \
        openssl \
        wget \
        expect \
        openjdk-8-jdk \
        unzip && \
        mkdir -p $ANDROID_CONFIG_DIR && \
        mkdir -p $ANDROID_SDK_PATH && \
        mkdir /project

WORKDIR /project

COPY android-sdk-config ${ANDROID_CONFIG_DIR}
COPY expect/sdkmanager-update /usr/local/bin

ENV ANDROID_TOOLS_DOWNLOAD=sdk-tools-linux-3859397.zip
# Note: ANDROID_TOOLS_DOWNLOAD should reflect the latest android for linux tools 
# found on https://developer.android.com/studio/index.html#downloads

RUN chmod 755 /usr/local/bin/sdkmanager-update && \
    wget https://dl.google.com/android/repository/${ANDROID_TOOLS_DOWNLOAD} && \
    unzip $ANDROID_TOOLS_DOWNLOAD && \
    mv tools $ANDROID_SDK_PATH && \
    rm $ANDROID_TOOLS_DOWNLOAD && \
    sdkmanager-update && \
    sdkmanager --package_file=${ANDROID_CONFIG_DIR}/install && \
    yes | sdkmanager --licenses