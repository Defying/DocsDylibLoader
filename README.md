## DocsDylibLoader

loading and modifying a dylib after the app has been uploaded with Xcode

this is useful when an app has been uploaded to an iOS device with Xcode and you need to modify the dylib (example: change file path string to apps Documents folder), the next time you upload the app in Xcode, the container uuid changes.

this also drops a file in the application's `/Documents/container-uuid`. this is for automation of grabbing the uuid with something like [ios-deploy](https://github.com/phonegap/ios-deploy)

NOTE: if you're using this in conjunction with [TweakPatcher](https://github.com/Defying/TweakPatcher) and [theos-jailed](https://github.com/BishopFox/theos-jailed), you'll need to modify line 23 in `theos-jailed/bin/bootstrap.sh` to `CydiaSubstrate_LDFLAGS = -dynamiclib -install_name "@executable_path/cydiasubst"`
