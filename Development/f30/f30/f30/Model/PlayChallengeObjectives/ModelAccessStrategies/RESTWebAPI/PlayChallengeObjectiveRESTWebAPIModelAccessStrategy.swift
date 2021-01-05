//
//  PlayChallengeObjectiveRESTWebAPIModelAccessStrategy.swift
//  f30
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSocial
import SFSerialization
import SFNet
import f30Core
import f30Model

/// A strategy for accessing the PlayChallengeObjective model data using a REST Web API
public class PlayChallengeObjectiveRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "PlayChallengeObjectives")
		
	}
	
	
	// MARK: - Private Methods

	
	// MARK: - Override Methods
	
	
	// MARK: - Dummy Data Methods

}

// MARK: - Extension ProtocolPlayChallengeObjectiveModelAccessStrategy

extension PlayChallengeObjectiveRESTWebAPIModelAccessStrategy: ProtocolPlayChallengeObjectiveModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func completePlayChallengeObjective(item: ProtocolModelItem, oncomplete completionHandler: @escaping (Error?) -> Void) {
		
	}

}

