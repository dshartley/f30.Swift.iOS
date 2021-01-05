//
//  ModelItemAssetDataItemWrapper.swift
//  f30Model
//
//  Created by David on 05/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization
import f30Core

/// A wrapper for a ModelItemAssetDataItem
public class ModelItemAssetDataItemWrapper {
	
	// MARK: - Private Stored Properties
	
	fileprivate let keyKey:					String = "\(DataItemDataJSONWrapperKeys.Key)"
	fileprivate let fileNameKey:			String = "\(DataItemDataJSONWrapperKeys.FileName)"
	
	
	// MARK: - Public Stored Properties

	public fileprivate(set) var wrapper: 	DataJSONWrapper?
	public var assetData: 					Any?

	
	// MARK: - Public Computed Properties
	
	public var key: String? {
		get {
			return self.wrapper!.getParameterValue(key: self.keyKey) ?? ""
		}
		set(value) {
			self.wrapper!.setParameterValue(key: self.keyKey, value: value ?? "")
		}
	}
	
	public var fileName: String? {
		get {
			return self.wrapper!.getParameterValue(key: self.fileNameKey) ?? ""
		}
		set(value) {
			self.wrapper!.setParameterValue(key: self.fileNameKey, value: value ?? "")
		}
	}
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}

	public init(wrapper: DataJSONWrapper) {

		self.wrapper = wrapper
		
	}
	
	
	// MARK: - Public Methods
	
	
	// MARK: - Private Methods
	
}
