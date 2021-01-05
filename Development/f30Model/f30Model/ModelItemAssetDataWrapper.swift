//
//  ModelItemAssetDataWrapper.swift
//  f30Model
//
//  Created by David on 05/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A wrapper for a ModelItemAssetData
public class ModelItemAssetDataWrapper {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties

	public fileprivate(set) var wrapper: 	DataJSONWrapper?
	public fileprivate(set) var items: 		[ModelItemAssetDataItemWrapper] = [ModelItemAssetDataItemWrapper]()
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}

	public init(wrapper: DataJSONWrapper) {

		self.wrapper = wrapper
		
		self.doDeserialize()
		
	}
	
	
	// MARK: - Public Methods

	public func add() -> ModelItemAssetDataItemWrapper {
		
		// Create DataJSONWrapper
		let w: 		DataJSONWrapper = DataJSONWrapper()
		
		self.wrapper!.Items.append(w)
		
		// Create ModelItemAssetDataItemWrapper
		let item: 	ModelItemAssetDataItemWrapper = ModelItemAssetDataItemWrapper(wrapper: w)
		
		self.items.append(item)
		
		return item
		
	}

	public func remove(key: String) {
		
		var i: 	ModelItemAssetDataItemWrapper? = nil
		
		// Go through each item
		for item in self.items {
			
			if (item.key != key) { continue }
			
			i 	= item
			break
			
		}
		
		if (i == nil) { return }
		
		self.items = self.items.filter(){ $0 !== i }
		
		self.wrapper!.deleteItem(item: i!.wrapper!)
		
	}

	public func exists(key: String) -> Bool {
		
		var result: Bool = false
		
		// Go through each item
		for item in self.items {
			
			if (item.key == key) {
				
				result = true
				break
				
			}

		}
		
		return result
		
	}

	public func get(key: String) -> ModelItemAssetDataItemWrapper? {
		
		var result: ModelItemAssetDataItemWrapper? = nil
		
		// Go through each item
		for item in self.items {
			
			if (item.key != key) { continue }

			result = item
			break
			
		}
		
		return result
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func doDeserialize() {
		
		guard (self.wrapper != nil) else { return }
		
		self.items 			= [ModelItemAssetDataItemWrapper]()
		
		// Go through each item
		for w in self.wrapper!.Items {
			
			// Create ModelItemAssetDataItemWrapper
			let wrapper: 	ModelItemAssetDataItemWrapper = ModelItemAssetDataItemWrapper(wrapper: w)
			
			self.items.append(wrapper)
			
		}
		
	}
	
}
