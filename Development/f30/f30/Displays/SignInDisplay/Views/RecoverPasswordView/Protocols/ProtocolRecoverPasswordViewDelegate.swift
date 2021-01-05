//
//  ProtocolRecoverPasswordViewDelegate.swift
//  f30
//
//  Created by David on 13/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Defines a delegate for a RecoverPasswordView class
public protocol ProtocolRecoverPasswordViewDelegate: class {
	
	// MARK: - Methods

	func recoverPasswordView(cancel sender: RecoverPasswordView)
	
	func recoverPasswordView(recoverPasswordWithEmail sender: RecoverPasswordView)
	
}
