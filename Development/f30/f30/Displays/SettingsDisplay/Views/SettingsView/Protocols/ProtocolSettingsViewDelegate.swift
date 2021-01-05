//
//  ProtocolSettingsViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity

/// Defines a delegate for a SettingsView class
public protocol ProtocolSettingsViewDelegate: class {
	
	// MARK: - Methods

	func settingsView(isNotConnected error: Error?)
	
	func settingsView(isPresentingModalDialog sender: SettingsView)
	
	func settingsView(isHidingModalDialog sender: SettingsView)
	
	func settingsView(avatarImageChanged sender: SettingsView)
	
}
