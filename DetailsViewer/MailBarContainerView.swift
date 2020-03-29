//
//  MailBarContainerView.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 3/29/20.
//  Copyright © 2020 Saagar Jha. All rights reserved.
//

import AppKit

@objc
protocol MailBarContainerView {
	var sidebarButton: NSButton { get set }
	func awakeFromNib()
}
