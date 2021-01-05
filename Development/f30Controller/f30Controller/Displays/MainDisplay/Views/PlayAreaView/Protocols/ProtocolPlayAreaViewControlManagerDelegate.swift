//
//  ProtocolPlayAreaViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape
import f30Model
import f30View
import f30Core

/// Defines a delegate for a PlayAreaViewControlManager class
public protocol ProtocolPlayAreaViewControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func playAreaViewControlManager(isNotConnected error: Error?)
	
}
