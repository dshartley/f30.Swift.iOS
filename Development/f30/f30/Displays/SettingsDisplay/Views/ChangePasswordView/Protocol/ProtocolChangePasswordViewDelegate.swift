//
//  ProtocolChangePasswordViewDelegate.swift
//  f30
//
//  Created by David on 29/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Defines a delegate for a ChangePasswordView class
public protocol ProtocolChangePasswordViewDelegate: class {
	
	// MARK: - Methods
	
	func changePasswordView(cancelButtonTapped sender: ChangePasswordView)
	
	func changePasswordView(doneButtonTapped sender: ChangePasswordView)
	
}
