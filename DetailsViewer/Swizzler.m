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

#import "_ToCCIndicator.h"
#import "MCMessage.h"
#import "MessageViewController.h"
#import "MFMailbox.h"
#import "HeaderViewController.h"
#import "RichMessageCellView.h"
#import "RichMessageCellBase.h"
#import "TableViewManager.h"
#import "ThreadDisclosureTextField.h"

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
		Class tableViewManager = NSClassFromString(@"TableViewManager");
		SEL dv__prepareCell_withMessage = @selector(dv__prepareCell:withMessage:);
		SEL _prepare_withMessage = @selector(_prepareCell:withMessage:);
		m = class_getInstanceMethod([Swizzler class], dv__prepareCell_withMessage);
		class_addMethod(tableViewManager, dv__prepareCell_withMessage, method_getImplementation(m), method_getTypeEncoding(m));
		m1 = class_getInstanceMethod(tableViewManager, _prepare_withMessage);
		m2 = class_getInstanceMethod(tableViewManager, dv__prepareCell_withMessage);
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

- (void)dv__prepareCell:(RichMessageCellBase *)cell withMessage:(MFMessageThread *)message {
	[self dv__prepareCell:cell withMessage:message];
	
	static NSDateFormatter *dateFormatter;
	if (!dateFormatter) {
		dateFormatter = [[NSDateFormatter alloc] init];
		dateFormatter.locale = [NSLocale currentLocale];
		dateFormatter.timeStyle = NSDateFormatterMediumStyle;
		dateFormatter.dateStyle = NSDateFormatterShortStyle;
	}
	if ([cell isKindOfClass:NSClassFromString(@"RichMessageCellView")]) {
		RichMessageCellView *cellView = (RichMessageCellView *)cell;
		cellView.subjectView.toolTip = message.subject;
		cellView.senderView.toolTip = message.sender;
		cellView.dateView.toolTip = [NSString stringWithFormat:@"Sent: %@", [dateFormatter stringFromDate:message.newestMessage.dateSent]];
		NSMutableString *toCc = [[NSMutableString alloc] init];
		if (message.to.count > 0) {
			[toCc appendString:@"To: "];
			[toCc appendString:[message.to componentsJoinedByString:@", "]];
		}
		if (message.cc.count > 0) {
			[toCc appendString:@"Cc: "];
			[toCc appendString:[message.cc componentsJoinedByString:@", "]];
		}
		cellView.toCcIndicator.toolTip = toCc;
		cellView.mailboxView.toolTip = message.mailbox.extendedDisplayName;
		cellView.threadDisclosureControl.toolTip = [NSString stringWithFormat:@"%@ %@", message.formattedUnreadMessageCount, @"unread"];
	}
}

@end
