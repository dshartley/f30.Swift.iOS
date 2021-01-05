//
//  ProtocolBasicPlayExperienceStepExerciseViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a class which provides a strategy for accessing the BasicPlayExperienceStepExerciseView view
public protocol ProtocolBasicPlayExperienceStepExerciseViewViewAccessStrategy {
	
	// MARK: - Methods
	
	func displayText(text: String) -> Void
	
	func present(img1 view: ProtocolImg1)
	
}
