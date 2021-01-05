//
//  ProtocolSettingsDisplayViewControllerDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a delegate for a SettingsDisplayViewController class
public protocol ProtocolSettingsDisplayViewControllerDelegate: class {
	
	// MARK: - Methods
	
	func settingsDisplayViewController(dismiss controller: UIViewController)
	
	func settingsDisplayViewController(avatarImageChanged sender: UIViewController)
	
}
