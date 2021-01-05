//
//  PlayAreaTokenWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape
import SFModel

/// A wrapper for a PlayAreaToken model item
public class PlayAreaTokenWrapper: TokenWrapperBase {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var relativeMemberID:								String = ""
	public var playGameID:										String = ""
	public var status: 											ModelItemStatusTypes = .new
	public fileprivate(set) var playAreaPathAbilityWrappers:	PlayAreaPathAbilityWrappers = PlayAreaPathAbilityWrappers()
	
	
	// MARK: - Initializers
	
	
	// MARK: - Public Methods

	public func set(playAreaPathAbilityWrappers: [PlayAreaPathAbilityWrapper]) {
		
		self.playAreaPathAbilityWrappers.items = playAreaPathAbilityWrappers
		
	}
	
}
