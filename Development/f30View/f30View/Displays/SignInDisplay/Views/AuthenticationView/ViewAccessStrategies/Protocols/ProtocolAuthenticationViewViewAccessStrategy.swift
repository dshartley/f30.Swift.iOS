//
//  ProtocolAuthenticationViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 02/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Defines a class which provides a strategy for accessing the AuthenticationView view
public protocol ProtocolAuthenticationViewViewAccessStrategy {
	
	// MARK: - Methods
	
	func clearTextFields() -> Void

	func getSignInEmail() -> String
	
	func getSignInPassword() -> String
	
	func getSignUpEmail() -> String
	
	func getSignUpPassword() -> String
	
	func getSignUpDateofBirth() -> Date
	
	func getRecoverPasswordEmail() -> String
	
}
