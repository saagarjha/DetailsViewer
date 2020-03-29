//
//  MFMessageThread.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import Foundation

@objc
protocol MFMessageThread: MCMessage {
	var newestMessage: MCMessage { get set }
	var formattedUnreadMessageCount: String? { get set }
}
