//
//  PlayExperienceStepExerciseWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core
import SFSerialization

/// A wrapper for a PlayExperienceStepExercise model item
public class PlayExperienceStepExerciseWrapper {
	
	// MARK: - Private Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:					    					String = ""
	public var playSubsetID:								String = ""
	public var name:										String = ""
	public var playExperienceStepExerciseType:				PlayExperienceStepExerciseTypes = .Basic
	public var isCompleteYN:								Bool = false
	public fileprivate(set) var contentData:				String = ""
	public var playExperienceStepExerciseContentData:		PlayExperienceStepExerciseContentDataWrapper? = nil
	public fileprivate(set) var onCompleteData:				String = ""
	public var playExperienceStepExerciseOnCompleteData:	PlayExperienceStepExerciseOnCompleteDataWrapper? = nil
	public var playExperienceStepExerciseResult:			PlayExperienceStepExerciseResultWrapper? = nil
	public var modelItemAssetDataWrapper:					ModelItemAssetDataWrapper? = nil
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayExperienceStepExerciseWrapper]) -> PlayExperienceStepExerciseWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playExperienceStepExerciseContentData 		= nil
		self.playExperienceStepExerciseOnCompleteData 	= nil
		self.playExperienceStepExerciseResult 			= nil
		
	}
	
	public func set(contentData: String) {
		
		self.contentData 							= contentData
		
		// Create PlayExperienceStepExerciseContentDataWrapper
		self.playExperienceStepExerciseContentData 	= PlayExperienceStepExerciseContentDataWrapper(contentData: contentData)
		
		// Generate assetData
		self.generateModelItemAssetDataFromContentData()
		
	}
	
	public func set(onCompleteData: String) {
		
		self.onCompleteData 							= onCompleteData
		
		// Create PlayExperienceStepExerciseOnCompleteDataWrapper
		self.playExperienceStepExerciseOnCompleteData 	= PlayExperienceStepExerciseOnCompleteDataWrapper(onCompleteData: onCompleteData)
		
	}
	

	// MARK: - Private Methods; ModelItemAssetData
	
	fileprivate func generateModelItemAssetDataFromContentData() {
		
		// Create modelItemAssetDataWrapper
		self.modelItemAssetDataWrapper 	= ModelItemAssetDataWrapper(wrapper: DataJSONWrapper())
		
		// Img1 items
		self.generateModelItemAssetDataImg1Items()

		// P1 items
		self.generateModelItemAssetDataP1Items()
		
	}

	
	// MARK: - Private Methods; Img1
	
	fileprivate func generateModelItemAssetDataImg1Items() {
		
		guard (self.playExperienceStepExerciseContentData!.img1ItemsWrapper != nil) else { return }
		
		// Go through each item
		for i in self.playExperienceStepExerciseContentData!.img1ItemsWrapper!.Items {
			
			let assetKey: 				String = i.ID
			let fileName: 				String = i.getParameterValue(key: "FileName")!
			
			// Create ModelItemAssetDataItemWrapper
			let item: 					ModelItemAssetDataItemWrapper = self.modelItemAssetDataWrapper!.add()
			
			item.key 					= assetKey
			item.fileName 				= fileName
			
		}
		
	}
	
	
	// MARK: - Private Methods; P1
	
	fileprivate func generateModelItemAssetDataP1Items() {
		
		guard (self.playExperienceStepExerciseContentData!.p1ItemsWrapper != nil) else { return }
		
		// Go through each item
		for i in self.playExperienceStepExerciseContentData!.p1ItemsWrapper!.Items {

			// Go through each item
			for subItem in i.Items {
				
				let assetKey: 		String = "\(i.ID)_\(subItem.ID)"
				let fileName: 		String = subItem.getParameterValue(key: "FileName")!
				
				// Create ModelItemAssetDataItemWrapper
				let item: 			ModelItemAssetDataItemWrapper = self.modelItemAssetDataWrapper!.add()
				
				item.key 			= assetKey
				item.fileName 		= fileName
				
			}
	
		}
		
	}
}
