//
//  RichMessageCellView.h
//  DetailsViewer
//
//  Created by Saagar Jha on 2/1/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

#ifndef RichMessageCellView_h
#define RichMessageCellView_h

#import "ThreadDisclosureTextField.h"

@interface RichMessageCellView : NSObject
@property(retain, nonatomic) NSTextField *mailboxView;
@property(retain, nonatomic) ThreadDisclosureTextField *threadDisclosureControl;
@property(retain, nonatomic) _ToCCIndicator *toCcIndicator;
@property(nonatomic) __weak NSTextField *dateView;
@property(nonatomic) __weak NSTextField *snippetView;
@property(nonatomic) __weak NSTextField *subjectView;
@property(nonatomic) __weak NSTextField *senderView;
@end

#endif /* RichMessageCellView_h */
