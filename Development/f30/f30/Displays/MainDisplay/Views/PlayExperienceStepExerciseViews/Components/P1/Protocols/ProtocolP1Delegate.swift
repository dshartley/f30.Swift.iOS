//
//  ProtocolP1Delegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30View
import f30Model

/// Defines a delegate for a P1 class
public protocol ProtocolP1Delegate: class {
	
	// MARK: - Methods
	
	func p1(tapped wrapper: P1Wrapper, sender: ProtocolP1)
	
}
