FROM registry.centos.org/centos/centos:7

# Install dependencies for mattermost-integration-github
RUN yum -y update && \
    yum -y install epel-release && \
    yum -y install nodejs && \
    yum -y install zlib.i686 libstdc++.i686 make git android-tools.x86_64 java-1.8.0-openjdk-devel java-1.8.0-openjdk-headless wget unzip

RUN cd /opt && \
    wget --output-document=android-sdk.zip --quiet https://dl.google.com/android/repository/sdk-tools-linux-3859397.zip && \
    unzip android-sdk.zip && \
    rm -f android-sdk.zip && \
    mkdir android-sdk-linux && \
    mv tools/ android-sdk-linux/ && \
    chown -R root:root android-sdk-linux

RUN wget https://dl.yarnpkg.com/rpm/yarn.repo -O /etc/yum.repos.d/yarn.repo &&\
    yum -y install yarn

ENV ANDROID_HOME /opt/android-sdk-linux
ENV GRADLE_HOME /opt/gradle
ENV PATH ${PATH}:${ANDROID_HOME}/tools:${ANDROID_HOME}/tools/bin
ENV JAVA_HOME=/usr/lib/jvm/jre-openjdk/
# Install Android Platforms
RUN export JAVA_HOME=/usr/lib/jvm/jre-openjdk/ && \
echo y | sdkmanager "platform-tools" && \
echo " Installing APIS" && \
echo y | sdkmanager "add-ons;addon-google_apis-google-23" && \
echo y | sdkmanager "add-ons;addon-google_apis-google-24" && \
echo y | sdkmanager "add-ons;addon-google_apis-google-22" && \
echo y | sdkmanager "add-ons;addon-google_apis-google-21" && \
echo y | sdkmanager "platforms;android-25" && \
echo y | sdkmanager "platforms;android-23" && \
echo y | sdkmanager "build-tools;26.0.1" &&\
echo y | sdkmanager "build-tools;26.0.0" &&\
echo y | sdkmanager "build-tools;25.0.2" && \
echo y | sdkmanager "build-tools;25.0.1" && \
echo y | sdkmanager "build-tools;25.0.0" && \
echo y | sdkmanager "build-tools;24.0.0" && \
echo y | sdkmanager "build-tools;23.0.1" && \
echo y | sdkmanager "extras;android;m2repository" && \
echo y | sdkmanager "extras;google;m2repository" && \
echo y | sdkmanager "extras;google;google_play_services" && \
mkdir -p $ANDROID_HOME/licenses/ && \
echo "8933bad161af4178b1185d1a37fbf41ea5269c55" > $ANDROID_HOME/licenses/android-sdk-license && \
echo "84831b9409646a918e30573bab4c9c91346d8abd" > $ANDROID_HOME/licenses/android-sdk-preview-license


RUN cd /opt/ &&\
wget https://github.com/mattermost/mattermost-mobile/archive/v1.4.0.tar.gz &&\
tar xvf v1.4.0.tar.gz && \

RUN cd /opt/mattermost-mobile-1.4.0 && \
yarn install && \
make

