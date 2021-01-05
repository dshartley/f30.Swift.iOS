//
//  AuthenticationViewViewManager.swift
//  f30View
//
//  Created by David on 03/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFView
import f30Core

/// Manages the AuthenticationView view layer
public class AuthenticationViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolAuthenticationViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolAuthenticationViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func clearTextFields() {
		
		self.viewAccessStrategy!.clearTextFields()
	}
	
	public func getSignInEmail() -> String {
		
		return self.viewAccessStrategy!.getSignInEmail()
	}
	
	public func getSignInPassword() -> String {
		
		return self.viewAccessStrategy!.getSignInPassword()
	}
	
	public func getSignUpEmail() -> String {
		
		return self.viewAccessStrategy!.getSignUpEmail()
	}
	
	public func getSignUpPassword() -> String {
		
		return self.viewAccessStrategy!.getSignUpPassword()
	}
	
	public func getSignUpDateofBirth() -> Date {
		
		return self.viewAccessStrategy!.getSignUpDateofBirth()
	}
	
	public func getRecoverPasswordEmail() -> String {
		
		return self.viewAccessStrategy!.getRecoverPasswordEmail()
	}
	
}
