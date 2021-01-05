//
//  PlayChallengeObjectiveListItemViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFCore
import SFController
import f30View
import f30Model
import f30Core

/// Manages the PlayChallengeObjectiveListItemView control layer
public class PlayChallengeObjectiveListItemViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:								ProtocolPlayChallengeObjectiveListItemViewControlManagerDelegate?
	public var viewManager:										PlayChallengeObjectiveListItemViewViewManager?
	public fileprivate(set) var playChallengeObjectiveWrapper:	PlayChallengeObjectiveWrapper?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayChallengeObjectiveListItemViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager				= viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func set(playChallengeObjectiveWrapper: PlayChallengeObjectiveWrapper) {
		
		self.playChallengeObjectiveWrapper = playChallengeObjectiveWrapper
		
//		// Get title
//		let title: String = playChallengeObjectiveWrapper!.playChallengeObjectiveContentData!.get(key: "\(PlayChallengeObjectiveContentDataKeys.Title)") ?? ""
//
//		self.viewManager!.display(playExperienceStepName: title)
		
		// isCompleteYN
		self.viewManager!.displayIsCompleteYN(isCompleteYN: self.playChallengeObjectiveWrapper!.isAchievedYN)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
