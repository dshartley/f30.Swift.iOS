//
//  ProtocolMainDisplayView.swift
//  f30View
//
//  Created by David on 07/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a MainDisplayView
public protocol ProtocolMainDisplayView {

	func present(playExperienceView view: ProtocolPlayExperienceView)

	func present(playExperienceStepView view: ProtocolPlayExperienceStepView)

	func setPlayAreaPath(playAreaPathWrapper: PlayAreaPathWrapper, visibleYN: Bool)
	
	func display(playAreaPathAbility playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper)
	
	func setPlayActiveChallenge(visibleYN: Bool)
	
}


