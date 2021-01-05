//
//  PlayExperienceWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A wrapper for a PlayExperience model item
public class PlayExperienceWrapper {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var id:					    								String = ""
	public var playSubsetID:											String = ""
	public var playExperienceType:										PlayExperienceTypes = .Basic
	public var name:													String = ""
	public var isCompleteYN:											Bool = false
	public fileprivate(set) var contentData:							String = ""
	public var playExperienceContentData:								PlayExperienceContentDataWrapper? = nil
	public fileprivate(set) var onCompleteData:							String = ""
	public var playExperienceOnCompleteData:							PlayExperienceOnCompleteDataWrapper? = nil
	public fileprivate(set) var playChallengeObjectiveDefinitionData:	String = ""
	public var playChallengeObjectiveDefinitionDataWrapper:				PlayChallengeObjectiveTypeDefinitionDataWrapper? = nil
	public var playExperienceResult:									PlayExperienceResultWrapper? = nil
	public fileprivate(set) var playMove:								PlayMoveWrapper? = nil
	public fileprivate(set) var imageData:								[String:Data?] = [String:Data?]()
	public var thumbnailImageData:										Data?
	public fileprivate(set) var playExperiencePlayExperienceStepLinks:					[String:PlayExperiencePlayExperienceStepLinkWrapper]? = [String:PlayExperiencePlayExperienceStepLinkWrapper]()
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayExperienceWrapper]) -> PlayExperienceWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playExperienceContentData 						= nil
		self.playExperienceOnCompleteData 					= nil
		self.playChallengeObjectiveDefinitionDataWrapper	= nil
		self.playExperienceResult 							= nil
		self.playExperiencePlayExperienceStepLinks 			= nil
		self.playMove										= nil
		
	}
	
	public func set(playExperiencePlayExperienceStepLinkWrapper: PlayExperiencePlayExperienceStepLinkWrapper) {
		
		if (self.playExperiencePlayExperienceStepLinks == nil) {
			
			self.playExperiencePlayExperienceStepLinks = [String:PlayExperiencePlayExperienceStepLinkWrapper]()
			
		}
		
		self.playExperiencePlayExperienceStepLinks![playExperiencePlayExperienceStepLinkWrapper.id] = playExperiencePlayExperienceStepLinkWrapper
		
	}
	
	public func set(contentData: String) {
		
		self.contentData 				= contentData
		
		// Create PlayExperienceContentDataWrapper
		self.playExperienceContentData 	= PlayExperienceContentDataWrapper(contentData: contentData)
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 				= onCompleteData
		
		// Create PlayExperienceOnCompleteDataWrapper
		self.playExperienceOnCompleteData 	= PlayExperienceOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	
	public func set(playChallengeObjectiveDefinitionData: String) {
		
		self.playChallengeObjectiveDefinitionData 			= playChallengeObjectiveDefinitionData
		
		// Create PlayChallengeObjectiveDefinitionDataWrapper
		self.playChallengeObjectiveDefinitionDataWrapper 	= PlayChallengeObjectiveTypeDefinitionDataWrapper(definitionData: playChallengeObjectiveDefinitionData)
		
	}
	
	public func set(playMoveWrapper: PlayMoveWrapper) {
		
		self.playMove = playMoveWrapper
		
	}
	
	public func clearPlayExperiencePlayExperienceStepLinks() {
		
		guard (self.playExperiencePlayExperienceStepLinks != nil) else { return }
		
		// Go through each item
		for pepeslw in self.playExperiencePlayExperienceStepLinks!.values {
			
			pepeslw.dispose()
			
		}
		
		self.playExperiencePlayExperienceStepLinks = nil
		
	}
	
	public func set(key: String, imageData: Data?) {
		
		self.imageData[key] = imageData
		
	}
	
	public func get(key: String) -> Data? {
		
		return self.imageData[key] ?? nil
		
	}
	
	public func playExperienceSteps() -> [String:PlayExperienceStepWrapper] {
		
		var result: [String:PlayExperienceStepWrapper] = [String:PlayExperienceStepWrapper]()
		
		guard (self.playExperiencePlayExperienceStepLinks != nil) else { return result }
		
		// Go through each item
		for pepeslw in self.playExperiencePlayExperienceStepLinks!.values {
			
			// Get PlayExperienceStepWrapper
			let pesw: PlayExperienceStepWrapper? = PlayWrapper.current!.get(byID: pepeslw.playExperienceStepID)
			
			guard (pesw != nil) else { continue }
			
			result[pesw!.id] = pesw!
			
		}
		
		return result
		
	}
	
}
