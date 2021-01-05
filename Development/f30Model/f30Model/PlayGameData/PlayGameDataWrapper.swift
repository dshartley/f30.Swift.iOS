//
//  PlayGameDataWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A wrapper for a PlayGameData model item
public class PlayGameDataWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:					    			String = ""
	public var relativeMemberID:	    			String = ""
	public var playGameID:	    					String = ""
	public var dateLastPlayed:						Date = Date()
	public fileprivate(set) var onCompleteData:		String = ""
	public var playGameDataOnCompleteData:			PlayGameDataOnCompleteDataWrapper? = nil
	public fileprivate(set) var attributeData:		String = ""
	public var playGameDataAttributeData:			PlayGameDataAttributeDataWrapper? = nil

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayGameDataWrapper]) -> PlayGameDataWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playGameDataOnCompleteData 	= nil
		self.playGameDataAttributeData 		= nil
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 				= onCompleteData
		
		// Create PlayGameDataOnCompleteDataWrapper
		self.playGameDataOnCompleteData 	= PlayGameDataOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	
	public func set(attributeData: String) {
		
		self.attributeData 					= attributeData
		
		// Create PlayGameDataAttributeDataWrapper
		self.playGameDataAttributeData 		= PlayGameDataAttributeDataWrapper(attributeData: attributeData)
		
	}
	
	public func serializeOnCompleteData() {
		
		self.onCompleteData = ""
		
		guard (self.playGameDataOnCompleteData != nil) else { return }
		
		// Serialize
		self.onCompleteData = self.playGameDataOnCompleteData!.serialize()
	
	}

}
