//
//  ProtocolChangePasswordViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 29/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity

/// Defines a delegate for a ChangePasswordViewControlManager class
public protocol ProtocolChangePasswordViewControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func changePasswordViewControlManager(changePasswordSuccessful sender: ChangePasswordViewControlManager)
	
	func changePasswordViewControlManager(changePasswordFailed error: Error?,
										  code: 	AuthenticationErrorCodes?)
	
}

