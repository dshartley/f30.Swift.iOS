//
//  ProtocolSettingsDisplayControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 14/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity

/// Defines a delegate for a SettingsDisplayControlManager class
public protocol ProtocolSettingsDisplayControlManagerDelegate: class {
	
	// MARK: - Methods

	func settingsDisplayControlManager(isNotConnected error: Error?)
	
}
