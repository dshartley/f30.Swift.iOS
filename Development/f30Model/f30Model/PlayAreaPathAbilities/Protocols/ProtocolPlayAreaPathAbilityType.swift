//
//  ProtocolPlayAreaPathAbilityType.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Defines a class which provides a PlayAreaPathAbilityType
public protocol ProtocolPlayAreaPathAbilityType {
	
	// MARK: - Properties
	
	var type: PlayAreaPathAbilityTypes { get }

	
	// MARK: - Methods
	
	
	// MARK: - Static Methods
	
	static func setup(wrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper)
	
	static func isEnabled(for playAreaTokenWrapper: PlayAreaTokenWrapper) -> Bool
	
	static func canStart(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool
	
	static func canGo(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool
	
	static func canStop(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool

	static func distanceCanGo(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Int

}

