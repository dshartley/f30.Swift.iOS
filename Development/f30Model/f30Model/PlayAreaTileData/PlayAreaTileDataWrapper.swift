//
//  PlayAreaTileDataWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFModel

/// A wrapper for a PlayAreaTileData model item
public class PlayAreaTileDataWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:					    			String = ""
	public var relativeMemberID:	    			String = ""
	public var playGameID:	    					String = ""
	public var playAreaTileID:	    				String = ""
	public fileprivate(set) var onCompleteData:		String = ""
	public var playAreaTileDataOnCompleteData:		PlayAreaTileDataOnCompleteDataWrapper? = nil
	public fileprivate(set) var attributeData:		String = ""
	public var playAreaTileDataAttributeData:		PlayAreaTileDataAttributeDataWrapper? = nil
	public var status: 								ModelItemStatusTypes = .new
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayAreaTileDataWrapper]) -> PlayAreaTileDataWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playAreaTileDataOnCompleteData 	= nil
		self.playAreaTileDataAttributeData 		= nil
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 					= onCompleteData
		
		// Create PlayAreaTileDataOnCompleteDataWrapper
		self.playAreaTileDataOnCompleteData 	= PlayAreaTileDataOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	
	public func set(attributeData: String) {
		
		self.attributeData 					= attributeData
		
		// Create PlayAreaTileDataAttributeDataWrapper
		self.playAreaTileDataAttributeData 	= PlayAreaTileDataAttributeDataWrapper(attributeData: attributeData)
		
	}

	public func serializeOnCompleteData() {
		
		self.onCompleteData = ""
		
		guard (self.playAreaTileDataOnCompleteData != nil) else { return }
		
		// Serialize
		self.onCompleteData = self.playAreaTileDataOnCompleteData!.serialize()
		
	}
	
}
