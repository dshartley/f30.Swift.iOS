//
//  PlayExperienceStepExerciseViewViewManagerBase.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// A base class for classes which manage the PlayExperienceStepExerciseView view layer
open class PlayExperienceStepExerciseViewViewManagerBase: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var viewAccessStrategy: ProtocolPlayExperienceStepExerciseViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPlayExperienceStepExerciseViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
}
