//
//  PlayChallengeObjectiveTypeDefinitionDataWrapper.swift
//  f30Model
//
//  Created by David on 05/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A wrapper for a PlayChallengeObjectiveTypeDefinitionDataWrapper model item
public class PlayChallengeObjectiveTypeDefinitionDataWrapper {
	
	// MARK: - Private Stored Properties
	
	fileprivate var 				wrapper: DataJSONWrapper?
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var 	definitionCodesWrapper: DataJSONWrapper = DataJSONWrapper()
	public fileprivate(set) var 	definitionParamsWrapper: DataJSONWrapper = DataJSONWrapper()
	
	
	// MARK: - Public Computed Properties
	
	
	// MARK: - Initializers
	
	fileprivate init() {
		
	}
	
	public init(definitionData: String) {
		
		self.set(definitionData: definitionData)
		
	}
	
	
	// MARK: - Public Methods
	
	public func hasDefinitionCode(code: String) -> Bool {
		
		var result: Bool = false
		
		result = self.definitionCodesWrapper.hasParameterYN(key: code)
		
		return result
		
	}
	
	public func getDefinitionParam(key: String) -> String? {
		
		var result: String? = nil
		
		result = self.definitionParamsWrapper.getParameterValue(key: key)
		
		return result
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func set(definitionData: String) {
		
		guard (definitionData.count > 0) else { return }
		
		// Get DataJSONWrapper from DefinitionData
		self.wrapper = JSONHelper.DeserializeDataJSONWrapper(dataString: definitionData)
		
		guard (self.wrapper != nil) else { return }
		
		self.setDefinitionCodes()
		self.setDefinitionParams()
		
	}
	
	fileprivate func setDefinitionCodes() {
		
		guard (self.wrapper != nil) else { return }
		
		// Get definitionCodesWrapper
		self.definitionCodesWrapper = self.wrapper!.getItem(id: "\(PlayChallengeObjectiveDefinitionDataKeys.DefinitionCodes)") ?? DataJSONWrapper()
		
	}
	
	fileprivate func setDefinitionParams() {
		
		guard (self.wrapper != nil) else { return }
		
		// Get definitionParamsWrapper
		self.definitionParamsWrapper = self.wrapper!.getItem(id: "\(PlayChallengeObjectiveDefinitionDataKeys.DefinitionParams)") ?? DataJSONWrapper()
		
	}
	
}
