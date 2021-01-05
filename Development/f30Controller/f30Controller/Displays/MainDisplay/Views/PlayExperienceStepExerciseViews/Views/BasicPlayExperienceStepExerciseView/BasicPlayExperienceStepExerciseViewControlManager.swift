//
//  BasicPlayExperienceStepExerciseViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Manages the BasicPlayExperienceStepExerciseView control layer
public class BasicPlayExperienceStepExerciseViewControlManager: PlayExperienceStepExerciseViewControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	
	// MARK: - Private Stored Properties

	fileprivate var playExperienceStepExerciseContentImageViews: 		[String:ProtocolImg1] = [String:ProtocolImg1]()
	

	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public override init(modelManager: ModelManager, viewManager: PlayExperienceStepExerciseViewViewManagerBase) {
		super.init(modelManager: modelManager, viewManager: viewManager)

	}
	
	
	// MARK: - Public Methods

	
	// MARK: - Override Methods
	
	public override func display() {
		
		guard (self.playExperienceStepExerciseWrapper != nil && self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData != nil) else { return }
		
		// Get text
		let text: String = self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData!.get(key: "\(PlayExperienceStepExerciseContentDataKeys.Text)") ?? ""
		
		(self.viewManager! as! BasicPlayExperienceStepExerciseViewViewManager).displayText(text: text)

//		// Go through each item
//		for item in self.playExperienceStepExerciseWrapper!.contentImages {
//
//			// Display ContentImage
//			self.doDisplayImg1(wrapper: item)
//
//		}
		
	}
	
	
	// MARK: - Private Methods
	
}
