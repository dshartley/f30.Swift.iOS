//
//  PlayGameDataWrappers.swift
//  f30Model
//
//  Created by David on 01/02/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import UIKit

/// Encapsulates an array of PlayGameDataWrapper
public class PlayGameDataWrappers {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var items:							[PlayGameDataWrapper] = [PlayGameDataWrapper]()
	public var hasLoadedAllPreviousItemsYN:		Bool = false
	public var hasLoadedAllNextItemsYN:			Bool = false
	
	
	// MARK: - Initializers
	
	public init() {
	}
	
	
	// MARK: - Public Methods
	
	public func clear() {
		
		self.items 							= [PlayGameDataWrapper]()
		self.hasLoadedAllPreviousItemsYN 	= false
		self.hasLoadedAllNextItemsYN 		= false
	}
	
	public func remove(wrapper: PlayGameDataWrapper) {
		
		guard (self.items.count > 0) else { return }
		
		var foundAtIndex: 	Int? = nil
		var i: 				Int = 0
		
		// Go through each item
		repeat {
			
			// Get PlayGameDataWrapper
			let pgdw: 		PlayGameDataWrapper = self.items[i]
			
			// Check id
			if (pgdw.id == wrapper.id) { foundAtIndex = i }
			
			i += 1
			
		} while (foundAtIndex == nil && i <= self.items.count - 1);
		
		guard (foundAtIndex != nil) else { return }
		
		// Remove the item
		self.items.remove(at: foundAtIndex!)
		
	}
	
}

