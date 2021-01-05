//
//  ProtocolMainDisplayViewAccessStrategy.swift
//  f30View
//
//  Created by David on 05/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model

/// Defines a class which provides a strategy for accessing the MainDisplay view
public protocol ProtocolMainDisplayViewAccessStrategy {
	
	// MARK: - Methods
	
	func setButtons(isSignedInYN: Bool) -> Void
	
	func displayUserInfo(message: String) -> Void
	
	func displayAvatar(image: UIImage)
	
	func present(playExperienceView view: ProtocolPlayExperienceView)
	
	func present(playExperienceStepView view: ProtocolPlayExperienceStepView)
	
	func displayPlayActiveChallenge(playChallengeWrapper: PlayChallengeWrapper)
	
	func clearPlayActiveChallenge()
	
	func setPlayAreaPath(playAreaPathWrapper: PlayAreaPathWrapper, visibleYN: Bool)
	
	func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, visibleYN: Bool)
	
	func display(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper)
	
}
