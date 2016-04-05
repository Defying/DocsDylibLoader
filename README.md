## DocsDylibLoader

loading and modifying a dylib after the app has been uploaded with Xcode

this is useful when an app has been uploaded to an iOS device with Xcode and you need to modify the dylib (example: change file path string to apps Documents folder), the next time you upload the app in Xcode, the container uuid changes.

this also drops a file in `/Documents` named `DDL-` followed by the container uuid. this is for automation of grabbing the uuid via something like [ios-deploy](https://github.com/phonegap/ios-deploy)
