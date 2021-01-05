//
//  PlayAreaPathAbilityButtonViewControlManager.swift
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

/// Manages the PlayAreaPathAbilityButtonView control layer
public class PlayAreaPathAbilityButtonViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:									ProtocolPlayAreaPathAbilityButtonViewControlManagerDelegate?
	public var viewManager:										PlayAreaPathAbilityButtonViewViewManager?
	public fileprivate(set) var playAreaPathAbilityWrapper:		PlayAreaPathAbilityWrapper?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayAreaPathAbilityButtonViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager				= viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {
		
		self.playAreaPathAbilityWrapper = playAreaPathAbilityWrapper

		// isCompleteYN
		self.viewManager!.displayIsEngagedYN(isEngagedYN: self.playAreaPathAbilityWrapper!.isEngagedYN)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
