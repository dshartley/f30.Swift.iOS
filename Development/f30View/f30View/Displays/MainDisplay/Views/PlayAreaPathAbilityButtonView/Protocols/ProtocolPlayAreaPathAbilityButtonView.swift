//
//  ProtocolPlayAreaPathAbilityButtonView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a PlayAreaPathAbilityButtonView
public protocol ProtocolPlayAreaPathAbilityButtonView {
	
	// MARK: - Stored Properties

	
	// MARK: - Computed Properties
	
	var playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper? { get }
	
	
	// MARK: - Methods

	func set(isEngagedYN: Bool)
	
}
