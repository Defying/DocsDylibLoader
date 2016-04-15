#import <dlfcn.h>

%ctor {
	NSArray 	*paths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
	NSString	*documentsDirectory = [paths objectAtIndex:0];
	NSString	*dylibPath = [NSString stringWithFormat:@"%@/%@", documentsDirectory,@"AppPlus.dylib"];
	NSString	*uuid = [documentsDirectory substringWithRange:NSMakeRange(40, 36)];
	NSString	*uuidPath = [NSString stringWithFormat:@"%@/container-uuid", documentsDirectory];
	NSLog(@"[DocsDylibLoader] UUID: %@", uuid);
	[uuid writeToFile:uuidPath atomically:YES encoding:NSUTF8StringEncoding error:nil];
	NSLog(@"[DocsDylibLoader] Loading dylib: %@", dylibPath);
	dlopen([dylibPath cStringUsingEncoding:NSUTF8StringEncoding], RTLD_NOW);
}
