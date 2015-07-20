![Batch SDK](https://raw.github.com/BatchLabs/air-plugin/master/readme_logo.png)

# Batch SDK AIR extension

This repository contains the source code of Batch SDK Air Native Extension. With this extension, you'll be able to use all of Batch SDK features directly in an ActionScript 3 AIR app.

### Structure

The project contains the following part : 
- An Android extension to wrap Android Native code to AIR. It's an Android Eclipse project, located in the _androidExtension_ folder.
- An iOS extension to wrap iOS Native code to AIR. It's an Xcode Objective-C project, located in the _iosExtension_ folder.
- The AIR library, that makes Batch API available to ActionScript. It's an ActionScript 3 project, located in the _lib_ folder.
- The AIR Stub library, that allow the Extension to be runned into an AIR Simulator. It's an ActionScript 3 project that contains the same classes as the real library but with stub implementation (no real call to Batch native apis). It's located in the _stubLibrary_ projet.
- An ant build script (_build.xml_) at the root, associated with a _build.config_ script that you must create out of the _exemple.build.config_ file with path to your SDKs.
- An _include_ folder that contains all native assets to build the ANE.

### Include folder

The _include_ folder contains 4 native asserts for iOS and Android to generate the ANE:

- _android-support-v4.jar_: The Android Support Library jar. Used to build the ANE with PlayServices included.
- _google-play-services_lib_ folder: Google Play Services project with both jar and resources. It's used to build the ANE with PlayServices included.
- _Batch_: Batch Android SDK Eclipse project.
- _Batch.framework_ & _Batch.bundle_: Batch iOS Framework & resources.

> **Important notice**: All Java jars must be compiled for Java 6. All files that are compiled for Java 7 will be ignored by the AIR compiler and will not be included into the ANE. This is an AIR limitation.

### Compatibility

The extension is compatible with **AIR 4** and has been built an tested with **AIR 18** and **Flex SDK 4.14.1**. If you want to use a different Flex or AIR SDK, you may have to update the code according to new syntaxt and build tools.
 
### How to build

To build the ANE you should create a _build.config_ out of the sample file provided (_exemple.build.config_). Simply put the path to your Flex SDK, Android SDK and Android PlatformTools and rename the file _build.config_.

Then you can run the ant build script. To build the ANE, simply run the following command at the root of the repository:

```
ant
```

It will generate 2 files at the root of the repository:
- Batch-ANE.ane : The Batch Air Native Extension
- Batch-ANE-GPS.ane : Same extension but with PlayServices included


### Generate ASDoc

To build the doc you can use the ant build:

```
ant doc
```

It will generate the AsDoc under the _doc_ folder.


