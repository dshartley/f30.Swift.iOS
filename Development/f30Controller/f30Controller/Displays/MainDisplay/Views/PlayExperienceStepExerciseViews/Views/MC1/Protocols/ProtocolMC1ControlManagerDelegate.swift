//
//  ProtocolMC1ControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model
import f30View

/// Defines a delegate for a MC1ControlManager class
public protocol ProtocolMC1ControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func mc1ControlManager(createImg1For wrapper: Img1Wrapper) -> ProtocolImg1
	
}
