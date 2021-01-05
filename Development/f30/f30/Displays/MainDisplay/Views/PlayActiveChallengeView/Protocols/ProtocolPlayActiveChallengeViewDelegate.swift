//
//  ProtocolPlayActiveChallengeViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFGridScape

/// Defines a delegate for a PlayActiveChallengeView class
public protocol ProtocolPlayActiveChallengeViewDelegate: class {
	
	// MARK: - Methods

	func playActiveChallengeView(touchesBegan sender: PlayActiveChallengeView)

	func playActiveChallengeView(willDismiss sender: PlayActiveChallengeView)

	func playActiveChallengeView(didDismiss sender: PlayActiveChallengeView)

}
