//
//  ModelFactory.swift
//  f30
//
//  Created by David on 09/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Model

/// Creates model administrators
public class ModelFactory {

	// MARK: - Initializers
	
	private init() {
		
	}
	
	
	// MARK: - Public Class Computed Properties
	
	fileprivate static var _modelManager: ModelManager?

	public class var modelManager: ModelManager {
		get {
			if (_modelManager == nil) {
				_modelManager = ModelManager(storageDateFormatter: ModelFactory.storageDateFormatter)
			}

			return _modelManager!
		}
	}
	
	fileprivate static var _storageDateFormatter: DateFormatter?
	
	public class var storageDateFormatter: DateFormatter {
		get {
			if (_storageDateFormatter == nil) {
				
				// Get dateFormatter
				_storageDateFormatter 				= DateFormatter()
				_storageDateFormatter!.timeZone 	= TimeZone(secondsFromGMT: 0)
				
				// "dd-MM-yyyy HH:mm:ss a"
				_storageDateFormatter!.dateFormat	= "dd-MM-yyyy HH:mm:ss a"
				
			}
			
			return _storageDateFormatter!
		}
	}
	
	
	// MARK: - Public Class Methods
	

	// MARK: - PlaySubset
	
	public class func setupPlaySubsetModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlaySubsetRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlaySubsetModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayResult
	
	public class func setupPlayResultModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayResultRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayResultModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayGame
	
	public class func setupPlayGameModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayGameRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayGameModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayGameData
	
	public class func setupPlayGameDataModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayGameDataRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayGameDataModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	

	// MARK: - PlayAreaToken
	
	public class func setupPlayAreaTokenModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaTokenRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaTokenModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	

	// MARK: - PlayAreaTile
	
	public class func setupPlayAreaTileModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaTileRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaTileModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayAreaTileType
	
	public class func setupPlayAreaTileTypeModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaTileTypeRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaTileTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayAreaTileData
	
	public class func setupPlayAreaTileDataModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaTileDataRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaTileDataModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayMove
	
	public class func setupPlayMoveModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayMoveRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayMoveModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayAreaCell
	
	public class func setupPlayAreaCellModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaCellRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaCellModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayAreaCellType
	
	public class func setupPlayAreaCellTypeModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaCellTypeRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaCellTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayAreaPath
	
	public class func setupPlayAreaPathModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaPathRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaPathModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayAreaPathPoint
	
	public class func setupPlayAreaPathPointModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayAreaPathPointRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayAreaPathPointModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayExperience
	
	public class func setupPlayExperienceModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayExperienceRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayExperienceModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayExperienceStep
	
	public class func setupPlayExperienceStepModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayExperienceStepRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayExperienceStepModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayExperiencePlayExperienceStepLink
	
	public class func setupPlayExperiencePlayExperienceStepLinkModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayExperiencePlayExperienceStepLinkRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayExperiencePlayExperienceStepLinkModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayExperienceStepExercise
	
	public class func setupPlayExperienceStepExerciseModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayExperienceStepExerciseRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayExperienceStepExerciseModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayExperienceStepPlayExperienceStepExerciseLink
	
	public class func setupPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayExperienceStepPlayExperienceStepExerciseLinkRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayChallenge
	
	public class func setupPlayChallengeModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayChallengeRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayChallengeModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayChallengeType
	
	public class func setupPlayChallengeTypeModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayChallengeTypeRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayChallengeTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
	
	// MARK: - PlayChallengeObjective
	
	public class func setupPlayChallengeObjectiveModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayChallengeObjectiveRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayChallengeObjectiveModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}

	
	// MARK: - PlayChallengeObjectiveType
	
	public class func setupPlayChallengeObjectiveTypeModelAdministrator(modelManager: ModelManager) {
		
		// Connection string
		let connectionString: 		String = ""
		
		let modelAccessStrategy: 	ProtocolModelAccessStrategy = PlayChallengeObjectiveTypeRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		modelManager.setupPlayChallengeObjectiveTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}

	
	// MARK: - UserProfile

	public class func setupUserProfileModelAdministrator(modelManager: ModelManager) {

		// Connection string
		let connectionString: 		String = ""

		let modelAccessStrategy: 	ProtocolModelAccessStrategy = UserProfileFirebaseModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)

		modelManager.setupUserProfileModelAdministrator(modelAccessStrategy: modelAccessStrategy)
		
	}
	
}
