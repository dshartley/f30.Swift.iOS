//
//  ProtocolPlayControlBarView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a PlayControlBarView
public protocol ProtocolPlayControlBarView {
	
	// MARK: - Stored Properties

	// MARK: - Methods
	
	func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, visibleYN: Bool)
	
	func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper)
	
}
