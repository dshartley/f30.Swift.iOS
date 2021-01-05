//
//  PlayAreaPathAbilitiesManager.swift
//  f30Controller
//
//  Created by David on 05/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model

/// Manages the PlayAreaPathAbilities
public class PlayAreaPathAbilitiesManager {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Initializers
	
	fileprivate init() {

	}
	
	
	// MARK: - Public Class Methods
	
	public class func getPlayAreaPathAbilities(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> [PlayAreaPathAbilityWrapper] {
		
		var result: [PlayAreaPathAbilityWrapper] = [PlayAreaPathAbilityWrapper]()
		
		// Get ByFootAbility PlayAreaPathAbilityWrapper
		if let w = PlayAreaPathAbilitiesManager.getByFootAbility(for: playAreaTokenWrapper, at: playAreaCellWrapper) {
			
			result.append(w)
			
		}

		// Get ByCarAbility PlayAreaPathAbilityWrapper
		if let w = PlayAreaPathAbilitiesManager.getByCarAbility(for: playAreaTokenWrapper, at: playAreaCellWrapper) {
			
			result.append(w)
			
		}
		
		return result
		
	}
	
	
	// MARK: - Private Class Methods
	
	fileprivate class func getByFootAbility(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> PlayAreaPathAbilityWrapper? {
		
		// Nb: isEnabled may not come from the PlayAreaPathAbilityType, maybe it should be set by the PlayAreaAbilitiesManager
		// Get isEnabledYN
		let isEnabledYN: 		Bool = ByFootPlayAreaPathAbilityType.isEnabled(for: playAreaTokenWrapper)
		
		guard (isEnabledYN) else { return nil }
		
		// Create PlayAreaPathAbilityWrapper
		let result: 			PlayAreaPathAbilityWrapper = PlayAreaPathAbilityWrapper(playAreaPathAbilityType: ByFootPlayAreaPathAbilityType())
		
		// Setup PlayAreaPathAbilityWrapper
		ByFootPlayAreaPathAbilityType.setup(wrapper: result, for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
		return result
		
	}
	
	fileprivate class func getByCarAbility(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> PlayAreaPathAbilityWrapper? {
		
		// Nb: isEnabled may not come from the PlayAreaPathAbilityType, maybe it should be set by the PlayAreaAbilitiesManager
		// Get isEnabledYN
		let isEnabledYN: 		Bool = ByCarPlayAreaPathAbilityType.isEnabled(for: playAreaTokenWrapper)
		
		guard (isEnabledYN) else { return nil }
		
		// Create PlayAreaPathAbilityWrapper
		let result: 			PlayAreaPathAbilityWrapper = PlayAreaPathAbilityWrapper(playAreaPathAbilityType: ByCarPlayAreaPathAbilityType())
		
		// Setup PlayAreaPathAbilityWrapper
		ByCarPlayAreaPathAbilityType.setup(wrapper: result, for: playAreaTokenWrapper, at: playAreaCellWrapper)

		return result
		
	}
	
}

