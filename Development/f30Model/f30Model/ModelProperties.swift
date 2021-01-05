//
//  ModelProperties.swift
//  f30Model
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Specifies model properties
public enum ModelProperties: Int {
	
	// General
	case id
	
	// userProfile
	case userProfile_id
	case userProfile_applicationID
	case userProfile_userPropertiesID
	case userProfile_email
	case userProfile_fullName
	case userProfile_dateofBirth
	case userProfile_avatarFileName

	// playSubset
	case playSubset_id
	case playSubset_name
	case playSubset_contentData
	
	// playGame
	case playGame_id
	case playGame_relativeMemberID
	case playGame_playSubsetID
	case playGame_dateCreated
	case playGame_name
	
	// playGameData
	case playGameData_id
	case playGameData_relativeMemberID
	case playGameData_playGameID
	case playGameData_dateLastPlayed
	case playGameData_onCompleteData
	case playGameData_attributeData
	
	// playAreaToken
	case playAreaToken_id
	case playAreaToken_relativeMemberID
	case playAreaToken_playGameID
	case playAreaToken_column
	case playAreaToken_row
	case playAreaToken_imageName
	case playAreaToken_tokenAttributesString
	
	// playResult
	case playResult_id
	case playResult_relativeMemberID
	case playResult_playGamesJSON
	case playResult_playGameDataJSON
	case playResult_playAreaTilesJSON
	case playResult_playAreaTileDataJSON
	case playResult_playExperienceStepResultsJSON
	
	// playMove
	case playMove_id
	case playMove_playSubsetID
	case playMove_playReferenceData
	case playMove_playReferenceActionType
	case playMove_name
	case playMove_contentData
	case playMove_onCompleteData
	
	// playAreaCell
	case playAreaCell_id
	case playAreaCell_relativeMemberID
	case playAreaCell_playGameID
	case playAreaCell_cellTypeID
	case playAreaCell_column
	case playAreaCell_row
	case playAreaCell_rotationDegrees
	case playAreaCell_imageName
	case playAreaCell_cellAttributesString
	case playAreaCell_cellSideAttributesString

	// playAreaCellTypes
	case playAreaCellType_id
	case playAreaCellType_playSubsetID
	case playAreaCellType_name
	case playAreaCellType_isSpecialYN
	case playAreaCellType_deckWeighting
	case playAreaCellType_imageName
	case playAreaCellType_blockedContentPositionsString
	case playAreaCellType_cellAttributesString
	case playAreaCellType_cellSideAttributesString
	
	// playAreaTile
	case playAreaTile_id
	case playAreaTile_relativeMemberID
	case playAreaTile_playGameID
	case playAreaTile_tileTypeID
	case playAreaTile_column
	case playAreaTile_row
	case playAreaTile_rotationDegrees
	case playAreaTile_imageName
	case playAreaTile_widthPixels
	case playAreaTile_heightPixels
	case playAreaTile_position
	case playAreaTile_positionFixToCellRotationYN
	case playAreaTile_tileAttributesString
	case playAreaTile_tileSideAttributesString
	
	// playAreaTileType
	case playAreaTileType_id
	case playAreaTileType_playSubsetID
	case playAreaTileType_name
	case playAreaTileType_isSpecialYN
	case playAreaTileType_deckWeighting
	case playAreaTileType_imageName
	case playAreaTileType_widthPixels
	case playAreaTileType_heightPixels
	case playAreaTileType_position
	case playAreaTileType_positionFixToCellRotationYN
	case playAreaTileType_tileAttributesString
	case playAreaTileType_tileSideAttributesString
	
	// playAreaTileData
	case playAreaTileData_id
	case playAreaTileData_relativeMemberID
	case playAreaTileData_playAreaTileID
	case playAreaTileData_onCompleteData
	case playAreaTileData_attributeData
	
	// playExperience
	case playExperience_id
	case playExperience_playSubsetID
	case playExperience_playExperienceType
	case playExperience_name
	case playExperience_isCompleteYN
	case playExperience_contentData
	case playExperience_onCompleteData
	case playExperience_playChallengeObjectiveDefinitionData
	
	// playExperienceStep
	case playExperienceStep_id
	case playExperienceStep_playSubsetID
	case playExperienceStep_playExperienceStepType
	case playExperienceStep_name
	case playExperienceStep_isCompleteYN
	case playExperienceStep_contentData
	case playExperienceStep_onCompleteData
	case playExperienceStep_playChallengeObjectiveDefinitionData

	// playExperiencePlayExperienceStepLink
	case playExperiencePlayExperienceStepLink_id
	case playExperiencePlayExperienceStepLink_playExperienceID
	case playExperiencePlayExperienceStepLink_playExperienceStepID
	case playExperiencePlayExperienceStepLink_index
	
	// playExperienceStepExercise
	case playExperienceStepExercise_id
	case playExperienceStepExercise_playSubsetID
	case playExperienceStepExercise_name
	case playExperienceStepExercise_playExperienceStepExerciseType
	case playExperienceStepExercise_isCompleteYN
	case playExperienceStepExercise_contentData
	case playExperienceStepExercise_onCompleteData

	// playExperienceStepPlayExperienceStepExerciseLink
	case playExperienceStepPlayExperienceStepExerciseLink_id
	case playExperienceStepPlayExperienceStepExerciseLink_playExperienceStepID
	case playExperienceStepPlayExperienceStepExerciseLink_playExperienceStepExerciseID
	case playExperienceStepPlayExperienceStepExerciseLink_index
	
	// playChallengeType
	case playChallengeType_id
	case playChallengeType_playSubsetID
	case playChallengeType_name
	case playChallengeType_contentData
	case playChallengeType_onCompleteData
	
	// playChallenge
	case playChallenge_id
	case playChallenge_relativeMemberID
	case playChallenge_playGameID
	case playChallenge_playMoveID
	case playChallenge_playChallengeTypeID
	case playChallenge_isActiveYN
	case playChallenge_isCompleteYN
	case playChallenge_dateActive

	// playChallengeObjectiveType
	case playChallengeObjectiveType_id
	case playChallengeObjectiveType_playSubsetID
	case playChallengeObjectiveType_name
	case playChallengeObjectiveType_contentData
	case playChallengeObjectiveType_onCompleteData
	case playChallengeObjectiveType_code
	case playChallengeObjectiveType_definitionData
	
	// playChallengeObjective
	case playChallengeObjective_id
	case playChallengeObjective_relativeMemberID
	case playChallengeObjective_playChallengeID
	case playChallengeObjective_playChallengeObjectiveTypeID
	case playChallengeObjective_isAchievedYN
	case playChallengeObjective_dateActive
	
	// Nb: This will probably only be modelled in the database and never in the app. It will be used to make a relation between playAreaTileTypes and playChallengeObjectives
	// playAreaTileTypeChallengeObjective
	case playAreaTileTypeChallengeObjective_id
	case playAreaTileTypeChallengeObjective_playAreaTileTypeID
	case playAreaTileTypeChallengeObjective_playChallengeObjectiveCode
	case playAreaTileTypeChallengeObjective_playChallengeObjectiveData
	
	// playAreaPath
	case playAreaPath_id
	case playAreaPath_playGameID
	case playAreaPath_pathAttributesString
	case playAreaPath_pathLogString
	
	// playAreaPathPoint
	case playAreaPathPoint_id
	case playAreaPathPoint_playGameID
	case playAreaPathPoint_playAreaPathID
	case playAreaPathPoint_index
	case playAreaPathPoint_column
	case playAreaPathPoint_row
	
}
