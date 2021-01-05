//
//  ProtocolPlayExperienceViewDelegate.swift
//  f30
//
//  Created by David on 16/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a delegate for a PlayExperienceView class
public protocol ProtocolPlayExperienceViewDelegate: class {
	
	// MARK: - Methods
	
	func playExperienceView(playExperienceCompleted wrapper: PlayExperienceWrapper, sender: ProtocolPlayExperienceView)
	
	func playExperienceView(presentPlayExperienceStepViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceView, delegate: ProtocolPlayExperienceStepViewDelegate)
	
	func playExperienceView(playExperienceStepCompleted wrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceView, oncomplete completionHandler:@escaping (Error?) -> Void, onuicomplete uiCompletionHandler:@escaping (Error?) -> Void)
	
	func playExperienceView(closeButtonTapped sender: ProtocolPlayExperienceView)
	
	func playExperienceView(playExperienceStepViewCloseButtonTapped sender: ProtocolPlayExperienceStepView)
	
	//func playExperienceView(playExperienceStepMarkerViewTapped sender: ProtocolPlayExperienceStepMarkerView)
	
}
