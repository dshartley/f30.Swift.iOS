//
//  PlayActiveChallengeViewControlManager.swift
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

/// Manages the PlayActiveChallengeView control layer
public class PlayActiveChallengeViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:									ProtocolPlayActiveChallengeViewControlManagerDelegate?
	public var viewManager:										PlayActiveChallengeViewViewManager?
	public fileprivate(set) var playChallengeWrapper:			PlayChallengeWrapper?
	
	
	// MARK: - Private Stored Properties

	fileprivate var playChallengeObjectiveListItemViews: 		[String:ProtocolPlayChallengeObjectiveListItemView] = [String:ProtocolPlayChallengeObjectiveListItemView]()
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayActiveChallengeViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods

	public func clear() {
		
		self.playChallengeWrapper 					= nil
		self.playChallengeObjectiveListItemViews 	= [String:ProtocolPlayChallengeObjectiveListItemView]()
		
	}
	
	public func set(playChallengeWrapper: PlayChallengeWrapper) {
		
		self.playChallengeWrapper 					= playChallengeWrapper
		self.playChallengeObjectiveListItemViews 	= [String:ProtocolPlayChallengeObjectiveListItemView]()
		
	}
	
	public func displayPlayChallenge() {
		
		guard (self.playChallengeWrapper != nil && self.playChallengeWrapper!.playChallengeTypeWrapper!.playChallengeTypeContentData != nil) else { return }
		
		// Get title
		let title: String = self.playChallengeWrapper!.playChallengeTypeWrapper!.playChallengeTypeContentData!.get(key: "\(PlayChallengeContentDataKeys.Title)") ?? ""
		
		self.viewManager!.displayTitle(title: title)
		
	}
	
	public func displayPlayChallengeObjectives() {
		
		guard (self.playChallengeWrapper != nil) else { return }
		
		// Create orderedList
		var orderedList: 	[Int:PlayChallengeObjectiveWrapper] = [Int:PlayChallengeObjectiveWrapper]()
		
		// Go through each item
		for pcow in self.playChallengeWrapper!.playChallengeObjectives!.values {
			
			// Get index
			var index: 		Int = -1
			
			if (pcow.playChallengeObjectiveTypeWrapper!.playChallengeObjectiveTypeContentData != nil) {
				
				index 		= Int(pcow.playChallengeObjectiveTypeWrapper!.playChallengeObjectiveTypeContentData!.get(key: "\(PlayChallengeObjectiveContentDataKeys.Index)") ?? "0")!
				
				if (orderedList.keys.contains(index)) { index = -1 }
				
			}
			
			if (index == -1) { index = orderedList.count }
			
			// Put item in orderedList
			orderedList[index] = pcow
			
		}
		
		// Go through each item
		for index in 0...orderedList.count - 1 {
			
			let pcow: 		PlayChallengeObjectiveWrapper? = orderedList[index]
			
			if (pcow != nil) {
				
				// Display PlayChallengeObjectiveWrapper
				self.doDisplayPlayChallengeObjectiveListItemView(wrapper: pcow!)
				
			}
			
		}
		
	}
	
	public func doAfterPlayChallengeObjectiveCompleted(playChallengeObjectiveWrapper: PlayChallengeObjectiveWrapper) {

		playChallengeObjectiveWrapper.isAchievedYN = true
		
		// Get playChallengeObjectiveListItemView
		let pcoliv: 								ProtocolPlayChallengeObjectiveListItemView = self.playChallengeObjectiveListItemViews[playChallengeObjectiveWrapper.id]!
		
		pcoliv.set(isCompleteYN: true)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
	fileprivate func doDisplayPlayChallengeObjectiveListItemView(wrapper: PlayChallengeObjectiveWrapper) {
		
		// Create PlayChallengeObjectiveListItemView
		let playChallengeObjectiveListItemView: 				ProtocolPlayChallengeObjectiveListItemView = self.doCreatePlayChallengeObjectiveListItem(wrapper: wrapper)
		
		// Set in collection
		self.playChallengeObjectiveListItemViews[wrapper.id] 	= playChallengeObjectiveListItemView
		
		// Present PlayChallengeObjectiveListItemView
		self.viewManager!.present(playChallengeObjectiveListItemView: playChallengeObjectiveListItemView)
		
	}
	
	fileprivate func doCreatePlayChallengeObjectiveListItem(wrapper: PlayChallengeObjectiveWrapper) -> ProtocolPlayChallengeObjectiveListItemView {
		
		return self.delegate!.playActiveChallengeViewControlManager(createPlayChallengeObjectiveListItemViewFor: wrapper)
		
	}
	
}
