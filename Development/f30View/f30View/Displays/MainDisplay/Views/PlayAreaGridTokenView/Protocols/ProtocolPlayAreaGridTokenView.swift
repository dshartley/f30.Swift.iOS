//
//  ProtocolPlayAreaGridTokenView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

public enum PlayAreaGridTokenViewPathAbilityDisplayTypes {
	case IsEngaged
	case IsGoing
	case None
}

/// Defines a class which is a PlayAreaGridTokenView
public protocol ProtocolPlayAreaGridTokenView {
	
	// MARK: - Stored Properties
	
	func setPlayAreaPathAbilityDisplay(type: PlayAreaGridTokenViewPathAbilityDisplayTypes)
	
	
	// MARK: - Computed Properties
	
	
	// MARK: - Methods
	
}
