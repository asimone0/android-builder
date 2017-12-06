FROM bitnami/minideb:stretch

# This should reflect the latest android for linux  tools found on develop.android.com
ENV ANDROID_TOOLS_DOWNLOAD sdk-tools-linux-3859397.zip
ENV ANDROID_CONFIG_DIR /usr/local/bin/android-sdk-config
ENV ANDROID_SDK_PATH /usr/local/bin/android-sdk

RUN install_packages \
        ca-certificates \
        openssl \
        wget \
        expect \
        openjdk-8-jdk \
        unzip

RUN mkdir -p ${ANDROID_CONFIG_DIR}
COPY android-sdk-config ${ANDROID_CONFIG_DIR}

COPY expect/sdkmanager-update /usr/local/bin
RUN chmod 755 /usr/local/bin/sdkmanager-update

RUN mkdir -p ${ANDROID_SDK_PATH}

RUN wget https://dl.google.com/android/repository/${ANDROID_TOOLS_DOWNLOAD} && \
    unzip ${ANDROID_TOOLS_DOWNLOAD} && \
    mv tools ${ANDROID_SDK_PATH} && \
    rm ${ANDROID_TOOLS_DOWNLOAD}

ENV ANDROID_HOME /usr/local/bin/android-sdk
ENV PATH $PATH:$ANDROID_HOME/tools:$ANDROID_HOME/tools/bin:$ANDROID_HOME/platform-tools

RUN sdkmanager-update
RUN sdkmanager --package_file=${ANDROID_CONFIG_DIR}/install
RUN yes | sdkmanager --licenses

RUN mkdir /project
WORKDIR /project
