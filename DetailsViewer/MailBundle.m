//
//  MailBundle.m
//  DetailsViewer
//
//  Created by Saagar Jha on 11/10/16.
//  Copyright © 2016 Saagar Jha. All rights reserved.
//

#import <objc/runtime.h>
#import <Foundation/Foundation.h>
#import "MVMailBundle.h"
#import "MailBundle.h"

@implementation MailBundle
+ (void)initialize {
	Class mailBundleClass = NSClassFromString(@"MVMailBundle");
#pragma GCC diagnostic push
#pragma GCC diagnostic ignored "-Wdeprecated"
	class_setSuperclass([self class], mailBundleClass);
#pragma GCC diagnostic pop
	[[((MailBundle*)self) class] registerBundle];
}
@end
