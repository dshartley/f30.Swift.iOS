//
//  Enums.swift
//  f30Core
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Specifies web socket function names
public enum WebSocketFunctionNames {
	
	case RefreshMemberFeed
	
}

/// Specifies PlayReferenceTypes
public enum PlayReferenceTypes: Int {

	case PlayAreaTile = 1
	case PlayAreaToken = 2
	case PlayAreaPath = 3
	case PlayAreaPathPoint = 4
	
}

/// Specifies PlayReferenceActionTypes
public enum PlayReferenceActionTypes: Int {
	
	case Unspecified = 0
	case BeforeStartMovingAlongPath = 1
	case BeforeMoveToPathPoint = 2
	case AfterMoveToPathPoint = 3
	case AfterFinishedMovingAlongPath = 4
	
}

/// Specifies PlayReferenceDataItemTypes
public enum PlayReferenceDataItemTypes: Int {
	
	case None = 0
	case PlayAreaCellType = 1
	case PlayAreaTileType = 2
	
}

/// Specifies PlayExperienceTypes
public enum PlayExperienceTypes: Int {
	
	case Basic = 1
	
}

/// Specifies PlayExperienceStepTypes
public enum PlayExperienceStepTypes: Int {
	
	case Basic = 1
	
}

/// Specifies PlayExperienceStepExerciseTypes
public enum PlayExperienceStepExerciseTypes: Int {
	
	case Basic = 1
	case Advanced = 2
	case MC1 = 3
	case MP1 = 4
}

/// Specifies AppSettingsKeys
public enum AppSettingsKeys {
	
	case PlayAreaViewGridScapeIndicatedOffsetX
	case PlayAreaViewGridScapeIndicatedOffsetY
	case ActivePlayGameID
	
}

/// Specifies PlayAreaCellTypeNames
public enum PlayAreaCellTypeNames {
	
	case StartCell
	
}

/// Specifies PlayAreaPathAbilityTypes
public enum PlayAreaPathAbilityTypes: Int {
	case ByFoot = 1
	case ByCar = 2
	case ByBike = 3
	case ByTrain = 4
	case ByAeroplane = 5
	case ByBoat = 6
	case ByScooter = 7
	case ByBus = 8
	case ByTram = 9
}

/// Specifies DataItemDataJSONWrapperKeys
public enum DataItemDataJSONWrapperKeys {
	case Points
	case PlayReferenceType
	case PlayReferenceID
	case PlayReferenceDataItemType
	case PlayReferenceDataItemID
	case FileName
	case Key
	case Value
	case Caption
	case ChallengeTextItems
	case Img1Items
	case P1Items
	case Text
}

/// Specifies MatchingPairSubItemTypes
public enum MatchingPairSubItemTypes: Int {
	case ImageAndText = 1
	case Image = 2
	case Text = 3
}
