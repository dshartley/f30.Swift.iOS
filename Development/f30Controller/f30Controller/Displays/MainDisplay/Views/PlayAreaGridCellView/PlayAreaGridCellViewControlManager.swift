//
//  PlayAreaGridCellViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFController
import f30Model
import f30View

/// Manages the PlayAreaGridCellView control layer
public class PlayAreaGridCellViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:	ProtocolPlayAreaGridCellViewControlManagerDelegate?
	public var viewManager:		PlayAreaGridCellViewViewManager?

	
	// MARK: - Private Stored Properties


	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayAreaGridCellViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
