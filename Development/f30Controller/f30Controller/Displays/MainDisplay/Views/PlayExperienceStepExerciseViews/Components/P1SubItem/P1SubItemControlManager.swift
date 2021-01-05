//
//  P1SubItemControlManager.swift
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

public enum P1SubItemStates {
	case Unselected
	case Selected
}

/// Manages the P1SubItem control layer
public class P1SubItemControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:				ProtocolP1SubItemControlManagerDelegate?
	public var viewManager:					P1SubItemViewManager?
	public fileprivate(set) var wrapper: 	P1SubItemWrapper?
	public var givenAnswer:					String?
	public var imageState:					P1SubItemStates = .Unselected
	
	
	// MARK: - Private Stored Properties


	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: P1SubItemViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods

	public func set(wrapper: P1SubItemWrapper) {
		
		self.wrapper = wrapper
	
	}
	
	public func display() {
		
		guard (self.wrapper != nil) else { return }
		
		self.viewManager!.displayContentImage(image: UIImage(data: self.wrapper!.imageData!)!)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
