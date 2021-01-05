//
//  ProtocolAuthenticationViewDelegate.swift
//  f30
//
//  Created by David on 02/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity

/// Defines a delegate for a AuthenticationView class
public protocol ProtocolAuthenticationViewDelegate: class {
	
	// MARK: - Methods
	
	func authenticationView(isSigningIn sender: AuthenticationView)
	
	func authenticationView(signInSuccessful userProperties: UserProperties)
	
	func authenticationView(signInFailed userProperties: UserProperties?,
	                        error: 	Error?,
	                        code: 	AuthenticationErrorCodes?)
	
	func authenticationView(isSigningUp sender: AuthenticationView)
	
	func authenticationView(signUpSuccessful userProperties: UserProperties)
	
	func authenticationView(signUpFailed userProperties: UserProperties?,
	                        error: 	Error?,
	                        code: 	AuthenticationErrorCodes?)

	func authenticationView(isRecoveringPassword sender: AuthenticationView)
	
	func authenticationView(recoverPasswordSuccessful sender: AuthenticationView)
	
	func authenticationView(recoverPasswordFailed error: Error?,
	                        code: 	AuthenticationErrorCodes?)
	
}
