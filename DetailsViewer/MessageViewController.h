//
//  MessageViewController.h
//  DetailsViewer
//
//  Created by Saagar Jha on 11/10/16.
//  Copyright © 2016 Saagar Jha. All rights reserved.
//

#ifndef MessageViewController_h
#define MessageViewController_h

#import <AppKit/AppKit.h>
#import "HeaderViewController.h"

@interface MessageViewController : NSViewController
@property(retain, nonatomic) HeaderViewController *headerViewController;
@property(readonly, nonatomic) BOOL loaded;
@end

#endif /* MessageViewController_h */
