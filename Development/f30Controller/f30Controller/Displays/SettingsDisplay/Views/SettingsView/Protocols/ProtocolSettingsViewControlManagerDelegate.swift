//
//  ProtocolSettingsViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSecurity

/// Defines a delegate for a ProtocolSettingsViewControlManager class
public protocol ProtocolSettingsViewControlManagerDelegate: class {

	// MARK: - Methods

	func settingsViewControlManager(isNotConnected error: Error?)
	
}
