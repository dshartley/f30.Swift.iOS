//
//  ProtocolPlayAreaGridCellView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a PlayAreaGridCellView
public protocol ProtocolPlayAreaGridCellView {
	
	// MARK: - Stored Properties
	
	
	// MARK: - Computed Properties
	
	
	// MARK: - Methods
	
	func present(playAreaPathPointWrapper: PlayAreaPathPointWrapper)
	
	func hide(playAreaPathPointWrapper: PlayAreaPathPointWrapper)
	
}
