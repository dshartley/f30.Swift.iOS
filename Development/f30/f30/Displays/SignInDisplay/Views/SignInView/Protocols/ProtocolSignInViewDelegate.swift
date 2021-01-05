//
//  ProtocolSignInViewDelegate.swift
//  f30
//
//  Created by David on 08/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity

/// Defines a delegate for a SignInView class
public protocol ProtocolSignInViewDelegate: class {
	
	// MARK: - Methods
	
	func signInView(signUpInstead sender: SignInView)

	func signInView(signInWithEmail sender: SignInView)
	
	func signInView(signInWithTwitter attributes: [String : Any]?,
	                error: 	Error?,
	                code: 	AuthenticationErrorCodes?,
	                sender: SignInView)
	
	func signInView(signInWithFacebook attributes: [String : Any]?,
	                error: 	Error?,
	                code: 	AuthenticationErrorCodes?,
	                sender: SignInView)
	
	func signInView(recoverPassword sender: SignInView)
	
}
