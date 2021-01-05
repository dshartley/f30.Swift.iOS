//
//  PlayAreaGridTokenMenuViewControlManager.swift
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

/// Manages the PlayAreaGridTokenMenuView control layer
public class PlayAreaGridTokenMenuViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:					ProtocolPlayAreaGridTokenMenuViewControlManagerDelegate?
	public var viewManager:						PlayAreaGridTokenMenuViewViewManager?
	public fileprivate(set) var tokenWrapper: 	PlayAreaTokenWrapper?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayAreaGridTokenMenuViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func clear() {
		
		self.tokenWrapper = nil
		
	}
	
	public func set(tokenWrapper: PlayAreaTokenWrapper) {
		
		self.tokenWrapper = tokenWrapper
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
