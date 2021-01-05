//
//  MP1ControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View
import SFSerialization

/// Manages the MP1 control layer
public class MP1ControlManager: PlayExperienceStepExerciseViewControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	
	// MARK: - Private Stored Properties

	fileprivate var p1SubItems: [String:ProtocolP1SubItem] = [String:ProtocolP1SubItem]()
	

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
		
//		// Go through each item
//		for p1 in self.p1s.values {
//
//			// Check isSelected
//			if (p1.isSelected) {
//
//				result 	= true
//				break
//
//			}
//
//		}
		
		return result
		
	}
	
	
	// MARK: - Override Methods
	
	public override func display() {
		
		guard (self.playExperienceStepExerciseWrapper != nil && self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData != nil) else { return }
		
		// Get p1ItemsWrapper
		let p1ItemsWrapper: 						DataJSONWrapper? = self.playExperienceStepExerciseWrapper!.playExperienceStepExerciseContentData!.p1ItemsWrapper
		
		// Go through each item
		for w in p1ItemsWrapper!.Items {
			
			// Go through each item
			for subItemWrapper in w.Items {
				
				// Create p1SubItemWrapper
				let p1SubItemWrapper: 				P1SubItemWrapper = P1SubItemWrapper(wrapper: subItemWrapper, p1Wrapper: w)
				
				// Get modelItemAssetDataWrapper
				let modelItemAssetDataWrapper: 		ModelItemAssetDataItemWrapper? = self.playExperienceStepExerciseWrapper!.modelItemAssetDataWrapper!.get(key: p1SubItemWrapper.key)
				
				// Set imageData
				p1SubItemWrapper.imageData 			= modelItemAssetDataWrapper?.assetData as? Data
				
				// Display P1 sub item
				self.doDisplayP1SubItem(wrapper: p1SubItemWrapper)
				
			}

		}
		
	}
	
	
	// MARK: - Private Methods

	fileprivate func doDisplayP1SubItem(wrapper: P1SubItemWrapper) {
		
		// Create P1SubItem
		let p1SubItem:					ProtocolP1SubItem = self.doCreateP1SubItem(wrapper: wrapper)
		
		// Set in collection
		self.p1SubItems[wrapper.key] 	= p1SubItem
		
		// Present P1
		(self.viewManager! as! MP1ViewManager).present(p1SubItem: p1SubItem)
		
	}
	
	fileprivate func doCreateP1SubItem(wrapper: P1SubItemWrapper) -> ProtocolP1SubItem {
		
		return (self.delegate! as! ProtocolMP1ControlManagerDelegate).mp1ControlManager(createP1SubItemFor: wrapper)
		
	}
	
}
