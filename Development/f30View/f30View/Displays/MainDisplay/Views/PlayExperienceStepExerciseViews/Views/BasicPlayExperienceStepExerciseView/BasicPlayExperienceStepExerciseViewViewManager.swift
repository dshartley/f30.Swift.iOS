//
//  BasicPlayExperienceStepExerciseViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the BasicPlayExperienceStepExerciseView view layer
public class BasicPlayExperienceStepExerciseViewViewManager: PlayExperienceStepExerciseViewViewManagerBase {
	
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
		
		(self.viewAccessStrategy! as! ProtocolBasicPlayExperienceStepExerciseViewViewAccessStrategy).displayText(text: text)
		
	}
	
	public func present(img1 view: ProtocolImg1) {
		
		(self.viewAccessStrategy! as! ProtocolBasicPlayExperienceStepExerciseViewViewAccessStrategy).present(img1: view)
		
	}
	
}
