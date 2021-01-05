//
//  ProtocolPlayExperienceStepCompleteViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Defines a delegate for a PlayExperienceStepCompleteView class
public protocol ProtocolPlayExperienceStepCompleteViewDelegate: class {
	
	// MARK: - Methods

	func playExperienceStepCompleteView(sender: ProtocolPlayExperienceStepCompleteView, closeButtonTapped wrapper: PlayExperienceStepWrapper, oncomplete completionhandler: ((Error?) -> Void)?)
	
}
