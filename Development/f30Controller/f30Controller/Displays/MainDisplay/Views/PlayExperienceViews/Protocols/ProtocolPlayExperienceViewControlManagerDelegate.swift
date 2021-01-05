//
//  ProtocolPlayExperienceViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Defines a delegate for a PlayExperienceViewControlManager class
public protocol ProtocolPlayExperienceViewControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func playExperienceViewControlManager(playExperienceCompleted wrapper: PlayExperienceWrapper, sender: PlayExperienceViewControlManagerBase)
	
	func playExperienceViewControlManager(createPlayExperienceStepMarkerViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper) -> ProtocolPlayExperienceStepMarkerView
	
}
