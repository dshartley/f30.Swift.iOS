//
//  ProtocolSignInDisplayViewControllerDelegate.swift
//  f30
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a delegate for a SignInDisplayViewController class
public protocol ProtocolSignInDisplayViewControllerDelegate: class {
	
	// MARK: - Methods
	
	func signInDisplayViewController(dismiss controller: UIViewController)

}
