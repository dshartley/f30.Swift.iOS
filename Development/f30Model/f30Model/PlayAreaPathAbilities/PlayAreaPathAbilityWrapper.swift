//
//  PlayAreaPathAbilityWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFModel
import f30Core

/// A wrapper for a PlayAreaPathAbility model item
public class PlayAreaPathAbilityWrapper {
	
	// MARK: - Private Static Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var playAreaPathAbilityType:		ProtocolPlayAreaPathAbilityType
	public var canStartYN:					Bool = true
	public var canGoYN:						Bool = true
	public var canStopYN:					Bool = true
	public var distanceCanGo:				Int = 1
	public var isEngagedYN:					Bool = false
	public var isGoingYN:					Bool = false
	
	
	// MARK: - Initializers
	
	public init(playAreaPathAbilityType: ProtocolPlayAreaPathAbilityType) {
	
		self.playAreaPathAbilityType = playAreaPathAbilityType
		
	}
	
	
	// MARK: - Public Class Methods
	
	
	// MARK: - Public Methods

	public func isValidPath(playAreaPathWrapper: PlayAreaPathWrapper) -> Bool {
	
		// TODO:
		return true
		
	}
	
}

