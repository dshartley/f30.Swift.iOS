//
//  ProtocolPlayExperienceStepViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a class which provides a strategy for accessing the PlayExperienceStepView view
public protocol ProtocolPlayExperienceStepViewViewAccessStrategy {
	
	// MARK: - Methods
	
	func present(playExperienceStepExerciseView view: ProtocolPlayExperienceStepExerciseView)
	
}
