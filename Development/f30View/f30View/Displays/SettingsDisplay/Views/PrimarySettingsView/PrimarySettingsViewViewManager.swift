//
//  PrimarySettingsViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the PrimarySettingsView view layer
public class PrimarySettingsViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolPrimarySettingsViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPrimarySettingsViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func displayAvatar(image: UIImage) {
		
		self.viewAccessStrategy!.displayAvatar(image: image)
	}
	
	public func getAvatarImage() -> UIImage? {
		
		return self.viewAccessStrategy!.getAvatarImage()
	}
	
	public func getFullName() -> String {
		
		return self.viewAccessStrategy!.getFullName()
	}
	
	public func displayFullName(value: String) {
		
		self.viewAccessStrategy!.displayFullName(value: value)
	}
	
	public func displayDateofBirth(dateofBirth: Date) {
		
		self.viewAccessStrategy!.displayDateofBirth(dateofBirth: dateofBirth)
	}
	
	public func getDateofBirth() -> Date {
		
		return self.viewAccessStrategy!.getDateofBirth()
	}
	
	public func displayAppSetting(value: Bool) {
		
		self.viewAccessStrategy!.displayAppSetting(value: value)
		
	}
	
	public func getAppSetting() -> Bool {
		
		return self.viewAccessStrategy!.getAppSetting()
		
	}
	
}
