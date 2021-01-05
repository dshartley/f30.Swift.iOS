//
//  MainDisplayViewAccessStrategy.swift
//  f30View
//
//  Created by David on 05/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// A strategy for accessing the MainDisplay view
public class MainDisplayViewAccessStrategy {
	
	// MARK: - Private Stored Properties
	
	fileprivate var mainDisplayView: 			ProtocolMainDisplayView?
	fileprivate var avatarImageView:			UIImageView?
	fileprivate var userInfoLabel:				UILabel?
	fileprivate var playActiveChallengeView:	ProtocolPlayActiveChallengeView?
	fileprivate var playControlBarView: 		ProtocolPlayControlBarView?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(mainDisplayView: 			ProtocolMainDisplayView,
					  avatarImageView:			UIImageView,
					  userInfoLabel: 			UILabel,
					  playActiveChallengeView:	ProtocolPlayActiveChallengeView,
					  playControlBarView: 		ProtocolPlayControlBarView) {

		self.mainDisplayView 			= mainDisplayView
		self.avatarImageView 			= avatarImageView
		self.userInfoLabel				= userInfoLabel
		self.playActiveChallengeView	= playActiveChallengeView
		self.playControlBarView			= playControlBarView

	}
	
}

// MARK: - Extension ProtocolLoginDisplayViewAccessStrategy

extension MainDisplayViewAccessStrategy: ProtocolMainDisplayViewAccessStrategy {
	
	// MARK: - Public Methods
	
	public func displayAvatar(image: UIImage) {
		
		self.avatarImageView!.image = image
	}
	
	public func setButtons(isSignedInYN: Bool) {
		
	}
	
	public func displayUserInfo(message: String) {
		
		DispatchQueue.main.async {
			
			self.userInfoLabel!.text = message
		}
	}
	
	public func present(playExperienceView view: ProtocolPlayExperienceView) {
		
		self.mainDisplayView!.present(playExperienceView: view)
		
	}

	public func present(playExperienceStepView view: ProtocolPlayExperienceStepView) {
		
		self.mainDisplayView!.present(playExperienceStepView: view)
		
	}
	
	public func displayPlayActiveChallenge(playChallengeWrapper: PlayChallengeWrapper) {
		
		// mainDisplayView
		self.mainDisplayView!.setPlayActiveChallenge(visibleYN: true)
		
		// playActiveChallengeView
		self.playActiveChallengeView!.set(playChallengeWrapper: playChallengeWrapper)
		
	}
	
	public func clearPlayActiveChallenge() {
		
		// mainDisplayView
		self.mainDisplayView!.setPlayActiveChallenge(visibleYN: false)
		
		// playActiveChallengeView
		self.playActiveChallengeView!.clearPlayActiveChallenge()
		
	}

	public func setPlayAreaPath(playAreaPathWrapper: PlayAreaPathWrapper, visibleYN: Bool) {
		
		// Set playAreaPath
		self.mainDisplayView!.setPlayAreaPath(playAreaPathWrapper: playAreaPathWrapper, visibleYN: visibleYN)
		
	}
	
	public func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, visibleYN: Bool) {
		
		// Set playAreaPathAbilityWrapper
		self.playControlBarView!.set(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, visibleYN: visibleYN)
		
	}
	
	public func display(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper) {
		
		// Display in playControlBarView
		self.playControlBarView!.set(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper)
		
		// Display in mainDisplayView
		self.mainDisplayView!.display(playAreaPathAbility: playAreaPathAbilityWrapper, for: playAreaTokenWrapper)
		
	}
	
}
