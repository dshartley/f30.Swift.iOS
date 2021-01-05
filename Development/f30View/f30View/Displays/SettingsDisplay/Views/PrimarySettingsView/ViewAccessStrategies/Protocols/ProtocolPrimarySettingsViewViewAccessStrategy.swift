//
//  ProtocolPrimarySettingsViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a class which provides a strategy for accessing the PrimarySettingsView view
public protocol ProtocolPrimarySettingsViewViewAccessStrategy {
	
	// MARK: - Methods

	func displayAvatar(image: UIImage)
	
	func getAvatarImage() -> UIImage?
	
	func getFullName() -> String
	
	func displayFullName(value: String)
	
	func displayDateofBirth(dateofBirth: Date)
	
	func getDateofBirth() -> Date
	
	func displayAppSetting(value: Bool)
	
	func getAppSetting() -> Bool
	
}
