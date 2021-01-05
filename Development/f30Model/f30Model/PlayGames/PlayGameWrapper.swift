//
//  PlayGameWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFModel
import f30Core

/// A wrapper for a PlayGame model item
public class PlayGameWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id: 								String = ""
	public var relativeMemberID:	    		String = ""
	public var playSubsetID:	    			String = ""
	public var dateCreated:						Date = Date()
	public var name:							String = ""
	public var status: 							ModelItemStatusTypes = .new
	public fileprivate(set) var playGameData:	PlayGameDataWrapper? = nil
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayGameWrapper]) -> PlayGameWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playGameData 	= nil

	}
	
	public func set(playGameDataWrapper: PlayGameDataWrapper) {
		
		self.playGameData = playGameDataWrapper
		
	}
	
}
