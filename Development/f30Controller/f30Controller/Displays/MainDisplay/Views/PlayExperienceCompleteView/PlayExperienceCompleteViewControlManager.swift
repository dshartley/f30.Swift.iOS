//
//  PlayExperienceCompleteViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFCore
import SFController
import f30View
import f30Model
import f30Core

/// Manages the PlayExperienceCompleteView control layer
public class PlayExperienceCompleteViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:		ProtocolPlayExperienceCompleteViewControlManagerDelegate?
	public var viewManager:			PlayExperienceCompleteViewViewManager?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayExperienceCompleteViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
