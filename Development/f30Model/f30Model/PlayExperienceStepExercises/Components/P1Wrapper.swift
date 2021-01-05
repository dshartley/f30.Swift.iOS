//
//  P1Wrapper.swift
//  f30Model
//
//  Created by David on 22/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization
import f30Core

/// A wrapper for a P1 component
public class P1Wrapper {
	
	// MARK: - Private Stored Properties
	
	fileprivate var wrapper: 		DataJSONWrapper?
	fileprivate let keyKey:			String = "\(DataItemDataJSONWrapperKeys.Key)"
	fileprivate let fileNameKey:	String = "\(DataItemDataJSONWrapperKeys.FileName)"
	fileprivate let valueKey:		String = "\(DataItemDataJSONWrapperKeys.Value)"
	fileprivate let captionKey:		String = "\(DataItemDataJSONWrapperKeys.Caption)"
	
	
	// MARK: - Public Stored Properties
	
	public var imageData:			Data? = nil

	
	// MARK: - Public Computed Properties
	
	public var key: String {
		get {
			return self.wrapper!.ID
		}
	}

	public var fileName: String {
		get {
			return self.wrapper!.getParameterValue(key: self.fileNameKey) ?? ""
		}
	}
	
	public var value: String {
		get {
			return self.wrapper!.getParameterValue(key: self.valueKey) ?? "0"
		}
	}
	
	public var caption: String {
		get {
			return self.wrapper!.getParameterValue(key: self.captionKey) ?? ""
		}
	}
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(wrapper: DataJSONWrapper) {
		
		self.wrapper = wrapper
		
	}
	
	
	// MARK: - Public Methods

}

