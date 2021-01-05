//
//  ProtocolImg1Delegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30View
import f30Model

/// Defines a delegate for a Img1 class
public protocol ProtocolImg1Delegate: class {
	
	// MARK: - Methods
	
	func img1(tapped wrapper: Img1Wrapper, sender: ProtocolImg1)
	
}
