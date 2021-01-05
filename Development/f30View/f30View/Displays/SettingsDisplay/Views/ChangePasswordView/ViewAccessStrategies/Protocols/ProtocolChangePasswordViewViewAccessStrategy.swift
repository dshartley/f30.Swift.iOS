//
//  ProtocolChangePasswordViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 29/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a class which provides a strategy for accessing the ChangePasswordView view
public protocol ProtocolChangePasswordViewViewAccessStrategy {
	
	// MARK: - Methods
	
	func getFromPassword() -> String
	
	func getToPassword() -> String
	
}
