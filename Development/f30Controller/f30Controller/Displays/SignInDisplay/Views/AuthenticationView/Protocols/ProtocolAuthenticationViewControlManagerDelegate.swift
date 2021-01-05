//
//  ProtocolAuthenticationViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 03/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity

/// Defines a delegate for a AuthenticationViewControlManager class
public protocol ProtocolAuthenticationViewControlManagerDelegate: class {

	// MARK: - Methods
	
	func authenticationViewControlManager(signInSuccessful userProperties: UserProperties)
	
	func authenticationViewControlManager(signInFailed userProperties: UserProperties?,
	                                      error: 	Error?,
	                                      code: 	AuthenticationErrorCodes?)
	
	func authenticationViewControlManager(signUpSuccessful userProperties: UserProperties)
	
	func authenticationViewControlManager(signUpFailed userProperties: UserProperties?,
	                                      error: 	Error?,
	                                      code: 	AuthenticationErrorCodes?)
	
	func authenticationViewControlManager(recoverPasswordSuccessful sender: AuthenticationViewControlManager)
	
	func authenticationViewControlManager(recoverPasswordFailed error: Error?,
	                                      code: 	AuthenticationErrorCodes?)
	
}
