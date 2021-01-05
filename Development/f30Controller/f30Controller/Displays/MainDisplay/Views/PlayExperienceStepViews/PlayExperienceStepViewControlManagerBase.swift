//
//  PlayExperienceStepViewControlManagerBase.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFController
import f30Model
import f30View

/// A base class for classes which manage the PlayExperienceStepView control layer
open class PlayExperienceStepViewControlManagerBase: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:									ProtocolPlayExperienceStepViewControlManagerDelegate?
	public var viewManager:										PlayExperienceStepViewViewManagerBase?
	public fileprivate(set) var playExperienceWrapper: 			PlayExperienceWrapper?
	public fileprivate(set) var playExperienceStepWrapper:		PlayExperienceStepWrapper?
	public var repeatedYN: 										Bool = false
	
	
	// MARK: - Private Stored Properties

	fileprivate var playExperienceStepExerciseWrappers:			[PlayExperienceStepExerciseWrapper]?
	fileprivate var currentPlayExperienceStepExerciseIndex:		Int = -1
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayExperienceStepViewViewManagerBase) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper) {
		
		self.playExperienceWrapper						= playExperienceWrapper
		self.playExperienceStepWrapper 					= playExperienceStepWrapper
		
		self.currentPlayExperienceStepExerciseIndex 	= -1
		
		self.createIndexedPlayExperienceStepExerciseWrappers()
		
	}
	
	public func doAfterPlayExperienceStepCompleted() {
		
		// Set result
		self.doSetPlayExperienceStepResult()
		
		// Notify the delegate
		self.delegate!.playExperienceStepViewControlManager(playExperienceStepCompleted: self.playExperienceStepWrapper!)
		
	}
	
	public func displayNextPlayExperienceStepExercise() {
		
		guard (self.playExperienceStepWrapper != nil && self.playExperienceStepExerciseWrappers != nil) else { return }
		
		// Increment currentPlayExperienceStepExerciseIndex
		self.currentPlayExperienceStepExerciseIndex += 1
		
		// Check currentPlayExperienceStepExerciseIndex
		guard (self.currentPlayExperienceStepExerciseIndex < self.playExperienceStepExerciseWrappers!.count) else { return }
		
		// Get PlayExperienceStepExerciseWrapper
		let pesew: 	PlayExperienceStepExerciseWrapper? = self.playExperienceStepExerciseWrappers![self.currentPlayExperienceStepExerciseIndex]

		guard (pesew != nil) else { return }
		
		// Display PlayExperienceStepExerciseWrapper
		self.doDisplayPlayExperienceStepExerciseView(playExperienceWrapper: self.playExperienceWrapper!, playExperienceStepExerciseWrapper: pesew!)

	}
	
	public func doAfterPlayExperienceStepExerciseCompleted(wrapper: PlayExperienceStepExerciseWrapper) {
		
		wrapper.isCompleteYN 					= true
		
		// Set result
		self.doSetPlayExperienceStepExerciseResult(wrapper: wrapper)
		
		// Check playExperienceStepCompleted
		self.doCheckPlayExperienceStepCompleted()
		
//		if (playExperienceStepCompletedYN) {
//
//			self.doAfterPlayExperienceStepCompleted()
//
//		}
		
	}
	
	
	// MARK: - Open [Overridable] Methods
	
	open func display() {
		
		// Override
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
	fileprivate func doDisplayPlayExperienceStepExerciseView(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper) {
		
		// Create PlayExperienceStepExerciseView
		let playExperienceStepExerciseView: 				ProtocolPlayExperienceStepExerciseView = self.doCreatePlayExperienceStepExerciseView(playExperienceWrapper: playExperienceWrapper, playExperienceStepExerciseWrapper: playExperienceStepExerciseWrapper)
		
		// Set in collection
		//self.playExperienceStepExerciseViews[wrapper.id] 	= playExperienceStepExerciseView
		
		// Present PlayExperienceStepExerciseView
		self.viewManager!.present(playExperienceStepExerciseView: playExperienceStepExerciseView)
		
	}
	
	fileprivate func doCreatePlayExperienceStepExerciseView(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper) -> ProtocolPlayExperienceStepExerciseView {
		
		return self.delegate!.playExperienceStepViewControlManager(createPlayExperienceStepExerciseViewFor: playExperienceWrapper, playExperienceStepExerciseWrapper: playExperienceStepExerciseWrapper)
		
	}
	
	fileprivate func createIndexedPlayExperienceStepExerciseWrappers() {
		
		self.playExperienceStepExerciseWrappers = [PlayExperienceStepExerciseWrapper]()
		
		guard (self.playExperienceStepWrapper != nil) else { return }
		
		// Go through each item
		for pesew in self.playExperienceStepWrapper!.playExperienceStepExercises().values {

			self.playExperienceStepExerciseWrappers!.append(pesew)
			
		}
		
	}
	
	fileprivate func doCheckPlayExperienceStepCompleted() {
	
		var isCompleteYN: 								Bool = true
		
		guard (self.playExperienceStepExerciseWrappers != nil) else { return }
		
		// Go through each item
		for pesew in self.playExperienceStepExerciseWrappers! {
			
			if (!pesew.isCompleteYN) { isCompleteYN 	= false }
			
		}
		
		self.playExperienceStepWrapper!.isCompleteYN 	= isCompleteYN

	}
	
	fileprivate func doSetPlayExperienceStepResult() {
	
		// Create PlayExperienceStepResultWrapper
		let result: 				PlayExperienceStepResultWrapper = PlayExperienceStepResultWrapper(onCompleteData: self.playExperienceStepWrapper!.onCompleteData)
		
		// Nb: Points have been appended in the constructor
		
		result.playExperienceID 	= self.playExperienceWrapper!.id
		result.playExperienceStepID = self.playExperienceStepWrapper!.id
		result.dateCompleted		= Date()
		result.repeatedYN 			= self.repeatedYN
		
		// Set result in playExperienceStepWrapper
		self.playExperienceStepWrapper!.playExperienceStepResult = result
		
	}

	fileprivate func doSetPlayExperienceStepExerciseResult(wrapper: PlayExperienceStepExerciseWrapper) {
		
		// Create PlayExperienceStepExerciseResultWrapper
		let result: 							PlayExperienceStepExerciseResultWrapper = PlayExperienceStepExerciseResultWrapper(onCompleteData: wrapper.onCompleteData)
		
		// Nb: Points have been appended in the constructor
		
		result.playExperienceID 				= self.playExperienceWrapper!.id
		result.playExperienceStepID 			= self.playExperienceStepWrapper!.id
		result.playExperienceStepExerciseID		= wrapper.id
		result.dateCompleted					= Date()
		result.repeatedYN 						= self.repeatedYN
		
		// Set result in playExperienceStepExerciseWrapper
		wrapper.playExperienceStepExerciseResult = result
		
	}
	
}
