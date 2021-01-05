//
//  PlayAreaPathAbilityWrappers.swift
//  f30Model
//
//  Created by David on 01/02/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// Encapsulates an array of PlayAreaPathAbilityWrapper
public class PlayAreaPathAbilityWrappers {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var items: [PlayAreaPathAbilityWrapper] = [PlayAreaPathAbilityWrapper]()

	
	// MARK: - Initializers
	
	public init() {
	}
	
	
	// MARK: - Public Methods
	
	public func clear() {
		
		self.items = [PlayAreaPathAbilityWrapper]()
		
	}
	
	public func get(by type: PlayAreaPathAbilityTypes) -> PlayAreaPathAbilityWrapper? {
		
		guard (self.items.count > 0) else { return nil }
		
		var result: 	PlayAreaPathAbilityWrapper? = nil
		var i: 			Int = 0
		
		// Go through each item
		repeat {
			
			// Get PlayAreaPathAbilityWrapper
			let papaw: 	PlayAreaPathAbilityWrapper = self.items[i]
			
			// Check type
			if (papaw.playAreaPathAbilityType.type == type) { result = papaw }
			
			i += 1
			
		} while (result == nil && i <= self.items.count - 1);
		
		return result
		
	}
	
}

