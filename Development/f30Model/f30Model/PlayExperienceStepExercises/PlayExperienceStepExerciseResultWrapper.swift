//
//  PlayExperienceStepExerciseResultWrapper.swift
//  f30Model
//
//  Created by David on 22/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A wrapper for a PlayExperienceStepExerciseResult model item
public class PlayExperienceStepExerciseResultWrapper {

	// MARK: - Public Stored Properties
	
	public var playExperienceID:				String = ""
	public var playExperienceStepID:			String = ""
	public var playExperienceStepExerciseID:	String = ""
	public var dateCompleted:					Date = Date()
	public var repeatedYN:						Bool = false
	public fileprivate(set) var playExperienceStepExerciseOnCompleteData:	PlayExperienceStepExerciseOnCompleteDataWrapper? = nil
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(onCompleteData: String) {
		
		// Create playExperienceStepExerciseOnCompleteData
		self.playExperienceStepExerciseOnCompleteData = PlayExperienceStepExerciseOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	
	
	// MARK: - Public Methods
	
	public func copyToWrapper() -> DataJSONWrapper {
		
		let outputDateFormatter: DateFormatter = DateFormatter()
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.setParameterValue(key: "PlayExperienceID", value: self.playExperienceID)
		result.setParameterValue(key: "PlayExperienceStepID", value: self.playExperienceStepID)
		result.setParameterValue(key: "DateCompleted", value: outputDateFormatter.string(from: self.dateCompleted))
		result.setParameterValue(key: "RepeatedYN", value: "\(self.repeatedYN)")
		
		return result
	}
	
}
