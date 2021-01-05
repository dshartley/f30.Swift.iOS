//
//  ProtocolBasicPlayExperienceStepExerciseViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model
import f30View

/// Defines a delegate for a BasicPlayExperienceStepExerciseViewControlManager class
public protocol ProtocolBasicPlayExperienceStepExerciseViewControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func basicPlayExperienceStepExerciseViewControlManager(createImg1For wrapper: Img1Wrapper) -> ProtocolImg1
	
}
