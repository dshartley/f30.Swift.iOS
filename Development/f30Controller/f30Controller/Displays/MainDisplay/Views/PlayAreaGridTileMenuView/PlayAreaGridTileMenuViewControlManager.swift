//
//  PlayAreaGridTileMenuViewControlManager.swift
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

/// Manages the PlayAreaGridTileMenuView control layer
public class PlayAreaGridTileMenuViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:					ProtocolPlayAreaGridTileMenuViewControlManagerDelegate?
	public var viewManager:						PlayAreaGridTileMenuViewViewManager?
	public fileprivate(set) var tileWrapper: 	PlayAreaTileWrapper?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayAreaGridTileMenuViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func clear() {
		
		self.tileWrapper = nil
		
	}
	
	public func set(tileWrapper: PlayAreaTileWrapper) {
		
		self.tileWrapper = tileWrapper
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
