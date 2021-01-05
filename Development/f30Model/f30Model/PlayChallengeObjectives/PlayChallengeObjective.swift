//
//  PlayChallengeObjective.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import f30Core

public enum PlayChallengeObjectiveDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayChallengeID
	case PlayChallengeObjectiveTypeID
	case IsAchievedYN
	case DateActive
}

public enum PlayChallengeObjectiveContentDataKeys {
	case Title
	case Index
}

public enum PlayChallengeObjectiveDefinitionDataKeys {
	case DefinitionCodes
	case DefinitionParams
}

/// Encapsulates a PlayChallengeObjective model item
public class PlayChallengeObjective: ModelItemBase {
	
	// MARK: - Public Stored Properties
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(collection: ProtocolModelItemCollection,
						 storageDateFormatter: DateFormatter) {
		super.init(collection: collection,
				   storageDateFormatter: storageDateFormatter)
	}
	
	
	// MARK: - Public Methods
	
	let relativememberidKey: String = "RelativeMemberID"
	
	/// Gets or sets the relativeMemberID
	public var relativeMemberID: String {
		get {
			
			return self.getProperty(key: relativememberidKey)!
		}
		set(value) {
			
			self.setProperty(key: relativememberidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playchallengeidKey: String = "PlayChallengeID"
	
	/// Gets or sets the playChallengeID
	public var playChallengeID: String {
		get {
			
			return self.getProperty(key: playchallengeidKey)!
		}
		set(value) {
			
			self.setProperty(key: playchallengeidKey, value: value, setWhenInvalidYN: false)
		}
	}

	let playchallengeobjectivetypeidKey: String = "PlayChallengeObjectiveTypeID"
	
	/// Gets or sets the playChallengeObjectiveTypeID
	public var playChallengeObjectiveTypeID: String {
		get {
			
			return self.getProperty(key: playchallengeobjectivetypeidKey)!
		}
		set(value) {
			
			self.setProperty(key: playchallengeobjectivetypeidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let isachievedynKey: String = "IsAchievedYN"
	
	/// Gets or sets the isAchievedYN
	public var isAchievedYN: Bool {
		get {
			
			return BoolHelper.fromString(value: self.getProperty(key: isachievedynKey)!)
		}
		set(value) {
			
			self.setProperty(key: isachievedynKey, value: "\(BoolHelper.toInt(value: value))", setWhenInvalidYN: false)
		}
	}
	
	let dateactiveKey: String = "DateActive"
	
	/// Gets or sets the dateActive
	public var dateActive: Date {
		get {
			
			let dateString = self.getProperty(key: dateactiveKey)!
			
			return DateHelper.getDate(fromString: dateString, fromDateFormatter: self.storageDateFormatter!)
		}
		set(value) {
			
			self.setProperty(key: dateactiveKey, value: self.getStorageDateString(fromDate: value), setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayChallengeObjectiveWrapper {
		
		let wrapper = PlayChallengeObjectiveWrapper()
		
		wrapper.id								= self.id
		wrapper.relativeMemberID				= self.relativeMemberID
		wrapper.playChallengeID					= self.playChallengeID
		wrapper.playChallengeObjectiveTypeID	= self.playChallengeObjectiveTypeID
		wrapper.isAchievedYN					= self.isAchievedYN
		wrapper.dateActive 						= self.dateActive

		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayChallengeObjectiveWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN		= false
		
		// Copy all properties from the wrapper
		self.id								= wrapper.id
		self.relativeMemberID 				= wrapper.relativeMemberID
		self.playChallengeID				= wrapper.playChallengeID
		self.playChallengeObjectiveTypeID 	= wrapper.playChallengeObjectiveTypeID
		self.isAchievedYN					= wrapper.isAchievedYN
		self.dateActive 					= wrapper.dateActive
		
		self.doValidationsYN 		= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: relativememberidKey,				value: "")
		self.doSetProperty(key: playchallengeidKey,					value: "")
		self.doSetProperty(key: playchallengeobjectivetypeidKey,	value: "0")
		self.doSetProperty(key: isachievedynKey,					value: "0")
		self.doSetProperty(key: dateactiveKey,						value: "1/1/1900")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playChallengeObjective_id.rawValue
		endEnumIndex	= ModelProperties.playChallengeObjective_dateActive.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]								= ModelProperties.playChallengeObjective_id.rawValue
		keys[relativememberidKey]				= ModelProperties.playChallengeObjective_relativeMemberID.rawValue
		keys[playchallengeidKey]				= ModelProperties.playChallengeObjective_playChallengeID.rawValue
		keys[playchallengeobjectivetypeidKey]	= ModelProperties.playChallengeObjective_playChallengeObjectiveTypeID.rawValue
		keys[isachievedynKey]					= ModelProperties.playChallengeObjective_isAchievedYN.rawValue
		keys[dateactiveKey]						= ModelProperties.playChallengeObjective_dateActive.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayChallengeObjective"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayChallengeObjective {
			
			self.id								= item.id
			self.relativeMemberID 				= item.relativeMemberID
			self.playChallengeID				= item.playChallengeID
			self.playChallengeObjectiveTypeID 	= item.playChallengeObjectiveTypeID
			self.isAchievedYN					= item.isAchievedYN
			self.dateActive 					= item.dateActive
		}
		
		self.doValidationsYN = doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.RelativeMemberID)", value: self.relativeMemberID)
		result.setParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.PlayChallengeID)", value: self.playChallengeID)
		result.setParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.PlayChallengeObjectiveTypeID)", value: self.playChallengeObjectiveTypeID)
		result.setParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.IsAchievedYN)", value: "\(self.isAchievedYN)")
		result.setParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.DateActive)", value: self.getStorageDateString(fromDate: self.dateActive))
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN 	= false
		
		// Copy all properties
		self.id 							= dataWrapper.ID
		self.relativeMemberID 				= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.RelativeMemberID)")!
		self.playChallengeID 				= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.PlayChallengeID)")!
		self.playChallengeObjectiveTypeID 	= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.PlayChallengeObjectiveTypeID)")!
		self.isAchievedYN 					= Bool(dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.IsAchievedYN)")!)!
		self.dateActive 					= DateHelper.getDate(fromString: dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveDataParameterKeys.DateActive)")!, fromDateFormatter: self.storageDateFormatter!)
		
		self.doValidationsYN 	= doValidationsYN
	}
	
	public override func isValid(propertyEnum: Int, value: String) -> ValidationResultTypes {
		
		let result: ValidationResultTypes = ValidationResultTypes.passed
		
		// Perform validations for the specified property
		//		switch toProperty(propertyEnum: propertyEnum) {
		//		case .artworkComment_postedByName:
		//			result = self.isValidPostedByName(value: value)
		//			break
		//
		//		default:
		//			break
		//		}
		
		return result
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func toProperty(propertyEnum: Int) -> ModelProperties {
		
		return ModelProperties(rawValue: propertyEnum)!
	}
	
	
	// MARK: - Validations
	
}

