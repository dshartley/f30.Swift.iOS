//
//  ProtocolP1SubItemDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30View
import f30Model

/// Defines a delegate for a P1SubItem class
public protocol ProtocolP1SubItemDelegate: class {
	
	// MARK: - Methods
	
	func p1SubItem(tapped wrapper: P1SubItemWrapper, sender: ProtocolP1SubItem)
	
}
