//
//  ProtocolPlayExperienceStepMarkerViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30View
import f30Model

/// Defines a delegate for a PlayExperienceStepMarkerView class
public protocol ProtocolPlayExperienceStepMarkerViewDelegate: class {
	
	// MARK: - Methods
	
	func playExperienceStepMarkerView(tapped playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceStepMarkerView)
	
}
