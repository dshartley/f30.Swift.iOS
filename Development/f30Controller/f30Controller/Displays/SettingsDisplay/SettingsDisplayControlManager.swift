//
//  SettingsDisplayControlManager.swift
//  f30Controller
//
//  Created by David on 14/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFController
import f30Model
import f30View
import f30Core

/// Manages the SettingsDisplay control layer
public class SettingsDisplayControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:	ProtocolSettingsDisplayControlManagerDelegate?
	public var viewManager:		SettingsDisplayViewManager?
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: SettingsDisplayViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods

	
	// MARK: - Override Methods

	
	// MARK: - Private Methods

	
}
