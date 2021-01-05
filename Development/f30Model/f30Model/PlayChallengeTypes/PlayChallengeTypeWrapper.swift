//
//  PlayChallengeTypeWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A wrapper for a PlayChallengeType model item
public class PlayChallengeTypeWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:									String = ""
	public var playSubsetID:						String = ""
	public var name:								String = ""
	public fileprivate(set) var contentData:		String = ""
	public var playChallengeTypeContentData:		PlayChallengeTypeContentDataWrapper? = nil
	public fileprivate(set) var onCompleteData:		String = ""
	public var playChallengeTypeOnCompleteData:		PlayChallengeTypeOnCompleteDataWrapper? = nil
	public var thumbnailImageData:					Data?
	
	
	// MARK: - Public Computed Properties
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayChallengeTypeWrapper]) -> PlayChallengeTypeWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}

	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playChallengeTypeContentData 		= nil
		self.playChallengeTypeOnCompleteData 	= nil
	
	}

	public func set(contentData: String) {
		
		self.contentData 					= contentData
		
		// Create PlayChallengeTypeContentDataWrapper
		self.playChallengeTypeContentData 	= PlayChallengeTypeContentDataWrapper(contentData: contentData)
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 					= onCompleteData
		
		// Create PlayChallengeTypeOnCompleteDataWrapper
		self.playChallengeTypeOnCompleteData 	= PlayChallengeTypeOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	
}
