//
//  MCMessage.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import Foundation

@objc
protocol MCMessage {
	var cc: [String] { get set }
	var to: [String] { get set }
	var sender: String { get set }
	var dateSent: Date { get set }
	var subject: ECSubject { get set }
	var mailbox: MFMailbox { get set }
}
