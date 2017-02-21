//
//  SwizzlingUtilities.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 2/21/17.
//  Copyright © 2017 Saagar Jha. All rights reserved.
//

import Foundation

/// Utilities for method swizzling in Swift
enum SwizzlingUtilities {

	/// Swizzles the instance method pointed to by selector 1 in class1 with the
	/// method in class2 pointed to by selector2.
	///
	/// - Parameters:
	///   - selector1: The selector for the target instance method
	///   - class1: The target class
	///   - selector2: The selector for the replacement method
	///   - class2: The class impementing the replacement
	static func swizzle(selector selector1: Selector, forInstancesOf class1: AnyClass?, with selector2: Selector, from class2: AnyClass) {
		let m = class_getInstanceMethod(class2, selector2)
		class_addMethod(class1, selector2, method_getImplementation(m), method_getTypeEncoding(m))
		let m1 = class_getInstanceMethod(class1, selector1)
		let m2 = class_getInstanceMethod(class1, selector2)
		method_exchangeImplementations(m1, m2)
	}

	/// Rebinds an object to another type using duck typing and performs the
	/// specified task if the cast was successful.
	///
	/// - Parameters:
	///   - object: The object to rebind
	///   - type: The type to rebind to
	///   - task: The task to run with the rebound object
	static func rebind<T, Result>(_ object: T, to type: Result.Type, andPerform task: (Result) -> Void) {
		// This is a hack, since type(of: object) == type doesn't work well with
		// class clusters or KVO
		guard var object = object as? NSObject,
			object.className == _typeName(type, qualified: false) else {
				return
		}
		withUnsafePointer(to: &object) { pointer in
			pointer.withMemoryRebound(to: type, capacity: 1) { pointer in
				task(pointer.pointee)
			}
		}
	}
}
