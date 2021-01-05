//
//  ProtocolPlayChallengeObjectiveModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Defines a class which provides a strategy for accessing the PlayChallengeObjective model data
public protocol ProtocolPlayChallengeObjectiveModelAccessStrategy {
	
	// MARK: - Methods

	func completePlayChallengeObjective(item: ProtocolModelItem, oncomplete completionHandler:@escaping (Error?) -> Void)
	
}
