//
//  PlayExperienceStepExerciseContentDataWrapper.swift
//  f30Model
//
//  Created by David on 05/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization
import f30Core

/// A wrapper for a PlayExperienceStepExerciseContentDataWrapper model item
public class PlayExperienceStepExerciseContentDataWrapper {
	
	// MARK: - Private Stored Properties
	
	fileprivate var wrapper: 				DataJSONWrapper?
	fileprivate let challengeTextItemsKey:	String = "\(DataItemDataJSONWrapperKeys.ChallengeTextItems)"
	fileprivate let img1ItemsKey:			String = "\(DataItemDataJSONWrapperKeys.Img1Items)"
	fileprivate let p1ItemsKey:				String = "\(DataItemDataJSONWrapperKeys.P1Items)"
	
	
	// MARK: - Public Stored Properties
	

	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(contentData: String) {
		
		self.set(contentData: contentData)
		
	}
	
	
	// MARK: - Public Methods
	
	public func get(key: String) -> String? {
		
		guard (wrapper != nil) else { return nil }
		
		return wrapper!.getParameterValue(key: key)
		
	}

	
	// MARK: - Public Methods; ChallengeTextItems
	
	public var challengeTextItemsWrapper: DataJSONWrapper? {
		get {
			return self.wrapper!.getItem(id: self.challengeTextItemsKey)
		}
	}
	
	public func getChallengeTextItem(index: Int) -> DataJSONWrapper? {
		
		var result: 						DataJSONWrapper? = nil
		
		// Get challengeTextItemsWrapper
		let challengeTextItemsWrapper: 		DataJSONWrapper? = self.challengeTextItemsWrapper
		
		guard (challengeTextItemsWrapper != nil) else { return nil }
		guard (challengeTextItemsWrapper!.Items.count > index) else { return nil }
		
		result = challengeTextItemsWrapper!.Items[index]
		
		return result
		
	}
	
	
	// MARK: - Public Methods; Img1Items
	
	public var img1ItemsWrapper: DataJSONWrapper? {
		get {
			return self.wrapper!.getItem(id: self.img1ItemsKey)
		}
	}
	
	public func getimg1Item(index: Int) -> DataJSONWrapper? {
		
		var result: 			DataJSONWrapper? = nil
		
		// Get img1ItemsWrapper
		let img1ItemsWrapper: 	DataJSONWrapper? = self.img1ItemsWrapper
		
		guard (img1ItemsWrapper != nil) else { return nil }
		guard (img1ItemsWrapper!.Items.count > index) else { return nil }
		
		result = img1ItemsWrapper!.Items[index]
		
		return result
		
	}
	

	// MARK: - Public Methods; P1Items
	
	public var p1ItemsWrapper: DataJSONWrapper? {
		get {
			return self.wrapper!.getItem(id: self.p1ItemsKey)
		}
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func set(contentData: String) {
		
		guard (contentData.count > 0) else { return }
		
		// Get DataJSONWrapper from contentData
		self.wrapper = JSONHelper.DeserializeDataJSONWrapper(dataString: contentData)
		
	}
	
}

