//
//  ModelManager.swift
//  f30Model
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFModel

/// Manages the model layer and provides access to the model administrators
public class ModelManager: ModelManagerBase {

	// MARK: - Initializers

	fileprivate override init() {
		super.init()
	}

	public override init(storageDateFormatter: DateFormatter) {
		super.init(storageDateFormatter: storageDateFormatter)
	}
	
	
	// MARK: - Public Methods

	// PlaySubset
	
	fileprivate var _playSubsetModelAdministrator: PlaySubsetModelAdministrator?
	
	public func setupPlaySubsetModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlaySubsets")) { self.modelAdministrators.removeValue(forKey: "PlaySubsets") }
		
		self._playSubsetModelAdministrator 			= PlaySubsetModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlaySubsets"] 	= self._playSubsetModelAdministrator
	}
	
	public var getPlaySubsetModelAdministrator: PlaySubsetModelAdministrator? {
		get {
			return self._playSubsetModelAdministrator
		}
	}
	
	// PlayResult
	
	fileprivate var _playResultModelAdministrator: PlayResultModelAdministrator?
	
	public func setupPlayResultModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayResults")) { self.modelAdministrators.removeValue(forKey: "PlayResults") }
		
		self._playResultModelAdministrator = PlayResultModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayResults"] = self._playResultModelAdministrator
	}
	
	public var getPlayResultModelAdministrator: PlayResultModelAdministrator? {
		get {
			return self._playResultModelAdministrator
		}
	}
	
	// PlayGame
	
	fileprivate var _playGameModelAdministrator: PlayGameModelAdministrator?
	
	public func setupPlayGameModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayGames")) { self.modelAdministrators.removeValue(forKey: "PlayGames") }
		
		self._playGameModelAdministrator = PlayGameModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayGames"] = self._playGameModelAdministrator
	}
	
	public var getPlayGameModelAdministrator: PlayGameModelAdministrator? {
		get {
			return self._playGameModelAdministrator
		}
	}
	
	// PlayGameData
	
	fileprivate var _playGameDataModelAdministrator: PlayGameDataModelAdministrator?
	
	public func setupPlayGameDataModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayGameData")) { self.modelAdministrators.removeValue(forKey: "PlayGameData") }
		
		self._playGameDataModelAdministrator = PlayGameDataModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayGameData"] = self._playGameDataModelAdministrator
	}
	
	public var getPlayGameDataModelAdministrator: PlayGameDataModelAdministrator? {
		get {
			return self._playGameDataModelAdministrator
		}
	}
	
	// PlayAreaToken
	
	fileprivate var _playAreaTokenModelAdministrator: PlayAreaTokenModelAdministrator?
	
	public func setupPlayAreaTokenModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaTokens")) { self.modelAdministrators.removeValue(forKey: "PlayAreaTokens") }
		
		self._playAreaTokenModelAdministrator = PlayAreaTokenModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaTokens"] = self._playAreaTokenModelAdministrator
	}
	
	public var getPlayAreaTokenModelAdministrator: PlayAreaTokenModelAdministrator? {
		get {
			return self._playAreaTokenModelAdministrator
		}
	}
	
	// PlayAreaTile
	
	fileprivate var _playAreaTileModelAdministrator: PlayAreaTileModelAdministrator?
	
	public func setupPlayAreaTileModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaTiles")) { self.modelAdministrators.removeValue(forKey: "PlayAreaTiles") }
		
		self._playAreaTileModelAdministrator = PlayAreaTileModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaTiles"] = self._playAreaTileModelAdministrator
	}
	
	public var getPlayAreaTileModelAdministrator: PlayAreaTileModelAdministrator? {
		get {
			return self._playAreaTileModelAdministrator
		}
	}
	
	// PlayAreaTileType
	
	fileprivate var _playAreaTileTypeModelAdministrator: PlayAreaTileTypeModelAdministrator?
	
	public func setupPlayAreaTileTypeModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaTileTypes")) { self.modelAdministrators.removeValue(forKey: "PlayAreaTileTypes") }
		
		self._playAreaTileTypeModelAdministrator = PlayAreaTileTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaTileTypes"] = self._playAreaTileTypeModelAdministrator
	}
	
	public var getPlayAreaTileTypeModelAdministrator: PlayAreaTileTypeModelAdministrator? {
		get {
			return self._playAreaTileTypeModelAdministrator
		}
	}
	
	// PlayAreaTileData
	
	fileprivate var _playAreaTileDataModelAdministrator: PlayAreaTileDataModelAdministrator?
	
	public func setupPlayAreaTileDataModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaTileData")) { self.modelAdministrators.removeValue(forKey: "PlayAreaTileData") }
		
		self._playAreaTileDataModelAdministrator = PlayAreaTileDataModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaTileData"] = self._playAreaTileDataModelAdministrator
	}
	
	public var getPlayAreaTileDataModelAdministrator: PlayAreaTileDataModelAdministrator? {
		get {
			return self._playAreaTileDataModelAdministrator
		}
	}
	
	// PlayMove
	
	fileprivate var _playMoveModelAdministrator: PlayMoveModelAdministrator?
	
	public func setupPlayMoveModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayMoves")) { self.modelAdministrators.removeValue(forKey: "PlayMoves") }
		
		self._playMoveModelAdministrator = PlayMoveModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayMoves"] = self._playMoveModelAdministrator
	}
	
	public var getPlayMoveModelAdministrator: PlayMoveModelAdministrator? {
		get {
			return self._playMoveModelAdministrator
		}
	}

	// PlayAreaCell
	
	fileprivate var _playAreaCellModelAdministrator: PlayAreaCellModelAdministrator?
	
	public func setupPlayAreaCellModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaCells")) { self.modelAdministrators.removeValue(forKey: "PlayAreaCells") }
		
		self._playAreaCellModelAdministrator = PlayAreaCellModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaCells"] = self._playAreaCellModelAdministrator
	}
	
	public var getPlayAreaCellModelAdministrator: PlayAreaCellModelAdministrator? {
		get {
			return self._playAreaCellModelAdministrator
		}
	}
	
	// PlayAreaCellType
	
	fileprivate var _playAreaCellTypeModelAdministrator: PlayAreaCellTypeModelAdministrator?
	
	public func setupPlayAreaCellTypeModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaCellTypes")) { self.modelAdministrators.removeValue(forKey: "PlayAreaCellTypes") }
		
		self._playAreaCellTypeModelAdministrator = PlayAreaCellTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaCellTypes"] = self._playAreaCellTypeModelAdministrator
	}
	
	public var getPlayAreaCellTypeModelAdministrator: PlayAreaCellTypeModelAdministrator? {
		get {
			return self._playAreaCellTypeModelAdministrator
		}
	}

	// PlayAreaPath
	
	fileprivate var _playAreaPathModelAdministrator: PlayAreaPathModelAdministrator?
	
	public func setupPlayAreaPathModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaPaths")) { self.modelAdministrators.removeValue(forKey: "PlayAreaPaths") }
		
		self._playAreaPathModelAdministrator = PlayAreaPathModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaPaths"] = self._playAreaPathModelAdministrator
	}
	
	public var getPlayAreaPathModelAdministrator: PlayAreaPathModelAdministrator? {
		get {
			return self._playAreaPathModelAdministrator
		}
	}
	
	// PlayAreaPathPoint
	
	fileprivate var _playAreaPathPointModelAdministrator: PlayAreaPathPointModelAdministrator?
	
	public func setupPlayAreaPathPointModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayAreaPathPoints")) { self.modelAdministrators.removeValue(forKey: "PlayAreaPathPoints") }
		
		self._playAreaPathPointModelAdministrator = PlayAreaPathPointModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayAreaPathPoints"] = self._playAreaPathPointModelAdministrator
	}
	
	public var getPlayAreaPathPointModelAdministrator: PlayAreaPathPointModelAdministrator? {
		get {
			return self._playAreaPathPointModelAdministrator
		}
	}
	
	// PlayExperience
	
	fileprivate var _playExperienceModelAdministrator: PlayExperienceModelAdministrator?
	
	public func setupPlayExperienceModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayExperiences")) { self.modelAdministrators.removeValue(forKey: "PlayExperiences") }
		
		self._playExperienceModelAdministrator = PlayExperienceModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayExperiences"] = self._playExperienceModelAdministrator
	}
	
	public var getPlayExperienceModelAdministrator: PlayExperienceModelAdministrator? {
		get {
			return self._playExperienceModelAdministrator
		}
	}

	// PlayExperienceStep
	
	fileprivate var _playExperienceStepModelAdministrator: PlayExperienceStepModelAdministrator?
	
	public func setupPlayExperienceStepModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayExperienceSteps")) { self.modelAdministrators.removeValue(forKey: "PlayExperienceSteps") }
		
		self._playExperienceStepModelAdministrator = PlayExperienceStepModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayExperienceSteps"] = self._playExperienceStepModelAdministrator
	}
	
	public var getPlayExperienceStepModelAdministrator: PlayExperienceStepModelAdministrator? {
		get {
			return self._playExperienceStepModelAdministrator
		}
	}
	
	// PlayExperiencePlayExperienceStepLink
	
	fileprivate var _playExperiencePlayExperienceStepLinkModelAdministrator: PlayExperiencePlayExperienceStepLinkModelAdministrator?
	
	public func setupPlayExperiencePlayExperienceStepLinkModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayExperiencePlayExperienceStepLinks")) { self.modelAdministrators.removeValue(forKey: "PlayExperiencePlayExperienceStepLinks") }
		
		self._playExperiencePlayExperienceStepLinkModelAdministrator = PlayExperiencePlayExperienceStepLinkModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayExperiencePlayExperienceStepLinks"] = self._playExperiencePlayExperienceStepLinkModelAdministrator
	}
	
	public var getPlayExperiencePlayExperienceStepLinkModelAdministrator: PlayExperiencePlayExperienceStepLinkModelAdministrator? {
		get {
			return self._playExperiencePlayExperienceStepLinkModelAdministrator
		}
	}
	
	// PlayExperienceStepExercise
	
	fileprivate var _playExperienceStepExerciseModelAdministrator: PlayExperienceStepExerciseModelAdministrator?
	
	public func setupPlayExperienceStepExerciseModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayExperienceStepExercises")) { self.modelAdministrators.removeValue(forKey: "PlayExperienceStepExercises") }
		
		self._playExperienceStepExerciseModelAdministrator = PlayExperienceStepExerciseModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayExperienceStepExercises"] = self._playExperienceStepExerciseModelAdministrator
	}
	
	public var getPlayExperienceStepExerciseModelAdministrator: PlayExperienceStepExerciseModelAdministrator? {
		get {
			return self._playExperienceStepExerciseModelAdministrator
		}
	}
	
	// PlayExperienceStepPlayExperienceStepExerciseLink
	
	fileprivate var _playExperienceStepPlayExperienceStepExerciseLinkModelAdministrator: PlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator?
	
	public func setupPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayExperienceStepPlayExperienceStepExerciseLinks")) { self.modelAdministrators.removeValue(forKey: "PlayExperienceStepPlayExperienceStepExerciseLinks") }
		
		self._playExperienceStepPlayExperienceStepExerciseLinkModelAdministrator = PlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayExperienceStepPlayExperienceStepExerciseLinks"] = self._playExperienceStepPlayExperienceStepExerciseLinkModelAdministrator
	}
	
	public var getPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator: PlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator? {
		get {
			return self._playExperienceStepPlayExperienceStepExerciseLinkModelAdministrator
		}
	}
	
	// PlayChallenge
	
	fileprivate var _playChallengeModelAdministrator: PlayChallengeModelAdministrator?
	
	public func setupPlayChallengeModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayChallenges")) { self.modelAdministrators.removeValue(forKey: "PlayChallenges") }
		
		self._playChallengeModelAdministrator = PlayChallengeModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayChallenges"] = self._playChallengeModelAdministrator
	}
	
	public var getPlayChallengeModelAdministrator: PlayChallengeModelAdministrator? {
		get {
			return self._playChallengeModelAdministrator
		}
	}
	
	// PlayChallengeType
	
	fileprivate var _playChallengeTypeModelAdministrator: PlayChallengeTypeModelAdministrator?
	
	public func setupPlayChallengeTypeModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayChallengeTypes")) { self.modelAdministrators.removeValue(forKey: "PlayChallengeTypes") }
		
		self._playChallengeTypeModelAdministrator 		= PlayChallengeTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayChallengeTypes"] 	= self._playChallengeTypeModelAdministrator
	}
	
	public var getPlayChallengeTypeModelAdministrator: PlayChallengeTypeModelAdministrator? {
		get {
			return self._playChallengeTypeModelAdministrator
		}
	}
	
	// PlayChallengeObjective
	
	fileprivate var _playChallengeObjectiveModelAdministrator: PlayChallengeObjectiveModelAdministrator?
	
	public func setupPlayChallengeObjectiveModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayChallengeObjectives")) { self.modelAdministrators.removeValue(forKey: "PlayChallengeObjectives") }
		
		self._playChallengeObjectiveModelAdministrator = PlayChallengeObjectiveModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayChallengeObjectives"] = self._playChallengeObjectiveModelAdministrator
	}
	
	public var getPlayChallengeObjectiveModelAdministrator: PlayChallengeObjectiveModelAdministrator? {
		get {
			return self._playChallengeObjectiveModelAdministrator
		}
	}
	
	// PlayChallengeObjectiveType
	
	fileprivate var _playChallengeObjectiveTypeModelAdministrator: PlayChallengeObjectiveTypeModelAdministrator?
	
	public func setupPlayChallengeObjectiveTypeModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {
		
		if (self.modelAdministrators.keys.contains("PlayChallengeObjectiveTypes")) { self.modelAdministrators.removeValue(forKey: "PlayChallengeObjectiveTypes") }
		
		self._playChallengeObjectiveTypeModelAdministrator 			= PlayChallengeObjectiveTypeModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)
		
		self.modelAdministrators["PlayChallengeObjectiveTypes"] 	= self._playChallengeObjectiveTypeModelAdministrator
	}
	
	public var getPlayChallengeObjectiveTypeModelAdministrator: PlayChallengeObjectiveTypeModelAdministrator? {
		get {
			return self._playChallengeObjectiveTypeModelAdministrator
		}
	}
	
	// UserProfile

	fileprivate var _userProfileModelAdministrator: UserProfileModelAdministrator?

	public func setupUserProfileModelAdministrator(modelAccessStrategy: ProtocolModelAccessStrategy) {

		if (self.modelAdministrators.keys.contains("userProfiles")) { self.modelAdministrators.removeValue(forKey: "userProfiles") }

		self._userProfileModelAdministrator = UserProfileModelAdministrator(modelAccessStrategy: modelAccessStrategy, modelAdministratorProvider: self, storageDateFormatter: self.storageDateFormatter!)

		self.modelAdministrators["userProfiles"] = self._userProfileModelAdministrator
	}

	public var getUserProfileModelAdministrator: UserProfileModelAdministrator? {
		get {
			return self._userProfileModelAdministrator
		}
	}
	
}

