//
//  ProtocolPlayAreaGridTokenMenuViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model

/// Defines a delegate for a PlayAreaGridTokenMenuView class
public protocol ProtocolPlayAreaGridTokenMenuViewDelegate: class {
	
	// MARK: - Methods

	func playAreaGridTokenMenuView(tapped playMoveWrapper: PlayMoveWrapper, sender: PlayAreaGridTokenMenuView)
	
}
