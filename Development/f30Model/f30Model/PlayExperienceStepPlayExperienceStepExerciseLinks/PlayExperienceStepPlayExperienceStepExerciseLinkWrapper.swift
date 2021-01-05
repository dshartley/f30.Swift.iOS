//
//  PlayExperienceStepPlayExperienceStepExerciseLinkWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A wrapper for a PlayExperienceStepPlayExperienceStepExerciseLink model item
public class PlayExperienceStepPlayExperienceStepExerciseLinkWrapper {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var id:								String = ""
	public var playExperienceStepID:			String = ""
	public var playExperienceStepExerciseID:	String = ""
	public var index: 							Int = 0

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayExperienceStepPlayExperienceStepExerciseLinkWrapper]) -> PlayExperienceStepPlayExperienceStepExerciseLinkWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
	}
	
}
