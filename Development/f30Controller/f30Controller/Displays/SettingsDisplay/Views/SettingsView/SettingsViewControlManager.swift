//
//  SettingsViewControlManager.swift
//  f30Controller
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFController
import SFSecurity
import f30View
import f30Model
import f30Core

/// Manages the SettingsView control layer
public class SettingsViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:		ProtocolSettingsViewControlManagerDelegate?
	public var viewManager:			SettingsViewViewManager?

	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers

	public override init() {
		super.init()
	}

	public init(modelManager: ModelManager, viewManager: SettingsViewViewManager) {
		super.init(modelManager: modelManager)

		self.viewManager				= viewManager
	}

	
	// MARK: - Public Methods

	
	// MARK: - Private Methods

}
