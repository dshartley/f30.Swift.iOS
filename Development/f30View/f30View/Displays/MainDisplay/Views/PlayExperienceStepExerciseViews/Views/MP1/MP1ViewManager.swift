//
//  MP1ViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the MP1 view layer
public class MP1ViewManager: PlayExperienceStepExerciseViewViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
	}
	
	public override init(viewAccessStrategy: ProtocolPlayExperienceStepExerciseViewViewAccessStrategy) {
		super.init(viewAccessStrategy: viewAccessStrategy)
		
	}
	
	
	// MARK: - Public Methods

	public func present(p1SubItem view: ProtocolP1SubItem) {
		
		(self.viewAccessStrategy! as! ProtocolMP1ViewAccessStrategy).present(p1SubItem: view)
		
	}
	
}
