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
		var m: Method
		var m1: Method
		var m2: Method
		
		let messageViewController: AnyClass? = NSClassFromString("MessageViewController")
		let dv_loaded = #selector(DetailsViewer.dv_loaded)
		let loaded = #selector(getter: MessageViewController.loaded)
		m = class_getInstanceMethod(DetailsViewer.self, dv_loaded)
		class_addMethod(messageViewController, dv_loaded, method_getImplementation(m), method_getTypeEncoding(m))
		m1 = class_getInstanceMethod(messageViewController, loaded)
		m2 = class_getInstanceMethod(messageViewController, dv_loaded)
		method_exchangeImplementations(m1, m2)
		
		let tableViewManager: AnyClass? = NSClassFromString("TableViewManager")
		let dv__prepareCell_withMessage = #selector(DetailsViewer.dv_prepare(cell: withMessage:))
		let _prepare_withMessage = #selector(TableViewManager._prepareCell(_: withMessage:))
		m = class_getInstanceMethod(DetailsViewer.self, dv__prepareCell_withMessage)
		class_addMethod(tableViewManager, dv__prepareCell_withMessage, method_getImplementation(m), method_getTypeEncoding(m))
		m1 = class_getInstanceMethod(tableViewManager, _prepare_withMessage)
		m2 = class_getInstanceMethod(tableViewManager, dv__prepareCell_withMessage)
		method_exchangeImplementations(m1, m2);
	}()

	override class func initialize() {
		_ = swizzle
	}

	dynamic func dv_loaded() -> Bool {
		let loaded = dv_loaded()
		guard loaded else {
			return loaded
		}
		var mutableSelf = self
		withUnsafePointer(to: &mutableSelf) { selfPointer in
			selfPointer.withMemoryRebound(to: MessageViewController.self, capacity: 1) { mvcPointer in
				let messageViewController = mvcPointer.pointee
				let headerViewController = messageViewController.headerViewController
				if !headerViewController.expandRecipients {
					headerViewController.detailsLink.performClick(self)
				}
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
		var mutableCell = cell
		withUnsafePointer(to: &mutableCell) { cellPointer in
			cellPointer.withMemoryRebound(to: RichMessageCellView.self, capacity: 1) { rmcvPointer in
				let richMessageCellView = rmcvPointer.pointee
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
}
