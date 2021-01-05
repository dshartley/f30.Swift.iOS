//
//  PlayGameDataAttributeDataWrapper.swift
//  f30Model
//
//  Created by David on 14/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A wrapper for a PlayGameDataAttributeDataWrapper model item
public class PlayGameDataAttributeDataWrapper {
	
	// MARK: - Private Stored Properties
	
	fileprivate var wrapper: DataJSONWrapper?
	
	
	// MARK: - Public Stored Properties
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(attributeData: String) {
		
		self.set(attributeData: attributeData)
		
	}
	
	
	// MARK: - Public Methods
	
	public func get(key: String) -> String? {
		
		guard (wrapper != nil) else { return nil }
		
		return wrapper!.getParameterValue(key: key)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func set(attributeData: String) {
		
		guard (attributeData.count > 0) else { return }
		
		// Get DataJSONWrapper from contentData
		self.wrapper = JSONHelper.DeserializeDataJSONWrapper(dataString: attributeData)
		
		guard (self.wrapper != nil) else { return }
		
	}
	
}
