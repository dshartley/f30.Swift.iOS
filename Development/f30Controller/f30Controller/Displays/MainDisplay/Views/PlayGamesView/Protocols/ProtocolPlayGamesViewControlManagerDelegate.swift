//
//  ProtocolPlayGamesViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a delegate for a PlayGamesViewControlManager class
public protocol ProtocolPlayGamesViewControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func playGamesViewControlManager(isNotConnected error: Error?)
	
}
