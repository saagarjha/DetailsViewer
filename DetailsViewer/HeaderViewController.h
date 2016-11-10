//
//  HeaderViewController.h
//  DetailsViewer
//
//  Created by Saagar Jha on 11/10/16.
//  Copyright © 2016 Saagar Jha. All rights reserved.
//

#ifndef HeaderViewController_h
#define HeaderViewController_h

#import <AppKit/AppKit.h>

@interface HeaderViewController : NSViewController {
}
@property(readonly, nonatomic) NSButton *detailsLink;
@property(nonatomic) BOOL expandRecipients;
@end

#endif /* HeaderViewController_h */
