//
//  PrimarySettingsViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the PrimarySettingsView view
public class PrimarySettingsViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties
	
	fileprivate var avatarImageView: 			UIImageView?
	fileprivate var fullNameTextField: 			UITextField!
	fileprivate var dateofBirthTextField: 		UITextField?
	fileprivate var dateofBirthDatePicker: 		UIDatePicker?
	fileprivate var appSettingSwitch: 			UISwitch!
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(avatarImageView: 			UIImageView,
					  fullNameTextField: 		UITextField,
	                  dateofBirthTextField: 	UITextField,
	                  dateofBirthDatePicker: 	UIDatePicker,
	                  appSettingSwitch: 		UISwitch) {
		
		self.avatarImageView 		= avatarImageView
		self.fullNameTextField 		= fullNameTextField
		self.dateofBirthTextField 	= dateofBirthTextField
		self.dateofBirthDatePicker 	= dateofBirthDatePicker
		self.appSettingSwitch 		= appSettingSwitch
		
	}
	
}

// MARK: - Extension ProtocolPrimarySettingsViewViewAccessStrategy

extension PrimarySettingsViewViewAccessStrategy: ProtocolPrimarySettingsViewViewAccessStrategy {
	
	// MARK: - Methods

	public func displayAvatar(image: UIImage) {
		
		self.avatarImageView!.image = image
		
	}
	
	public func getAvatarImage() -> UIImage? {
		
		return self.avatarImageView!.image
	}

	public func getFullName() -> String {
		
		return self.fullNameTextField!.text ?? ""
	}
	
	public func displayFullName(value: String) {
		
		self.fullNameTextField!.text = value
	}
	
	public func displayDateofBirth(dateofBirth: Date) {
	
		self.dateofBirthDatePicker!.setDate(dateofBirth, animated: false)

		let dateFormatter: 					DateFormatter = DateFormatter()
		dateFormatter.dateStyle 			= .medium
		dateFormatter.timeZone 				= TimeZone(secondsFromGMT: 0)
		
		self.dateofBirthTextField!.text 	= dateFormatter.string(from: dateofBirth)
		
	}
	
	public func getDateofBirth() -> Date {
		
		return self.dateofBirthDatePicker!.date
		
	}
	
	public func displayAppSetting(value: Bool) {
		
		self.appSettingSwitch.setOn(value, animated: false)
		
	}
	
	public func getAppSetting() -> Bool {
		
		return self.appSettingSwitch.isOn
		
	}
	
}
