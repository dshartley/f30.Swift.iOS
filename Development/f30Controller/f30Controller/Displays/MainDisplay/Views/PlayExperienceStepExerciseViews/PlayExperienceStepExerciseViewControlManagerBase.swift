//
//  PlayExperienceStepExerciseViewControlManagerBase.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFController
import f30Model
import f30View

/// A base class for classes which manage the PlayExperienceStepExerciseView control layer
open class PlayExperienceStepExerciseViewControlManagerBase: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:								ProtocolPlayExperienceStepExerciseViewControlManagerDelegate?
	public var viewManager:											PlayExperienceStepExerciseViewViewManagerBase?
	public fileprivate(set) var playExperienceWrapper: 				PlayExperienceWrapper?
	public fileprivate(set) var playExperienceStepExerciseWrapper:	PlayExperienceStepExerciseWrapper?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayExperienceStepExerciseViewViewManagerBase) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper) {
		
		self.playExperienceWrapper 				= playExperienceWrapper
		self.playExperienceStepExerciseWrapper 	= playExperienceStepExerciseWrapper
		
	}
	
	public func doAfterExperienceStepExerciseCompleted() {
		
		// Create PlayExperienceStepExerciseResultWrapper
		let result: 						PlayExperienceStepExerciseResultWrapper = PlayExperienceStepExerciseResultWrapper(onCompleteData: self.playExperienceStepExerciseWrapper!.onCompleteData)
		
		// Nb: Points have been appended in the constructor
		
		result.playExperienceID 			= self.playExperienceWrapper!.id
		result.playExperienceStepExerciseID = self.playExperienceStepExerciseWrapper!.id
		result.dateCompleted				= Date()
	
		// Set result in playExperienceStepExerciseWrapper
		self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseResult = result
		
	}
	
	
	// MARK: - Open [Overridable] Methods
	
	open func display() {
		
		// Override
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
