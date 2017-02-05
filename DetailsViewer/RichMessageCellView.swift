//
//  RichMessageCellView.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import AppKit

@objc
protocol RichMessageCellView {
	var mailboxView: NSTextField { get set }
	var threadDisclosureControl: ThreadDisclosureTextField { get set }
	var toCcIndicator: _ToCCIndicator { get set }
	var dateView: NSTextField { get set }
	var snippetView: NSTextField { get set }
	var subjectView: NSTextField { get set }
	var senderView: NSTextField { get set }
}
