//
//  ProtocolPlayExperienceStepExerciseViewDelegate.swift
//  f30
//
//  Created by David on 16/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a delegate for a PlayExperienceStepExerciseView class
public protocol ProtocolPlayExperienceStepExerciseViewDelegate: class {
	
	// MARK: - Methods

	func playExperienceStepExerciseView(canCheck wrapper: PlayExperienceStepExerciseWrapper, sender: ProtocolPlayExperienceStepExerciseView, canCheckYN: Bool)
	
}
