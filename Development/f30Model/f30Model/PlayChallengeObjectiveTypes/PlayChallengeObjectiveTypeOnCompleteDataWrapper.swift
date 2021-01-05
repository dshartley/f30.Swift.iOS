//
//  PlayChallengeObjectiveTypeOnCompleteDataWrapper.swift
//  f30Model
//
//  Created by David on 13/10/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A wrapper for a PlayChallengeObjectiveTypeOnCompleteDataWrapper model item
public class PlayChallengeObjectiveTypeOnCompleteDataWrapper: OnCompleteDataWrapperBase {
	
	// MARK: - Private Stored Properties
	

	// MARK: - Public Stored Properties
	
	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
		
	}
	
	public override init(onCompleteData: String) {
		super.init(onCompleteData: onCompleteData)
		
	}
	
	
	// MARK: - Public Methods
	
	
	// MARK: - Override Methods
	
	public override func set(onCompleteData: String) {
		
		super.set(onCompleteData: onCompleteData)
		
		// TODO:
		//
		//		// NumberOfPoints
		//		self.numberOfPoints 	= Int(wrapper?.getParameterValue(key: "NumberOfPoints") ?? "0")!
		//
		//		// NumberOfFeathers
		//		self.numberOfFeathers 	= Int(wrapper?.getParameterValue(key: "NumberOfFeathers") ?? "0")!
		
	}
	
	
	// MARK: - Private Methods
	
}
