//
//  Swizzler.swift
//  DetailsViewer
//
//  Created by Saagar Jha on 3/29/20.
//  Copyright © 2020 Saagar Jha. All rights reserved.
//

import Foundation

/// Encapsulates a swizzled Objective-C method. Implementation is an IMP type
/// (i.e. an `@convention(c)` function pointer with the reciever as the first
/// parameter and selector as the second) while Block is an Objective-C block
/// replacement suitable to be passed to `imp_implementationWithBlock` (i.e. an
/// `@convention(block)` block with the reciever as the first parameter).
struct Swizzler<Implementation, Block> {
	/// The original selector of the swizzled method.
	let originalSelector: Selector
	
	/// The original implementation of the swizzled method.
	let originalImplementation: Implementation
	
	/// Perform a swizzle.
	/// - Parameters:
	///   - class: The class to perform swizzling on
	///   - selector: The selector to swizzle
	///   - block: The code to replace the method with
	init(class: AnyClass, selector: Selector, block: Block) {
		originalSelector = selector
		let method = class_getInstanceMethod(`class`, selector)!
		let imp = imp_implementationWithBlock(block)
		class_addMethod(`class`, Selector("swizzle_\(selector)"), imp, method_getTypeEncoding(method))
		originalImplementation = unsafeBitCast(method_setImplementation(method, imp), to: Implementation.self)
	}
}
