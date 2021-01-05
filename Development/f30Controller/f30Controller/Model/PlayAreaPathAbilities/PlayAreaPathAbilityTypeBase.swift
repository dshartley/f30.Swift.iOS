//
//  PlayAreaPathAbilityTypeBase.swift
//  f30Controller
//
//  Created by David on 03/08/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import f30Model
import f30Core

/// A PlayAreaPathAbilityType class
public class PlayAreaPathAbilityTypeBase {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var type: PlayAreaPathAbilityTypes = .ByFoot
	
	
	// MARK: - Initializers
	
	public init(type: PlayAreaPathAbilityTypes) {
		self.type = type
	}
	
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolPlayAreaPathAbilityType

extension PlayAreaPathAbilityTypeBase: ProtocolPlayAreaPathAbilityType {
	
	// MARK: - Methods
	
	
	// MARK: - Public Class Methods
	
	public class func setup(wrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) {
		
		// Get canStartYN
		wrapper.canStartYN 		= PlayAreaPathAbilityTypeBase.canStart(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
		// Get canGoYN
		wrapper.canGoYN 		= PlayAreaPathAbilityTypeBase.canGo(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
		// Get canStopYN
		wrapper.canStopYN 		= PlayAreaPathAbilityTypeBase.canStop(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
		// Get distanceCanGo
		wrapper.distanceCanGo	= PlayAreaPathAbilityTypeBase.distanceCanGo(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
	}
	
	public class func isEnabled(for playAreaTokenWrapper: PlayAreaTokenWrapper) -> Bool {
		
		return true
		
	}
	
	public class func canStart(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool {
		
		return true
		
	}
	
	public class func canGo(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool {
		
		return true
		
	}
	
	public class func canStop(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool {
		
		return true
		
	}
	
	public class func distanceCanGo(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Int {
		
		return 1
		
	}
	
}

