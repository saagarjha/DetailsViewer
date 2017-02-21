//
//  DetailsViewer.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import Foundation

@objc(DetailsViewer)
class DetailsViewer: NSObject {
	private static let swizzle: () = {
		let messageViewController: AnyClass? = NSClassFromString("MessageViewController")
		let loaded = #selector(getter: MessageViewController.loaded)
		let dv_loaded = #selector(DetailsViewer.dv_loaded)
		SwizzlingUtilities.swizzle(selector: loaded, forInstancesOf: messageViewController, with: dv_loaded, from: DetailsViewer.self)

		let tableViewManager: AnyClass? = NSClassFromString("TableViewManager")
		let _prepare_withMessage = #selector(TableViewManager._prepareCell(_: withMessage:))
		let dv__prepareCell_withMessage = #selector(DetailsViewer.dv_prepare(cell: withMessage:))
		SwizzlingUtilities.swizzle(selector: _prepare_withMessage, forInstancesOf: tableViewManager, with: dv__prepareCell_withMessage, from: DetailsViewer.self)
	}()

	override class func initialize() {
		_ = swizzle
	}
	
	dynamic func dv_loaded() -> Bool {
		let loaded = dv_loaded()
		guard loaded else {
			return loaded
		}
		SwizzlingUtilities.rebind(self, to: MessageViewController.self) { messageViewController in
			let headerViewController = messageViewController.headerViewController
			if !headerViewController.expandRecipients {
				headerViewController.detailsLink.performClick(self)
			}
		}
		return loaded
	}

	private static var dateFormatter: DateFormatter = {
		let dateFormatter = DateFormatter()
		dateFormatter.timeStyle = .medium
		dateFormatter.dateStyle = .short
		return dateFormatter
	}()

	dynamic func dv_prepare(cell: RichMessageCellView, withMessage message: MFMessageThread) {
		dv_prepare(cell: cell, withMessage: message)
		SwizzlingUtilities.rebind(cell, to: RichMessageCellView.self) { richMessageCellView in
			richMessageCellView.subjectView.toolTip = message.subject
			richMessageCellView.senderView.toolTip = message.sender
			richMessageCellView.mailboxView.toolTip = message.mailbox.extendedDisplayName
			var toCc = ""
			if message.to.isEmpty {
				toCc += "To: \(message.to.joined(separator: ", "))\n"
			}
			if message.cc.isEmpty {
				toCc += "From: \(message.cc.joined(separator: ", "))"
			}
			richMessageCellView.dateView.toolTip = "Sent: \(DetailsViewer.dateFormatter.string(from: message.newestMessage.dateSent))"
			richMessageCellView.threadDisclosureControl.toolTip = "\(message.formattedUnreadMessageCount ?? "No") unread"
		}
	}
}
