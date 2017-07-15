# android-builder

A dockerfile to create an image that contains an debian-based environment suitable for building android applications.

`Note`: The resulting image is quite large (depending on sdk components selected)

## Customizing
The android environment is installed in the image using the android `sdkmanager` based on the the contents of `android-sdk-config\install`

## Building
```sh
docker build -t <image:tag> .
```

## Usage
When executing, mount a volume that maps the local project directory to _/project_

For example, from the _root_ of an android project:

```sh
docker run -v $PWD:/project <image:tag> ./gradlew clean assembleDebug
```

Useful information about the environment can be seen with the following command
```sh
docker run <image:tag> java -version && sdkmanager --list
```