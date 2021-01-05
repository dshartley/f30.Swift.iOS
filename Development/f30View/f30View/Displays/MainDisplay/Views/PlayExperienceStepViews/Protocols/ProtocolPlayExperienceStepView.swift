//
//  ProtocolPlayExperienceStepView.swift
//  f30View
//
//  Created by David on 16/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a PlayExperienceStepView
public protocol ProtocolPlayExperienceStepView {
	
	// MARK: - Stored Properties
	
	var properties: PlayExperienceStepViewProperties { get }
	
	
	// MARK: - Methods

	func viewDidAppear()
	
	func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper)
	
	func present(playExperienceStepExerciseView view: ProtocolPlayExperienceStepExerciseView)
	
}
