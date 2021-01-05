//
//  SettingsDisplayViewManager.swift
//  f30View
//
//  Created by David on 14/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFView
import f30Core

/// Manages the SettingsDisplay view layer
public class SettingsDisplayViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolSettingsDisplayViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolSettingsDisplayViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods

	
}
