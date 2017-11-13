# mm_builder

## to build this image
```
$git clone https://github.com/syamgk/mm_builder
$cd mm_builder
$docker build -t <your_tag_name_here> .
```

## to build the apk

once the image build get successfull
run the container using the below command
```
$docker run -it <image name> bash
```

then create a key using keytool and place it at /opt/mattermost-mobile-1.3.0/android/keystores/my-release-key.keystore
```
keytool -genkey -v -keystore my-release-key.keystore -alias alias_name -keyalg RSA -keysize 2048 -validity 10000
```

add the variables to gradle.properties
```
vi /opt/mattermost-mobile-1.3.0/android/gradle.properties
```

add the below lines to the bottom of the file; do change the variables according the key generated above
```
MATTERMOST_RELEASE_STORE_FILE=../keystores/my-release-key.keystore
MATTERMOST_RELEASE_PASSWORD=password
MATTERMOST_RELEASE_KEY_ALIAS=alias_name
MATTERMOST_MARELEASE_KEY_PASSWORD=password

```

also you can add DefaultServerUrl in file `/opt/mattermost-mobile/dist/assets/config.json`

##### if you are using your own [push-proxy-server](https://github.com/mattermost/mattermost-push-proxy) setup  

replace the google-services.json file in mattermost-mobile/android/app/google-services.json with the one generated from Firebase console.

replace the value of `com.wix.reactnativenotifications.gcmSenderId` with the `Sender ID:` generated from console.firebase.google.com on file `mattermost-mobile/android/app/src/main/AndroidManifest.xml`

eg :
```
 <meta-data android:name="com.wix.reactnativenotifications.gcmSenderId" android:value="<SenderID_here>\0"/>
  
```
and replace the `/opt/mattermost-mobile-1.3.0/android/app/google-services.json`
with the one which generated from console.firebase.google.com


