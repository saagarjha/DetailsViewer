//
//  TableViewManager.h
//  DetailsViewer
//
//  Created by Saagar Jha on 2/1/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

#ifndef TableViewManager_h
#define TableViewManager_h

#import "MFMessageThread.h"
#import "RichMessageCellView.h"

@interface TableViewManager : NSObject
- (void)_prepareCell:(RichMessageCellView *)cell withMessage:(MFMessageThread *)message;
@end

#endif /* TableViewManager_h */
