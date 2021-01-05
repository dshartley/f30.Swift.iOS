//
//  PlayExperienceViewControlManagerBase.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFController
import f30Model
import f30View

/// A base class for classes which manage the PlayExperienceView control layer
public class PlayExperienceViewControlManagerBase: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayExperienceViewControlManagerDelegate?
	public var viewManager:								PlayExperienceViewViewManagerBase?
	public fileprivate(set) var playExperienceWrapper:	PlayExperienceWrapper?
	
	
	// MARK: - Private Stored Properties

	fileprivate var playExperienceStepMarkerViews: 		[String:ProtocolPlayExperienceStepMarkerView] = [String:ProtocolPlayExperienceStepMarkerView]()
	fileprivate var activePlayExperienceStepWrapper:	PlayExperienceStepWrapper? = nil
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayExperienceViewViewManagerBase) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper) {
		
		self.playExperienceWrapper 				= playExperienceWrapper
		
		self.playExperienceStepMarkerViews 		= [String:ProtocolPlayExperienceStepMarkerView]()
		self.activePlayExperienceStepWrapper 	= nil
		
	}
	
	public func displayPlayExperience() {
		
		guard (self.playExperienceWrapper != nil && self.playExperienceWrapper!.playExperienceContentData != nil) else { return }
		
		// Get title
		let title: String = self.playExperienceWrapper!.playExperienceContentData!.get(key: "\(PlayExperienceContentDataKeys.Title)") ?? ""
		
		self.viewManager!.displayTitle(title: title)
		
	}
	
	public func displayPlayExperienceSteps() {

		guard (self.playExperienceWrapper != nil) else { return }
		
		// Create orderedList
		var orderedList: 	[Int:PlayExperienceStepWrapper] = [Int:PlayExperienceStepWrapper]()
		
		// Go through each item
		for pesw in self.playExperienceWrapper!.playExperienceSteps().values {
			
			// Get index
			var index: 		Int = -1
			
			if (pesw.playExperienceStepContentData != nil) {
				
				index 		= Int(pesw.playExperienceStepContentData!.get(key: "\(PlayExperienceStepContentDataKeys.Index)") ?? "0")!
				
				if (orderedList.keys.contains(index)) { index = -1 }
				
			}
			
			if (index == -1) { index = orderedList.count }
			
			// Put item in orderedList
			orderedList[index] = pesw
			
		}
		
		if (orderedList.count == 0) { return }
		
		// Go through each item
		for index in 0...orderedList.count - 1 {
			
			let pesw: 		PlayExperienceStepWrapper? = orderedList[index]
			
			if (pesw != nil) {
				
				// Set active playExperienceStepWrapper
				if (self.activePlayExperienceStepWrapper == nil && !pesw!.isCompleteYN) {
					
					self.doSetActivePlayExperienceStep(wrapper: pesw!)
					
				} else {
					
					pesw!.isActiveYN = false
					
				}
				
				// Display PlayExperienceStepWrapper
				self.doDisplayPlayExperienceStepMarkerView(wrapper: pesw!)
				
			}
			
		}
		// TODO:
		// For each step;
		//		Get title, iscompleteyn, thumbnailimagename, index
		//		Create step thumbnail view / step marker view???
		//		Display in list
		// Display 'line' between each step
		// Display 'target' thumbnail at end
		// Set mode (ie. completed, available, not available)
		
		
	}
	
	public func doAfterPlayExperienceStepCompleted(playExperienceStepWrapper: PlayExperienceStepWrapper) {
		
		// Go to the next PlayExperienceStep, or;
		// If complete return PlayExperienceResult to delegate
		
		playExperienceStepWrapper.isCompleteYN 	= true
		
		// Get playExperienceStepMarkerView
		let pesmv: 								ProtocolPlayExperienceStepMarkerView = self.playExperienceStepMarkerViews[playExperienceStepWrapper.id]!
		
		pesmv.set(isCompleteYN: true)
		
		// Set next activePlayExperienceStepWrapper
		self.doSetNextActivePlayExperienceStep()
		
		var isExperienceCompleteYN: 			Bool = true
		
		// Go through each item
		for pest in self.playExperienceWrapper!.playExperienceSteps().values {
			
			if (pest.playExperienceStepResult == nil) {
				
				isExperienceCompleteYN 			= false
				
				return
				
			}
			
		}
		
		// Check isExperienceCompleteYN
		if (isExperienceCompleteYN) {
			
			self.playExperienceWrapper!.isCompleteYN = true
			
			// Set result
			self.doSetPlayExperienceResult()
			
			// Notify the delegate
			self.delegate?.playExperienceViewControlManager(playExperienceCompleted: self.playExperienceWrapper!, sender: self)
			
		}
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods

	fileprivate func doSetActivePlayExperienceStep(wrapper: PlayExperienceStepWrapper) {
		
		// Unset previous activePlayExperienceStepWrapper
		if (self.activePlayExperienceStepWrapper != nil) {
			
			self.activePlayExperienceStepWrapper!.isActiveYN 		= false
			
		}
		
		self.activePlayExperienceStepWrapper 						= wrapper
		self.activePlayExperienceStepWrapper!.isActiveYN 			= true
		
	}
	
	fileprivate func doSetNextActivePlayExperienceStep() {
		
		// Get index of activePlayExperienceStepWrapper
		var activeIndex: 		Int = 0
		
		if (self.activePlayExperienceStepWrapper != nil) {
			
			activeIndex 		= Int(self.activePlayExperienceStepWrapper!.playExperienceStepContentData!.get(key: "\(PlayExperienceStepContentDataKeys.Index)") ?? "0")!
			
		}

		var nextItem: 			PlayExperienceStepWrapper? = nil
		var nextIndex: 			Int = 0
		
		// Go through each item
		for pestw in self.playExperienceWrapper!.playExperienceSteps().values {
			
			pestw.isActiveYN 	= false
			
			// Get index
			let index 			= Int(pestw.playExperienceStepContentData!.get(key: "\(PlayExperienceStepContentDataKeys.Index)") ?? "0")!
			
			// Get nextItem
			if (index > activeIndex && (nextItem == nil || index < nextIndex)) {
					
				nextItem 		= pestw
				nextIndex 		= index

			}
			
		}
		
		// Set nextItem isActiveYN
		if (nextItem != nil) {
			
			nextItem!.isActiveYN 					= true
			self.activePlayExperienceStepWrapper 	= nextItem
			
		} else {
			
			self.activePlayExperienceStepWrapper 	= nil
			
		}
		
		// Go through each item
		for pestw in self.playExperienceWrapper!.playExperienceSteps().values {
			
			// Get playExperienceStepMarkerView
			let pesmv: 			ProtocolPlayExperienceStepMarkerView = self.playExperienceStepMarkerViews[pestw.id]!
			
			// Set isActiveYN
			pesmv.set(isActiveYN: pestw.isActiveYN)
			
		}
		
	}
	
	fileprivate func doSetPlayExperienceResult() {
		
		// Create PlayExperienceResultWrapper
		let result: 				PlayExperienceResultWrapper = PlayExperienceResultWrapper(onCompleteData: self.playExperienceWrapper!.onCompleteData)
		
		// Nb: Points have been appended in the constructor
		
		result.playExperienceID 	= self.playExperienceWrapper!.id

		// Go through each item
		for pesw in self.playExperienceWrapper!.playExperienceSteps().values {
			
			// Append points
			result.playExperienceOnCompleteData!.appendPoints(from: pesw.playExperienceStepOnCompleteData!)
			
		}

		// Set result in playExperienceWrapper
		self.playExperienceWrapper!.playExperienceResult = result
		
	}
	
	fileprivate func doDisplayPlayExperienceStepMarkerView(wrapper: PlayExperienceStepWrapper) {
		
		// Create PlayExperienceStepMarkerView
		let playExperienceStepMarkerView: 				ProtocolPlayExperienceStepMarkerView = self.doCreatePlayExperienceStepMarkerView(wrapper: wrapper)
		
		// Set in collection
		self.playExperienceStepMarkerViews[wrapper.id] 	= playExperienceStepMarkerView
		
		// Present PlayExperienceStepMarkerView
		self.viewManager!.present(playExperienceStepMarkerView: playExperienceStepMarkerView)
		
	}
	
	fileprivate func doCreatePlayExperienceStepMarkerView(wrapper: PlayExperienceStepWrapper) -> ProtocolPlayExperienceStepMarkerView {
		
		return self.delegate!.playExperienceViewControlManager(createPlayExperienceStepMarkerViewFor: self.playExperienceWrapper!, playExperienceStepWrapper: wrapper)
		
	}
}
