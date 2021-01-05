//
//  SignInDisplayControlManager.swift
//  f30Controller
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import SFNet
import f30Core
import f30Model
import f30View

/// Manages the SignInDisplay control layer
public class SignInDisplayControlManager: ControlManagerBase {

	// MARK: - Public Stored Properties

	public var viewManager:								SignInDisplayViewManager?

	
	// MARK: - Initializers

	public override init() {
		super.init()
	}

	public init(modelManager: ModelManager, viewManager: SignInDisplayViewManager) {
		super.init(modelManager: modelManager)

		self.viewManager				= viewManager
	}


	// MARK: - Public Methods

	
	// MARK: - Private Methods

}


