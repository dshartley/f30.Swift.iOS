//
//  ProtocolPlayExperienceStepExerciseView.swift
//  f30View
//
//  Created by David on 16/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a PlayExperienceStepExerciseView
public protocol ProtocolPlayExperienceStepExerciseView {
	
	// MARK: - Stored Properties
	
	var properties: 						PlayExperienceStepExerciseViewProperties { get }
	
	
	// MARK: - Computed Properties
	
	var delegate: 							ProtocolPlayExperienceStepExerciseViewDelegate? { get set }
	var playExperienceStepExerciseWrapper: 	PlayExperienceStepExerciseWrapper? { get }
	
		
	// MARK: - Methods

	func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper)

	func reset()
	
}
