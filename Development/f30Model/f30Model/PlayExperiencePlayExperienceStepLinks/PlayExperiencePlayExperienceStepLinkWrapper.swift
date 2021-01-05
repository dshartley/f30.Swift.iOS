//
//  PlayExperiencePlayExperienceStepLinkWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A wrapper for a PlayExperiencePlayExperienceStepLink model item
public class PlayExperiencePlayExperienceStepLinkWrapper {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var id:						String = ""
	public var playExperienceID:		String = ""
	public var playExperienceStepID:	String = ""
	public var index: 					Int = 0

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayExperiencePlayExperienceStepLinkWrapper]) -> PlayExperiencePlayExperienceStepLinkWrapper? {
		
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
