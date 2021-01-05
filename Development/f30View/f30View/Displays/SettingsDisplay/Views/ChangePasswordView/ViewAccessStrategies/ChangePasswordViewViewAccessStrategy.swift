//
//  ChangePasswordViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 29/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the ChangePasswordView view
public class ChangePasswordViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties
	
	fileprivate var fromPasswordTextField: 	UITextField?
	fileprivate var toPasswordTextField: 	UITextField?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(toPasswordTextField: 		UITextField,
					  fromPasswordTextField: 	UITextField) {

		self.toPasswordTextField 	= toPasswordTextField
		self.fromPasswordTextField 	= fromPasswordTextField
		
	}
	
}

// MARK: - Extension ProtocolChangePasswordViewViewAccessStrategy

extension ChangePasswordViewViewAccessStrategy: ProtocolChangePasswordViewViewAccessStrategy {

	// MARK: - Methods
	
	public func getFromPassword() -> String {
		
		return self.fromPasswordTextField!.text ?? ""
		
	}
	
	public func getToPassword() -> String {
		
		return self.toPasswordTextField!.text ?? ""
		
	}
	
}
