//
//  PlaySubsetWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape

/// A wrapper for a PlaySubset model item
public class PlaySubsetWrapper {

	// MARK: - Private Static Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var id:					    		String = ""
	public var name:	    					String = ""
	public fileprivate(set) var contentData:	String = ""
	public var playSubsetContentData:			PlaySubsetContentDataWrapper? = nil
	public var thumbnailImageData:				Data?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlaySubsetWrapper]) -> PlaySubsetWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playSubsetContentData = nil
		
	}
	
	public func set(contentData: String) {
		
		self.contentData 			= contentData
		
		// Create PlaySubsetContentDataWrapper
		self.playSubsetContentData 	= PlaySubsetContentDataWrapper(contentData: contentData)
		
	}

}
