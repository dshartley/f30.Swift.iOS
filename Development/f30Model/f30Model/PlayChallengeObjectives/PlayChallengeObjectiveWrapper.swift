//
//  PlayChallengeObjectiveWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFModel
import SFSerialization
import f30Core

/// A wrapper for a PlayChallengeObjective model item
public class PlayChallengeObjectiveWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:													String = ""
	public var relativeMemberID:									String = ""
	public var playChallengeID:										String = ""
	public var playChallengeObjectiveTypeID:						String = ""
	public fileprivate(set) var playChallengeObjectiveTypeWrapper:	PlayChallengeObjectiveTypeWrapper? = nil
	public var isAchievedYN:										Bool = false
	public var dateActive:											Date = Date()
	public var status: 												ModelItemStatusTypes = .new
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayChallengeWrapper]) -> PlayChallengeWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}

	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playChallengeObjectiveTypeWrapper = nil
	
	}
	
	public func set(playChallengeObjectiveTypeWrapper: PlayChallengeObjectiveTypeWrapper) {
		
		self.playChallengeObjectiveTypeWrapper 	= playChallengeObjectiveTypeWrapper
		
		// Set properties from the playChallengeObjectiveTypeWrapper
		self.playChallengeObjectiveTypeID 		= playChallengeObjectiveTypeWrapper.id
		
	}

	public func checkIsAchieved(with clientDefinition: PlayChallengeObjectiveTypeDefinitionDataWrapper) -> Bool {
		
		// Check definitionCode
		if (!clientDefinition.hasDefinitionCode(code: self.playChallengeObjectiveTypeWrapper!.code)) { return false }
		
		// Get masterDefinition
		let masterDefinition: 	PlayChallengeObjectiveTypeDefinitionDataWrapper? = self.playChallengeObjectiveTypeWrapper!.playChallengeObjectiveTypeDefinitionData
		
		guard (masterDefinition != nil) else { return true }
		
		// Go through each item
		for param in masterDefinition!.definitionParamsWrapper.Params {
			
			// Get clientValue
			let clientValue: 	String? = clientDefinition.getDefinitionParam(key: param.Key)?.lowercased()
			
			// Check clientValue
			guard (clientValue != nil && clientValue! == param.Value.lowercased()) else {
			
				return false
				
			}
			
		}
		
		return true
		
	}
	
}
