//
//  PlayChallengeObjectiveTypeRESTWebAPIModelAccessStrategy.swift
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

/// A strategy for accessing the PlayChallengeObjectiveType model data using a REST Web API
public class PlayChallengeObjectiveTypeRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "PlayChallengeObjectiveTypes")
		
	}
	
	
	// MARK: - Private Methods

	
	// MARK: - Override Methods
	
	
	// MARK: - Dummy Data Methods

}

// MARK: - Extension ProtocolPlayChallengeObjectiveTypeModelAccessStrategy

extension PlayChallengeObjectiveTypeRESTWebAPIModelAccessStrategy: ProtocolPlayChallengeObjectiveTypeModelAccessStrategy {
	
	// MARK: - Public Methods

}

