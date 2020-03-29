//
//  DetailsViewer.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import Cocoa

@_cdecl("initialize_details_viewer")
func initialize_details_viewer() {
	_ = {
		var swizzler: Swizzler<@convention(c) (MessageViewController, Selector) -> Bool, @convention(block) (MessageViewController) -> Bool>!
		swizzler = .init(class: NSClassFromString("MessageViewController")!, selector: #selector(getter: MessageViewController.loaded)) { messageViewController in
			let loaded = swizzler.originalImplementation(messageViewController, swizzler.originalSelector)
			guard loaded else {
				return loaded
			}
			let headerViewController = messageViewController.headerViewController
			if !headerViewController.expandRecipients {
				headerViewController.detailsLink.performClick(messageViewController)
			}
			return loaded
		}
	}()

	_ = {
		let dateFormatter: DateFormatter = {
			let dateFormatter = DateFormatter()
			dateFormatter.timeStyle = .medium
			dateFormatter.dateStyle = .short
			return dateFormatter
		}()
		
		var swizzler: Swizzler<@convention(c) (TableViewManager, Selector, RichMessageCellView, MFMessageThread?) -> Void, @convention(block) (TableViewManager, RichMessageCellView, MFMessageThread?) -> Void>!
		swizzler = .init(class: NSClassFromString("TableViewManager")!, selector: #selector(TableViewManager._prepareCell(_: withMessage:))) { tableViewManager, cell, message in
			swizzler.originalImplementation(tableViewManager, swizzler.originalSelector, cell, message)
			guard let message = message else {
				return
			}
			cell.subjectView.toolTip = message.subject.subjectString
			cell.senderView.toolTip = message.sender
			cell.mailboxView.toolTip = message.mailbox.extendedDisplayName
			var toCc = ""
			if message.to.isEmpty {
				toCc += "To: \(message.to.joined(separator: ", "))\n"
			}
			if message.cc.isEmpty {
				toCc += "From: \(message.cc.joined(separator: ", "))"
			}
			cell.dateView.toolTip = "Sent: \(dateFormatter.string(from: message.newestMessage.dateSent))"
			cell.threadDisclosureControl.toolTip = "\(message.formattedUnreadMessageCount ?? "No") unread"
		}
	}()
	
	_ = {
		var sidebarButton: NSButton!
		
		var swizzler: Swizzler<@convention(c) (MailBarContainerView, Selector) -> Void, @convention(block) (MailBarContainerView) -> Void>!
		swizzler = .init(class: NSClassFromString("MailBarContainerView")!, selector: #selector(MailBarContainerView.awakeFromNib)) { mailBarContainerView in
			swizzler.originalImplementation(mailBarContainerView, swizzler.originalSelector)
			sidebarButton = mailBarContainerView.sidebarButton
			sidebarButton.removeFromSuperview()
		}
	}()
}
