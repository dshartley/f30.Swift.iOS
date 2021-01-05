//
//  PlayExperienceResultWrapper.swift
//  f30Model
//
//  Created by David on 22/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit

/// A wrapper for a PlayExperienceResult model item
public class PlayExperienceResultWrapper {

	// MARK: - Public Stored Properties
	
	public var playExperienceID:								String = ""
	public fileprivate(set) var playExperienceOnCompleteData:	PlayExperienceOnCompleteDataWrapper? = nil

	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(onCompleteData: String) {
		
		// Create playExperienceOnCompleteData
		self.playExperienceOnCompleteData = PlayExperienceOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	
}
