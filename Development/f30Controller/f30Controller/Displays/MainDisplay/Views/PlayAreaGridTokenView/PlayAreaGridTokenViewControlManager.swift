//
//  PlayAreaGridTokenViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFController
import f30Model
import f30View

/// Manages the PlayAreaGridTokenView control layer
public class PlayAreaGridTokenViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:	ProtocolPlayAreaGridTokenViewControlManagerDelegate?
	public var viewManager:		PlayAreaGridTokenViewViewManager?

	
	// MARK: - Private Stored Properties


	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayAreaGridTokenViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
