//
//  MFMessageThread.h
//  DetailsViewer
//
//  Created by Saagar Jha on 2/1/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

#ifndef MFMessageThread_h
#define MFMessageThread_h

@interface MFMessageThread : MCMessage
@property(readonly) MCMessage *newestMessage;
@property(readonly, copy) NSString *formattedUnreadMessageCount;
@end

#endif /* MFMessageThread_h */
