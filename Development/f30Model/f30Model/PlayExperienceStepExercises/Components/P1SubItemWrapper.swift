//
//  P1SubItemWrapper.swift
//  f30Model
//
//  Created by David on 22/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization
import f30Core

/// A wrapper for a P1 sub item component
public class P1SubItemWrapper {
	
	// MARK: - Private Stored Properties
	
	fileprivate var wrapper: 		DataJSONWrapper?
	fileprivate var p1Wrapper: 		DataJSONWrapper?
	fileprivate let keyKey:			String = "\(DataItemDataJSONWrapperKeys.Key)"
	fileprivate let fileNameKey:	String = "\(DataItemDataJSONWrapperKeys.FileName)"
	fileprivate let textKey:		String = "\(DataItemDataJSONWrapperKeys.Text)"
	
	
	// MARK: - Public Stored Properties
	
	public var imageData:			Data? = nil

	
	// MARK: - Public Computed Properties
	
	public var key: String {
		get {
			return "\(self.p1Wrapper!.ID)_\(self.wrapper!.ID)"
		}
	}

	public var fileName: String {
		get {
			return self.wrapper!.getParameterValue(key: self.fileNameKey) ?? ""
		}
	}

	public var text: String {
		get {
			return self.wrapper!.getParameterValue(key: self.textKey) ?? ""
		}
	}
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(wrapper: DataJSONWrapper, p1Wrapper: DataJSONWrapper?) {
		
		self.wrapper 	= wrapper
		self.p1Wrapper 	= p1Wrapper
		
	}
	
	
	// MARK: - Public Methods

}

