//
//  PlayExperienceStepWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A wrapper for a PlayExperienceStep model item
public class PlayExperienceStepWrapper {
	
	// MARK: - Private Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:					    								String = ""
	public var playSubsetID:											String = ""
	public var playExperienceStepType:									PlayExperienceStepTypes = .Basic
	public var name:													String = ""
	public var isCompleteYN:											Bool = false
	public fileprivate(set) var contentData:							String = ""
	public var playExperienceStepContentData:							PlayExperienceStepContentDataWrapper? = nil
	public fileprivate(set) var onCompleteData:							String = ""
	public var playExperienceStepOnCompleteData:						PlayExperienceStepOnCompleteDataWrapper? = nil
	public fileprivate(set) var playChallengeObjectiveDefinitionData:	String = ""
	public var playChallengeObjectiveDefinitionDataWrapper:				PlayChallengeObjectiveTypeDefinitionDataWrapper? = nil
	public var playExperienceStepResult:								PlayExperienceStepResultWrapper? = nil
	public var isActiveYN: 												Bool = false
	public fileprivate(set) var imageData:								[String:Data?] = [String:Data?]()
	public var thumbnailImageData:										Data?
	public fileprivate(set) var playExperienceStepPlayExperienceStepExerciseLinks:					[String:PlayExperienceStepPlayExperienceStepExerciseLinkWrapper]? = [String:PlayExperienceStepPlayExperienceStepExerciseLinkWrapper]()
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayExperienceStepWrapper]) -> PlayExperienceStepWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playExperienceStepContentData 						= nil
		self.playExperienceStepOnCompleteData 					= nil
		self.playChallengeObjectiveDefinitionDataWrapper		= nil
		self.playExperienceStepResult 							= nil
		self.playExperienceStepPlayExperienceStepExerciseLinks 	= nil
		
	}
	
	public func clone(fromWrapper wrapper: PlayExperienceStepWrapper) {

		// Copy all properties from the wrapper
		self.id										= wrapper.id
		self.playExperienceStepType					= wrapper.playExperienceStepType
		self.name									= wrapper.name
		self.isCompleteYN							= wrapper.isCompleteYN

		self.set(contentData: wrapper.contentData)
		self.set(onCompleteData: wrapper.onCompleteData)
		self.set(playChallengeObjectiveDefinitionData: wrapper.playChallengeObjectiveDefinitionData)
		
		self.imageData 								= wrapper.imageData
		
	}
	
	public func set(contentData: String) {
		
		self.contentData 					= contentData
		
		// Create PlayExperienceStepContentDataWrapper
		self.playExperienceStepContentData 	= PlayExperienceStepContentDataWrapper(contentData: contentData)
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 					= onCompleteData
		
		// Create PlayExperienceStepOnCompleteDataWrapper
		self.playExperienceStepOnCompleteData 	= PlayExperienceStepOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}

	public func set(playChallengeObjectiveDefinitionData: String) {
		
		self.playChallengeObjectiveDefinitionData 			= playChallengeObjectiveDefinitionData
		
		// Create PlayChallengeObjectiveDefinitionDataWrapper
		self.playChallengeObjectiveDefinitionDataWrapper 	= PlayChallengeObjectiveTypeDefinitionDataWrapper(definitionData: playChallengeObjectiveDefinitionData)
		
	}

	public func set(playExperienceStepPlayExperienceStepExerciseLinkWrapper: PlayExperienceStepPlayExperienceStepExerciseLinkWrapper) {
		
		if (self.playExperienceStepPlayExperienceStepExerciseLinks == nil) {
			
			self.playExperienceStepPlayExperienceStepExerciseLinks = [String:PlayExperienceStepPlayExperienceStepExerciseLinkWrapper]()
			
		}
		
		self.playExperienceStepPlayExperienceStepExerciseLinks![playExperienceStepPlayExperienceStepExerciseLinkWrapper.id] = playExperienceStepPlayExperienceStepExerciseLinkWrapper
		
	}
	
	public func clearPlayExperienceStepPlayExperienceStepExerciseLinks() {
		
		guard (self.playExperienceStepPlayExperienceStepExerciseLinks != nil) else { return }
		
		// Go through each item
		for pespesew in self.playExperienceStepPlayExperienceStepExerciseLinks!.values {
			
			pespesew.dispose()
			
		}
		
		self.playExperienceStepPlayExperienceStepExerciseLinks = nil
		
	}

	public func playExperienceStepExercises() -> [String:PlayExperienceStepExerciseWrapper] {
		
		var result: [String:PlayExperienceStepExerciseWrapper] = [String:PlayExperienceStepExerciseWrapper]()
		
		guard (self.playExperienceStepPlayExperienceStepExerciseLinks != nil) else { return result }
		
		// Go through each item
		for pespeselw in self.playExperienceStepPlayExperienceStepExerciseLinks!.values {
			
			// Get PlayExperienceStepExerciseWrapper
			let pesew: PlayExperienceStepExerciseWrapper? = PlayWrapper.current!.get(byID: pespeselw.playExperienceStepExerciseID)
			
			guard (pesew != nil) else { continue }
			
			result[pesew!.id] = pesew!
			
		}
		
		return result
		
	}
	
	public func set(key: String, imageData: Data?) {
		
		self.imageData[key] = imageData
		
	}
	
	public func get(key: String) -> Data? {
		
		return self.imageData[key] ?? nil
		
	}
	
}
