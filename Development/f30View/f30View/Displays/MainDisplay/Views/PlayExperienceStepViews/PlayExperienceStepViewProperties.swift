//
//  PlayExperienceStepViewProperties.swift
//  f30View
//
//  Created by David on 16/09/2020.
//  Copyright © 2020 com.smartfoundation. All rights reserved.
//

import UIKit

/// A wrapper for a PlayExperienceStepViewProperties item
public class PlayExperienceStepViewProperties {
	
	// MARK: - Public Stored Properties

	public var currentPlayExperienceStepExerciseView:	ProtocolPlayExperienceStepExerciseView? = nil
	public var canCheckYN: 								Bool = false
	public var hasCheckedYN: 							Bool = false
	public var isCorrectYN: 							Bool = false
	public var progressTarget: 							Int = 0
	public var progress: 								Int = 0
	
	
	// MARK: - Initializers
	
	public init() {
		
	}

	
	// MARK: - Public Methods

}

