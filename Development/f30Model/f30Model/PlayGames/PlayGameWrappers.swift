//
//  PlayGameWrappers.swift
//  f30Model
//
//  Created by David on 01/02/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import UIKit

/// Encapsulates an array of PlayGameWrapper
public class PlayGameWrappers {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var items:							[PlayGameWrapper] = [PlayGameWrapper]()
	public var hasLoadedAllPreviousItemsYN:		Bool = false
	public var hasLoadedAllNextItemsYN:			Bool = false
	
	
	// MARK: - Initializers
	
	public init() {
	}
	
	
	// MARK: - Public Methods
	
	public func clear() {
		
		self.items 							= [PlayGameWrapper]()
		self.hasLoadedAllPreviousItemsYN 	= false
		self.hasLoadedAllNextItemsYN 		= false
	}
	
	public func get(by id: String) -> PlayGameWrapper? {
		
		guard (self.items.count > 0) else { return nil }
		
		var result: 	PlayGameWrapper? = nil
		var i: 			Int = 0
		
		// Go through each item
		repeat {
			
			// Get PlayGameWrapper
			let pgw: 	PlayGameWrapper = self.items[i]
			
			// Check id
			if (pgw.id == id) { result = pgw }
			
			i += 1
			
		} while (result == nil && i <= self.items.count - 1);
		
		return result
		
	}
	
	public func remove(wrapper: PlayGameWrapper) {
		
		guard (self.items.count > 0) else { return }
		
		var foundAtIndex: 	Int? = nil
		var i: 				Int = 0
		
		// Go through each item
		repeat {
			
			// Get PlayGameWrapper
			let pgw: 		PlayGameWrapper = self.items[i]
			
			// Check id
			if (pgw.id == wrapper.id) { foundAtIndex = i }
			
			i += 1
			
		} while (foundAtIndex == nil && i <= self.items.count - 1);
		
		guard (foundAtIndex != nil) else { return }
		
		// Remove the item
		self.items.remove(at: foundAtIndex!)
		
	}
	
	public func set(playGameDataWrappers: PlayGameDataWrappers) {
		
		// Go through each item
		for pgdw in playGameDataWrappers.items {
			
			// Get PlayGameWrapper
			if let pgw = self.get(by: pgdw.playGameID) {
				
				pgw.set(playGameDataWrapper: pgdw)
				
			}
			
		}
		
	}
	
}
