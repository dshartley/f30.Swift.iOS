//
//  ProtocolPlayControlBarViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFGridScape
import f30Model

/// Defines a delegate for a PlayControlBarView class
public protocol ProtocolPlayControlBarViewDelegate: class {
	
	// MARK: - Methods

	func playControlBarView(touchesBegan sender: PlayControlBarView)

	func playControlBarView(playAreaPathAbilityTapped playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper)
	
}
