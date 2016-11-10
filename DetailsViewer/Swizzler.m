//
//  Swizzler.m
//  DetailsViewer
//
//  Created by Saagar Jha on 11/10/16.
//  Copyright © 2016 Saagar Jha. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>

#import "Swizzler.h"

#import "HeaderViewController.h"
#import "MessageViewController.h"

@implementation Swizzler

+ (void)load {
	static dispatch_once_t token;
	dispatch_once(&token, ^ {
		Class messageViewController = NSClassFromString(@"MessageViewController");
		SEL dv_loaded = @selector(dv_loaded);
		SEL loaded = @selector(loaded);
		Method m = class_getInstanceMethod([Swizzler class], dv_loaded);
		class_addMethod(messageViewController, dv_loaded, method_getImplementation(m), method_getTypeEncoding(m));
		Method m1 = class_getInstanceMethod(messageViewController, loaded);
		Method m2 = class_getInstanceMethod(messageViewController, dv_loaded);
		method_exchangeImplementations(m1, m2);
	});
}

- (BOOL)dv_loaded {
	BOOL loaded = [self dv_loaded];
	if (loaded && [self isKindOfClass:NSClassFromString(@"MessageViewController")]) {
		HeaderViewController* headerViewController = [(MessageViewController*) self headerViewController];
		if (![headerViewController expandRecipients]) {
			[[headerViewController detailsLink] performClick:self];
		}
	}
	return loaded;
}
@end
