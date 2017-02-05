//
//  HeaderViewController.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import AppKit

@objc
protocol HeaderViewController {
	var detailsLink: NSButton { get set }
	var expandRecipients: Bool { get set }
}
