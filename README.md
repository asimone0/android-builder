# android-builder

A dockerfile to create an image that contains an debian-based environment suitable for building android applications.

`The resulting image is quite large (depending on sdk components selected)`

## Important project note: 
The project *must not* define the android sdk location 

(for example, in a `local.properties` file)

Doing so will conflict with the container's configuration

## Customizing
Do do a bug in sdkmanager (https://issuetracker.google.com/issues/66465833) the --package_file flag is currently unreliable and is not used.

Components are installed in the command line within the dockerfile.

Add sdkmanager commands inline as desired to customize the build environment output.

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

