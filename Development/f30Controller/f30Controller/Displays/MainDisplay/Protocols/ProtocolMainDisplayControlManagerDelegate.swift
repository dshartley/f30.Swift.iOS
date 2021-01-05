//
//  ProtocolMainDisplayControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 05/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFGridScape
import SFSecurity
import SFSocial
import f30Core
import f30Model
import f30View

/// Defines a delegate for a MainDisplayControlManager class
public protocol ProtocolMainDisplayControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func mainDisplayControlManager(signOutSuccessful userProperties: UserProperties)
	
	func mainDisplayControlManager(signOutFailed userProperties: UserProperties?)
	
	func mainDisplayControlManager(isNotSignedIn error: Error?)
	
	func mainDisplayControlManager(isNotConnected error: Error?)
	
	func mainDisplayControlManager(userProfileWrapperLoadSuccessful userProfileWrapper: UserProfileWrapper)
	
	func mainDisplayControlManager(userProfileWrapperLoadFailed error: Error?, code: UserProfileWrapperErrorCodes)
	
	func mainDisplayControlManager(item: RelativeMemberWrapper, loadedAvatarImage sender: MainDisplayControlManager)
	
	func mainDisplayControlManager(createPlayExperienceViewFor wrapper: PlayExperienceWrapper, delegate: ProtocolPlayExperienceViewDelegate) -> ProtocolPlayExperienceView
	
	func mainDisplayControlManager(createPlayExperienceStepViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, delegate: ProtocolPlayExperienceStepViewDelegate) -> ProtocolPlayExperienceStepView
	
	func mainDisplayControlManager(playActiveChallengeLoaded wrapper: PlayChallengeWrapper?, sender: MainDisplayControlManager)
	
	func mainDisplayControlManager(shouldAbortPlayActiveChallenge wrapper: PlayChallengeWrapper, oncomplete completionHandler:@escaping (Bool, Error?) -> Void)

	func mainDisplayControlManager(gridScapeManager sender: MainDisplayControlManager) -> GridScapeManager?
	
	func mainDisplayControlManager(gridScapeContainerViewControlManager sender: MainDisplayControlManager) -> GridScapeContainerViewControlManager?

	func mainDisplayControlManager(byFootPlayPathAbilitySet sender: MainDisplayControlManager, isEngagedYN: Bool)
	
}
