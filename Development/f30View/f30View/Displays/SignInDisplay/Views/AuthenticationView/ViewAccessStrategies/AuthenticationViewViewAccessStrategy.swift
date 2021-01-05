//
//  AuthenticationViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 02/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// A strategy for accessing the AuthenticationView view
public class AuthenticationViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties
	
	fileprivate var signInView:				ProtocolSignInView?
	fileprivate var signUpView:				ProtocolSignUpView?
	fileprivate var recoverPasswordView:	ProtocolRecoverPasswordView?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(	signInView: 			ProtocolSignInView,
	                  	signUpView:				ProtocolSignUpView,
	                  	recoverPasswordView:	ProtocolRecoverPasswordView) {
		
		self.signInView				= signInView
		self.signUpView 			= signUpView
		self.recoverPasswordView 	= recoverPasswordView

	}
	
}

// MARK: - Extension ProtocolLoginDisplayViewAccessStrategy

extension AuthenticationViewViewAccessStrategy: ProtocolAuthenticationViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func clearTextFields() {
		
		self.signInView!.emailTextField!.text		= ""
		self.signInView!.passwordTextField!.text	= ""
		self.signUpView!.emailTextField!.text		= ""
		self.signUpView!.passwordTextField!.text	= ""
		
	}
	
	public func getSignInEmail() -> String {
		
		return self.signInView!.emailTextField!.text ?? ""
	}
	
	public func getSignInPassword() -> String {
		
		return self.signInView!.passwordTextField!.text ?? ""
	}
	
	public func getSignUpEmail() -> String {
		
		return self.signUpView!.emailTextField!.text ?? ""
	}
	
	public func getSignUpPassword() -> String {
		
		return self.signUpView!.passwordTextField!.text ?? ""
	}
	
	public func getSignUpDateofBirth() -> Date {
		
		return self.signUpView!.getDateofBirth()
	}
	
	public func getRecoverPasswordEmail() -> String {
		
		return self.recoverPasswordView!.emailTextField!.text ?? ""
	}
	
}
