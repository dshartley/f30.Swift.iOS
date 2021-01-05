//
//  MC1ViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the MC1 view layer
public class MC1ViewManager: PlayExperienceStepExerciseViewViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
	}
	
	public override init(viewAccessStrategy: ProtocolPlayExperienceStepExerciseViewViewAccessStrategy) {
		super.init(viewAccessStrategy: viewAccessStrategy)
		
	}
	
	
	// MARK: - Public Methods
	
	public func displayText(text: String) -> Void {
		
		(self.viewAccessStrategy! as! ProtocolMC1ViewAccessStrategy).displayText(text: text)
		
	}
	
	public func present(img1 view: ProtocolImg1) {
		
		(self.viewAccessStrategy! as! ProtocolMC1ViewAccessStrategy).present(img1: view)
		
	}
	
}
