//
//  ProtocolPlayExperienceStepMarkerView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a PlayExperienceStepMarkerView
public protocol ProtocolPlayExperienceStepMarkerView {
	
	// MARK: - Stored Properties

	
	// MARK: - Computed Properties
	
	var playExperienceStepWrapper: 	PlayExperienceStepWrapper? { get }
	
	
	// MARK: - Methods
	
	func set(isActiveYN: Bool)
	
	func set(isCompleteYN: Bool)
	
}
