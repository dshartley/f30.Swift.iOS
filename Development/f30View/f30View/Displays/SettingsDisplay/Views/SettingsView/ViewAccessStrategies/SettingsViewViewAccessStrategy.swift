//
//  SettingsViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the SettingsView view
public class SettingsViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties
	
	fileprivate var primarySettingsView: 	ProtocolPrimarySettingsView?
	fileprivate var changePasswordView:		ProtocolChangePasswordView?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(primarySettingsView: 	ProtocolPrimarySettingsView,
					  changePasswordView:	ProtocolChangePasswordView) {
		
		self.primarySettingsView 	= primarySettingsView
		self.changePasswordView 	= changePasswordView
		
	}
	
}

// MARK: - Extension ProtocolSettingsViewViewAccessStrategy

extension SettingsViewViewAccessStrategy: ProtocolSettingsViewViewAccessStrategy {
	
	// MARK: - Methods
	
}
