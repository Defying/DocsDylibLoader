#import "substrate.h"
#import <dlfcn.h>

NSString	*error;
NSArray 	*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
NSString	*documentsDirectory = [paths objectAtIndex:0];
NSString	*dylibPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"AppPlus.dylib"];
NSString	*errorReasonMsg = [NSString stringWithFormat:@"%@\n%@", error, documentsDirectory];
NSString	*uuid = [documentsDirectory substringWithRange:NSMakeRange(40, 36)];
NSString	*uuidPath = [NSString stringWithFormat:@"%@/container-uuid", documentsDirectory];

%hook AppDelegate
- (void)initializeServices {
	%orig;
	NSLog(@"[DocsDylibLoader] UUID: %@", uuid);
	[uuid writeToFile:uuidPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
	if (dylibPath != nil) {
		NSLog(@"[DocsDylibLoader] Loading dylib: %@", dylibPath);
		void *DocsDylibLoader = dlopen([dylibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
		if (DocsDylibLoader == NULL) {
			error = [NSString stringWithUTF8String:dlerror()];
		} else {
			return;
		}
	} else {
		error = @"Dylib not found.";
	}
	if (error != nil) {
		UIAlertController *alert = [UIAlertController alertControllerWithTitle:@"Failed to load dylib" message:errorReasonMsg preferredStyle:UIAlertControllerStyleAlert];
		[alert addAction:[UIAlertAction actionWithTitle:@"OK ☹️" style:UIAlertActionStyleDefault handler:nil]];
		[[[[[UIApplication sharedApplication] windows] firstObject] rootViewController] presentViewController:alert animated:YES completion:nil];
	}
}
%end
