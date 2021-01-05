//
//  Img1ControlManager.swift
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

public enum Img1States {
	case Unselected
	case Selected
}

/// Manages the Img1 control layer
public class Img1ControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:				ProtocolImg1ControlManagerDelegate?
	public var viewManager:					Img1ViewManager?
	public fileprivate(set) var wrapper: 	Img1Wrapper?
	public var givenAnswer:					String?
	public var imageState:					Img1States = .Unselected
	
	
	// MARK: - Private Stored Properties


	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: Img1ViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods

	public func set(wrapper: Img1Wrapper) {
		
		self.wrapper = wrapper
	
	}
	
	public func display() {
		
		guard (self.wrapper != nil) else { return }
		
		self.viewManager!.displayContentImage(image: UIImage(data: self.wrapper!.imageData!)!)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
