//
//  PlayMoveWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A wrapper for a PlayMove model item
public class PlayMoveWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:									String = ""
	public var playSubsetID:						String = ""
	public fileprivate(set) var playReferenceData:	String = ""
	public var playMovePlayReferenceData:			PlayMovePlayReferenceDataWrapper? = nil
	public var playReferenceActionType: 			PlayReferenceActionTypes = .Unspecified
	public var thumbnailImageData:					Data?
	public fileprivate(set) var contentData:		String = ""
	public var playMoveContentData:					PlayMoveContentDataWrapper? = nil
	public fileprivate(set) var onCompleteData:		String = ""
	public var playMoveOnCompleteData:				PlayMoveOnCompleteDataWrapper? = nil
	public fileprivate(set) var playChallenge:		PlayChallengeWrapper? = nil
	
	
	// MARK: - Public Computed Properties
	
	public var playReferenceType: PlayReferenceTypes {
		get {
			return self.playMovePlayReferenceData!.playReferenceType
		}
		set(value) {
			self.playMovePlayReferenceData!.playReferenceType = value
		}
	}
	
	public var playReferenceID: String {
		get {
			return self.playMovePlayReferenceData!.playReferenceID
		}
		set(value) {
			self.playMovePlayReferenceData!.playReferenceID = value
		}
	}
	
	public var playReferenceDataItemType: PlayReferenceDataItemTypes {
		get {
			return self.playMovePlayReferenceData!.playReferenceDataItemType
		}
		set(value) {
			self.playMovePlayReferenceData!.playReferenceDataItemType = value
		}
	}
	
	public var playReferenceDataItemID: String {
		get {
			return self.playMovePlayReferenceData!.playReferenceDataItemID
		}
		set(value) {
			self.playMovePlayReferenceData!.playReferenceDataItemID = value
		}
	}
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayMoveWrapper]) -> PlayMoveWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}

	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playMovePlayReferenceData 	= nil
		self.playMoveContentData 		= nil
		self.playMoveOnCompleteData 	= nil
		self.playChallenge				= nil
		
	}

	public func set(playReferenceData: String) {
		
		self.playReferenceData 			= playReferenceData
		
		// Create PlayMovePlayReferenceDataWrapper
		self.playMovePlayReferenceData 	= PlayMovePlayReferenceDataWrapper(playReferenceData: playReferenceData)
		
	}
	
	public func set(contentData: String) {
		
		self.contentData 			= contentData
		
		// Create PlayMoveContentDataWrapper
		self.playMoveContentData 	= PlayMoveContentDataWrapper(contentData: contentData)
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 			= onCompleteData
		
		// Create PlayMoveOnCompleteDataWrapper
		self.playMoveOnCompleteData 	= PlayMoveOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	
	public func set(playChallengeWrapper: PlayChallengeWrapper) {
		
		self.playChallenge = playChallengeWrapper
		
	}

	public func serializePlayReferenceData() {
		
		self.playReferenceData = ""
		
		guard (self.playMovePlayReferenceData != nil) else { return }
		
		// Serialize
		self.playReferenceData = self.playMovePlayReferenceData!.serialize()
		
	}
	
}
