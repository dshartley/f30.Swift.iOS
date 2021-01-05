//
//  MainDisplayViewManager.swift
//  f30View
//
//  Created by David on 05/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFView
import f30Core
import f30Model

/// Manages the MainDisplay view layer
public class MainDisplayViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolMainDisplayViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolMainDisplayViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func displayAvatar(image: UIImage) {
		
		self.viewAccessStrategy!.displayAvatar(image: image)
	}
	
	public func setButtons(isSignedInYN: Bool) {
		
		self.viewAccessStrategy!.setButtons(isSignedInYN: isSignedInYN)
	}
	
	public func displayUserInfo(message: String) {
		
		self.viewAccessStrategy!.displayUserInfo(message: message)
	}
	
	public func present(playExperienceView view: ProtocolPlayExperienceView) {
		
		self.viewAccessStrategy!.present(playExperienceView: view)
	}

	public func present(playExperienceStepView view: ProtocolPlayExperienceStepView) {
		
		self.viewAccessStrategy!.present(playExperienceStepView: view)
	}
	
	public func displayPlayActiveChallenge(playChallengeWrapper: PlayChallengeWrapper) {
		
		self.viewAccessStrategy!.displayPlayActiveChallenge(playChallengeWrapper: playChallengeWrapper)
		
	}
	
	public func clearPlayActiveChallenge() {
		
		self.viewAccessStrategy!.clearPlayActiveChallenge()
		
	}
	
	public func setPlayAreaPath(playAreaPathWrapper: PlayAreaPathWrapper, visibleYN: Bool) {
		
		self.viewAccessStrategy!.setPlayAreaPath(playAreaPathWrapper: playAreaPathWrapper, visibleYN: visibleYN)
		
	}

	public func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, visibleYN: Bool) {
		
		self.viewAccessStrategy!.set(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, visibleYN: visibleYN)
		
	}
	
	public func display(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper) {
	
		self.viewAccessStrategy!.display(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, for: playAreaTokenWrapper)
		
	}
	
}
