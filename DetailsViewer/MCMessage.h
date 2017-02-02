//
//  MCMessage.h
//  DetailsViewer
//
//  Created by Saagar Jha on 2/1/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

#ifndef MCMessage_h
#define MCMessage_h

#import "MFMailbox.h"

@interface MCMessage : NSObject
@property(copy) NSArray *cc;
@property(copy) NSArray *to;
@property(copy) NSString *sender;
@property(readonly) NSDate *dateSent;
@property(copy) NSString *subject;
@property(readonly, nonatomic) MFMailbox *mailbox;
@end

#endif /* MCMessage_h */
