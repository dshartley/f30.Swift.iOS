//
//  PlayMovePlayReferenceDataWrapper.swift
//  f30Model
//
//  Created by David on 05/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization
import f30Core

/// A wrapper for a PlayMovePlayReferenceDataWrapper model item
public class PlayMovePlayReferenceDataWrapper {
	
	// MARK: - Private Stored Properties
	
	fileprivate var wrapper: 						DataJSONWrapper?
	fileprivate let playReferenceTypeKey: 			String = "\(DataItemDataJSONWrapperKeys.PlayReferenceType)"
	fileprivate let playReferenceIDKey: 			String = "\(DataItemDataJSONWrapperKeys.PlayReferenceID)"
	fileprivate let playReferenceDataItemTypeKey: 	String = "\(DataItemDataJSONWrapperKeys.PlayReferenceDataItemType)"
	fileprivate let playReferenceDataItemIDKey: 	String = "\(DataItemDataJSONWrapperKeys.PlayReferenceDataItemID)"
	
	
	// MARK: - Public Stored Properties
	
	
	// MARK: - Public Computed Properties

	public var playReferenceType: PlayReferenceTypes {
		get {
			let i = Int(self.get(key: self.playReferenceTypeKey) ?? "1")!
			
			return PlayReferenceTypes(rawValue: i)!
		}
		set(value) {
			wrapper?.setParameterValue(key: self.playReferenceTypeKey, value: "\(value.rawValue)")
		}
	}
	
	public var playReferenceID: String {
		get {
			return self.get(key: self.playReferenceIDKey) ?? ""
		}
		set(value) {
			wrapper?.setParameterValue(key: self.playReferenceIDKey, value: value)
		}
	}
	
	public var playReferenceDataItemType: PlayReferenceDataItemTypes {
		get {
			let i = Int(self.get(key: self.playReferenceDataItemTypeKey) ?? "1")!
			
			return PlayReferenceDataItemTypes(rawValue: i)!
		}
		set(value) {
			wrapper?.setParameterValue(key: self.playReferenceDataItemTypeKey, value: "\(value.rawValue)")
		}
	}
	
	public var playReferenceDataItemID: String {
		get {
			return self.get(key: self.playReferenceDataItemIDKey) ?? ""
		}
		set(value) {
			wrapper?.setParameterValue(key: self.playReferenceDataItemIDKey, value: value)
		}
	}
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(playReferenceData: String) {
		
		self.set(playReferenceData: playReferenceData)
		
	}
	
	
	// MARK: - Public Methods
	
	public func get(key: String) -> String? {
		
		guard (wrapper != nil) else { return nil }
		
		return wrapper!.getParameterValue(key: key)
		
	}
	
	public func serialize() -> String {
		
		var 	result: String = ""
		
		guard (self.wrapper != nil) else { return result }
		
		result 	= JSONHelper.SerializeDataJSONWrapper(dataWrapper: self.wrapper!) ?? ""
		
		return result
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func set(playReferenceData: String) {
		
		guard (playReferenceData.count > 0) else { return }
		
		// Get DataJSONWrapper from playReferenceData
		self.wrapper = JSONHelper.DeserializeDataJSONWrapper(dataString: playReferenceData)
		
		guard (self.wrapper != nil) else { return }
		
	}
	
}
