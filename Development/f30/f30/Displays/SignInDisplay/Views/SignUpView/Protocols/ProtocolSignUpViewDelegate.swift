//
//  ProtocolSignUpViewDelegate.swift
//  f30
//
//  Created by David on 08/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Defines a delegate for a SignUpView class
public protocol ProtocolSignUpViewDelegate: class {
	
	// MARK: - Methods
	
	func signUpView(signInInstead sender: SignUpView)
	
	func signUpView(signUp sender: SignUpView)
}
