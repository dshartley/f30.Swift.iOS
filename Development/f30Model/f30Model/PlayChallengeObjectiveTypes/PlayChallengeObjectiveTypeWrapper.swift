//
//  PlayChallengeObjectiveTypeWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A wrapper for a PlayChallengeObjectiveType model item
public class PlayChallengeObjectiveTypeWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:											String = ""
	public var playSubsetID:								String = ""
	public var name:										String = ""
	public var code:										String = ""
	public fileprivate(set) var contentData:				String = ""
	public var playChallengeObjectiveTypeContentData:		PlayChallengeObjectiveTypeContentDataWrapper? = nil
	public fileprivate(set) var onCompleteData:				String = ""
	public var playChallengeObjectiveTypeOnCompleteData:		PlayChallengeObjectiveTypeOnCompleteDataWrapper? = nil
	public fileprivate(set) var definitionData:				String = ""
	public var playChallengeObjectiveTypeDefinitionData:		PlayChallengeObjectiveTypeDefinitionDataWrapper? = nil
	public var thumbnailImageData:							Data?
	
	
	// MARK: - Public Computed Properties
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayChallengeObjectiveTypeWrapper]) -> PlayChallengeObjectiveTypeWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}

	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playChallengeObjectiveTypeContentData 		= nil
		self.playChallengeObjectiveTypeOnCompleteData 	= nil
		self.playChallengeObjectiveTypeDefinitionData 	= nil
		
	}

	public func set(contentData: String) {
		
		self.contentData 							= contentData
		
		// Create PlayChallengeObjectiveTypeContentDataWrapper
		self.playChallengeObjectiveTypeContentData 	= PlayChallengeObjectiveTypeContentDataWrapper(contentData: contentData)
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 							= onCompleteData
		
		// Create PlayChallengeObjectiveTypeOnCompleteDataWrapper
		self.playChallengeObjectiveTypeOnCompleteData 	= PlayChallengeObjectiveTypeOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}

	public func set(definitionData: String) {
		
		self.definitionData 							= definitionData
		
		// Create PlayChallengeObjectiveTypeDefinitionDataWrapper
		self.playChallengeObjectiveTypeDefinitionData 	= PlayChallengeObjectiveTypeDefinitionDataWrapper(definitionData: definitionData)
		
	}
	
}
