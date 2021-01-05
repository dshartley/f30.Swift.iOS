//
//  PlayChallenge.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import f30Core

public enum PlayChallengeDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayGameID
	case PlayMoveID
	case PlayChallengeTypeID
	case IsActiveYN
	case IsCompleteYN
	case DateActive
}

public enum PlayChallengeContentDataKeys {
	case Title
}

/// Encapsulates a PlayChallenge model item
public class PlayChallenge: ModelItemBase {
	
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
	
	let playgameidKey: String = "PlayGameID"
	
	/// Gets or sets the playGameID
	public var playGameID: String {
		get {
			
			return self.getProperty(key: playgameidKey)!
		}
		set(value) {
			
			self.setProperty(key: playgameidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playmoveidKey: String = "PlayMoveID"
	
	/// Gets or sets the playMoveID
	public var playMoveID: String {
		get {
			
			return self.getProperty(key: playmoveidKey)!
		}
		set(value) {
			
			self.setProperty(key: playmoveidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playchallengetypeidKey: String = "PlayChallengeTypeID"
	
	/// Gets or sets the playChallengeTypeID
	public var playChallengeTypeID: String {
		get {
			
			return self.getProperty(key: playchallengetypeidKey)!
		}
		set(value) {
			
			self.setProperty(key: playchallengetypeidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let isactiveynKey: String = "IsActiveYN"
	
	/// Gets or sets the isActiveYN
	public var isActiveYN: Bool {
		get {
			
			return BoolHelper.fromString(value: self.getProperty(key: isactiveynKey)!)
		}
		set(value) {
			
			self.setProperty(key: isactiveynKey, value: "\(BoolHelper.toInt(value: value))", setWhenInvalidYN: false)
		}
	}

	let iscompleteynKey: String = "IsCompleteYN"
	
	/// Gets or sets the isCompleteYN
	public var isCompleteYN: Bool {
		get {
			
			return BoolHelper.fromString(value: self.getProperty(key: iscompleteynKey)!)
		}
		set(value) {
			
			self.setProperty(key: iscompleteynKey, value: "\(BoolHelper.toInt(value: value))", setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayChallengeWrapper {
		
		let wrapper = PlayChallengeWrapper()
		
		wrapper.id						= self.id
		wrapper.relativeMemberID		= self.relativeMemberID
		wrapper.playGameID				= self.playGameID
		wrapper.playMoveID				= self.playMoveID
		wrapper.playChallengeTypeID		= self.playChallengeTypeID
		wrapper.isActiveYN				= self.isActiveYN
		wrapper.isCompleteYN			= self.isCompleteYN
		wrapper.dateActive				= self.dateActive
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayChallengeWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id							= wrapper.id
		self.relativeMemberID			= wrapper.relativeMemberID
		self.playGameID					= wrapper.playGameID
		self.playMoveID					= wrapper.playMoveID
		self.playChallengeTypeID		= wrapper.playChallengeTypeID
		self.isActiveYN					= wrapper.isActiveYN
		self.isCompleteYN				= wrapper.isCompleteYN
		self.dateActive					= wrapper.dateActive
		
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: relativememberidKey,		value: "0")
		self.doSetProperty(key: playgameidKey,				value: "0")
		self.doSetProperty(key: playmoveidKey,				value: "")
		self.doSetProperty(key: playchallengetypeidKey,		value: "0")
		self.doSetProperty(key: isactiveynKey,				value: "0")
		self.doSetProperty(key: iscompleteynKey,			value: "0")
		self.doSetProperty(key: dateactiveKey, 				value: "1/1/1900")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playChallenge_id.rawValue
		endEnumIndex	= ModelProperties.playChallenge_dateActive.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.playChallenge_id.rawValue
		keys[relativememberidKey]		= ModelProperties.playChallenge_relativeMemberID.rawValue
		keys[playgameidKey]				= ModelProperties.playChallenge_playGameID.rawValue
		keys[playmoveidKey]				= ModelProperties.playChallenge_playMoveID.rawValue
		keys[playchallengetypeidKey]	= ModelProperties.playChallenge_playChallengeTypeID.rawValue
		keys[isactiveynKey]				= ModelProperties.playChallenge_isActiveYN.rawValue
		keys[iscompleteynKey]			= ModelProperties.playChallenge_isCompleteYN.rawValue
		keys[dateactiveKey]				= ModelProperties.playChallenge_dateActive.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayChallenge"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayChallenge {
			
			self.id						= item.id
			self.relativeMemberID		= item.relativeMemberID
			self.playGameID				= item.playGameID
			self.playMoveID				= item.playMoveID
			self.playChallengeTypeID	= item.playChallengeTypeID
			self.isActiveYN				= item.isActiveYN
			self.isCompleteYN			= item.isCompleteYN
			self.dateActive				= item.dateActive
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayChallengeDataParameterKeys.RelativeMemberID)", value: "\(self.relativeMemberID)")
		result.setParameterValue(key: "\(PlayChallengeDataParameterKeys.PlayGameID)", value: "\(self.playGameID)")
		result.setParameterValue(key: "\(PlayChallengeDataParameterKeys.PlayMoveID)", value: self.playMoveID)
		result.setParameterValue(key: "\(PlayChallengeDataParameterKeys.PlayChallengeTypeID)", value: self.playChallengeTypeID)
		result.setParameterValue(key: "\(PlayChallengeDataParameterKeys.IsActiveYN)", value: "\(self.isActiveYN)")
		result.setParameterValue(key: "\(PlayChallengeDataParameterKeys.IsCompleteYN)", value: "\(self.isCompleteYN)")
		result.setParameterValue(key: "\(PlayChallengeDataParameterKeys.DateActive)", value: self.getStorageDateString(fromDate: self.dateActive))
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties
		self.id 						= dataWrapper.ID
		self.relativeMemberID 			= dataWrapper.getParameterValue(key: "\(PlayChallengeDataParameterKeys.RelativeMemberID)")!
		self.playGameID 				= dataWrapper.getParameterValue(key: "\(PlayChallengeDataParameterKeys.PlayGameID)")!
		self.playMoveID 				= dataWrapper.getParameterValue(key: "\(PlayChallengeDataParameterKeys.PlayMoveID)")!
		self.playChallengeTypeID 		= dataWrapper.getParameterValue(key: "\(PlayChallengeDataParameterKeys.PlayChallengeTypeID)")!
		self.isActiveYN 				= Bool(dataWrapper.getParameterValue(key: "\(PlayChallengeDataParameterKeys.IsActiveYN)")!)!
		self.isCompleteYN 				= Bool(dataWrapper.getParameterValue(key: "\(PlayChallengeDataParameterKeys.IsCompleteYN)")!)!
		self.dateActive 				= DateHelper.getDate(fromString: dataWrapper.getParameterValue(key: "\(PlayChallengeDataParameterKeys.DateActive)")!, fromDateFormatter: self.storageDateFormatter!)
		
		self.doValidationsYN 			= doValidationsYN
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
