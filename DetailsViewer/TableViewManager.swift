//
//  TableViewManager.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import Foundation

@objc
protocol TableViewManager {
	func _prepareCell(_ cell: RichMessageCellView, withMessage message: MFMessageThread?)
}
