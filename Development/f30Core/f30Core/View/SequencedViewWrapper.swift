//
//  SequencedViewWrapper.swift
//  f30View
//
//  Created by David on 01/02/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import UIKit

public enum SequencedViewTypes {
	case PlayExperienceComplete
	case PlayExperienceStepComplete
	case PlayChallengeComplete
	case PlayChallengeObjectiveComplete
}

/// A wrapper for a SequencedView
public class SequencedViewWrapper {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var id: 	String = UUID().uuidString
	public var type: 					SequencedViewTypes = .PlayExperienceComplete
	public var index:					Int = 0
	public var hasBeenPresentedYN: 		Bool = false
	public var params:					[String:Any] = [String:Any]()

	
	// MARK: - Initializers
	
	public init() {
	}
	
	
	// MARK: - Public Methods
	
}
