//
//  ProtocolMP1ControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model
import f30View

/// Defines a delegate for a MP1ControlManager class
public protocol ProtocolMP1ControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func mp1ControlManager(createP1SubItemFor wrapper: P1SubItemWrapper) -> ProtocolP1SubItem
	
}
