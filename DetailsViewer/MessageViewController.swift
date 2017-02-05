//
//  MessageViewController.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/4/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import Foundation

@objc
protocol MessageViewController {
	var headerViewController: HeaderViewController { get set }
	var loaded: Bool { get set }
}
