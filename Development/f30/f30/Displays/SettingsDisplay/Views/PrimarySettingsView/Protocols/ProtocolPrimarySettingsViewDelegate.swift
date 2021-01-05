//
//  ProtocolPrimarySettingsViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Defines a delegate for a PrimarySettingsView class
public protocol ProtocolPrimarySettingsViewDelegate: class {
	
	// MARK: - Methods

	func primarySettingsView(changePasswordButtonTapped sender: PrimarySettingsView)
	
	func primarySettingsView(avatarImageChanged sender: PrimarySettingsView)
	
}
