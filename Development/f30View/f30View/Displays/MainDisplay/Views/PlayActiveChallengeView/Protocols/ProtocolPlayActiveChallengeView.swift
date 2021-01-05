//
//  ProtocolPlayActiveChallengeView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a PlayActiveChallengeView
public protocol ProtocolPlayActiveChallengeView {
	
	// MARK: - Stored Properties

	// MARK: - Methods
	
	func set(playChallengeWrapper: PlayChallengeWrapper)
	
	func clearPlayActiveChallenge()
	
	func present(playChallengeObjectiveListItemView view: ProtocolPlayChallengeObjectiveListItemView)
	
}
