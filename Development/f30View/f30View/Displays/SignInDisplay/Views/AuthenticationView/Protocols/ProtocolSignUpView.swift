//
//  ProtocolSignUpView.swift
//  f30View
//
//  Created by David on 08/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a class which is a SignUpView
public protocol ProtocolSignUpView {
	
	// MARK: - Stored Properties
	
	weak var emailTextField:		UITextField! { get }
	weak var passwordTextField:		UITextField! { get }
	
	
	// MARK: - Methods
	
	func getDateofBirth() -> Date
	
}
