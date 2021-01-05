//
//  PlayAreaPathMenuViewControlManager.swift
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

/// Manages the PlayAreaPathMenuView control layer
public class PlayAreaPathMenuViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayAreaPathMenuViewControlManagerDelegate?
	public var viewManager:								PlayAreaPathMenuViewViewManager?
	public fileprivate(set) var playAreaPathWrapper:	PlayAreaPathWrapper?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayAreaPathMenuViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func clear() {
		
	}
	
	public func set(playAreaPathWrapper: PlayAreaPathWrapper) {

		self.playAreaPathWrapper = playAreaPathWrapper
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
