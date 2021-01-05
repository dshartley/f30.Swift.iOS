//
//  MC1ControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View
import SFSerialization

/// Manages the MC1 control layer
public class MC1ControlManager: PlayExperienceStepExerciseViewControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	
	// MARK: - Private Stored Properties

	fileprivate var img1s: [String:ProtocolImg1] = [String:ProtocolImg1]()
	

	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public override init(modelManager: ModelManager, viewManager: PlayExperienceStepExerciseViewViewManagerBase) {
		super.init(modelManager: modelManager, viewManager: viewManager)

	}
	
	
	// MARK: - Public Methods

	public func getCanCheckYN() -> Bool {
		
		var result: 	Bool = false
		
		// Go through each item
		for img1 in self.img1s.values {
		
			// Check isSelected
			if (img1.isSelected) {
			
				result 	= true
				break
				
			}
			
		}
		
		return result
		
	}
	
	
	// MARK: - Override Methods
	
	public override func display() {
		
		guard (self.playExperienceStepExerciseWrapper != nil && self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData != nil) else { return }
		
		// Get text
		//let text: String = self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData!.get(key: "\(PlayExperienceStepExerciseContentDataKeys.Text)") ?? ""
		
		// TODO: A fudge but kind of how we want to do it
		let ctw: DataJSONWrapper? = self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData!.challengeTextItemsWrapper
		var tw: DataJSONWrapper? = nil
		if (ctw != nil && ctw!.Items.count > 0) { tw = ctw!.Items[0] }
		let text: String = tw?.getParameterValue(key: "Text") ?? "<not set>"
		
		(self.viewManager! as! MC1ViewManager).displayText(text: text)

		
		// Get img1ItemsWrapper
		let img1ItemsWrapper: 					DataJSONWrapper? = self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData!.img1ItemsWrapper
		
		// Go through each item
		for w in img1ItemsWrapper!.Items {
			
			// Create img1Wrapper
			let img1Wrapper: 					Img1Wrapper = Img1Wrapper(wrapper: w)
			
			// Get modelItemAssetDataWrapper
			let modelItemAssetDataWrapper: 		ModelItemAssetDataItemWrapper? = self.playExperienceStepExerciseWrapper!.modelItemAssetDataWrapper!.get(key: img1Wrapper.key)
			
			// Set imageData
			img1Wrapper.imageData 				= modelItemAssetDataWrapper?.assetData as? Data
			
			// Display Img1
			self.doDisplayImg1(wrapper: img1Wrapper)
		}
		
	}
	
	
	// MARK: - Private Methods

	fileprivate func doDisplayImg1(wrapper: Img1Wrapper) {
		
		// Create Img1
		let img1:					ProtocolImg1 = self.doCreateImg1(wrapper: wrapper)
		
		// Set in collection
		self.img1s[wrapper.key] 	= img1
		
		// Present Img1
		(self.viewManager! as! MC1ViewManager).present(img1: img1)
		
	}
	
	fileprivate func doCreateImg1(wrapper: Img1Wrapper) -> ProtocolImg1 {
		
		return (self.delegate! as! ProtocolMC1ControlManagerDelegate).mc1ControlManager(createImg1For: wrapper)
		
	}
	
}
