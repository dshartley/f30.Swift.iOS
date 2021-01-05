//
//  ProtocolPlayActiveChallengeViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model
import f30View

/// Defines a delegate for a PlayActiveChallengeViewControlManager class
public protocol ProtocolPlayActiveChallengeViewControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func playActiveChallengeViewControlManager(createPlayChallengeObjectiveListItemViewFor wrapper: PlayChallengeObjectiveWrapper) -> ProtocolPlayChallengeObjectiveListItemView
	
}
