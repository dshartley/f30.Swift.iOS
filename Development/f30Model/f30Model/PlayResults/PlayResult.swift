//
//  PlayResult.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSerialization
import f30Core

public enum PlayResultDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayGamesJSON
	case PlayGameDataJSON
	case PlayAreaTilesJSON
	case PlayAreaTileDataJSON
	case PlayExperienceStepResultsJSON
}

/// Encapsulates a PlayResult model item
public class PlayResult: ModelItemBase {
	
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
	
	let playgamesjsonKey: String = "PlayGamesJSON"
	
	/// Gets or sets the playGamesJSON
	public var playGamesJSON: String {
		get {
			
			return self.getProperty(key: playgamesjsonKey)!
		}
		set(value) {
			
			self.setProperty(key: playgamesjsonKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playgamedatajsonKey: String = "PlayGameDataJSON"
	
	/// Gets or sets the playGameDataJSON
	public var playGameDataJSON: String {
		get {
			
			return self.getProperty(key: playgamedatajsonKey)!
		}
		set(value) {
			
			self.setProperty(key: playgamedatajsonKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playareatilesjsonKey: String = "PlayAreaTilesJSON"
	
	/// Gets or sets the playAreaTilesJSON
	public var playAreaTilesJSON: String {
		get {
			
			return self.getProperty(key: playareatilesjsonKey)!
		}
		set(value) {
			
			self.setProperty(key: playareatilesjsonKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playareatiledatajsonKey: String = "PlayAreaTileDataJSON"
	
	/// Gets or sets the playAreaTileDataJSON
	public var playAreaTileDataJSON: String {
		get {
			
			return self.getProperty(key: playareatiledatajsonKey)!
		}
		set(value) {
			
			self.setProperty(key: playareatiledatajsonKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playexperiencestepresultsjsonKey: String = "PlayExperienceStepResultsJSON"
	
	/// Gets or sets the playExperienceStepResultsJSON
	public var playExperienceStepResultsJSON: String {
		get {
			
			return self.getProperty(key: playexperiencestepresultsjsonKey)!
		}
		set(value) {
			
			self.setProperty(key: playexperiencestepresultsjsonKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayResultWrapper {
		
		let wrapper = PlayResultWrapper()
		
		wrapper.id								= self.id
		
		wrapper.relativeMemberID				= self.relativeMemberID
		wrapper.playGamesJSON					= self.playGamesJSON
		wrapper.playGameDataJSON				= self.playGameDataJSON
		wrapper.playAreaTilesJSON				= self.playAreaTilesJSON
		wrapper.playAreaTileDataJSON			= self.playAreaTileDataJSON
		wrapper.playExperienceStepResultsJSON	= self.playExperienceStepResultsJSON
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayResultWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN				= false
		
		// Copy all properties from the wrapper
		self.id								= wrapper.id
		self.relativeMemberID				= wrapper.relativeMemberID
		self.playGamesJSON					= wrapper.playGamesJSON
		self.playGameDataJSON				= wrapper.playGameDataJSON
		self.playAreaTilesJSON				= wrapper.playAreaTilesJSON
		self.playAreaTileDataJSON			= wrapper.playAreaTileDataJSON
		self.playExperienceStepResultsJSON	= wrapper.playExperienceStepResultsJSON
		
		self.doValidationsYN 				= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data

		self.doSetProperty(key: relativememberidKey,				value: "0")
		self.doSetProperty(key: playgamesjsonKey,					value: "")
		self.doSetProperty(key: playgamedatajsonKey,				value: "")
		self.doSetProperty(key: playareatilesjsonKey,				value: "")
		self.doSetProperty(key: playareatiledatajsonKey,			value: "")
		self.doSetProperty(key: playexperiencestepresultsjsonKey,	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playResult_id.rawValue
		endEnumIndex	= ModelProperties.playResult_playExperienceStepResultsJSON.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]								= ModelProperties.playResult_id.rawValue
		keys[relativememberidKey]				= ModelProperties.playResult_relativeMemberID.rawValue
		keys[playgamesjsonKey]					= ModelProperties.playResult_playGamesJSON.rawValue
		keys[playgamedatajsonKey]				= ModelProperties.playResult_playGameDataJSON.rawValue
		keys[playareatilesjsonKey]				= ModelProperties.playResult_playAreaTilesJSON.rawValue
		keys[playareatiledatajsonKey]			= ModelProperties.playResult_playAreaTileDataJSON.rawValue
		keys[playexperiencestepresultsjsonKey]	= ModelProperties.playResult_playExperienceStepResultsJSON.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayResult"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN 				= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayResult {
			
			self.id								= item.id
			self.relativeMemberID				= item.relativeMemberID
			self.playGamesJSON					= item.playGamesJSON
			self.playGameDataJSON				= item.playGameDataJSON
			self.playAreaTilesJSON				= item.playAreaTilesJSON
			self.playAreaTileDataJSON			= item.playAreaTileDataJSON
			self.playExperienceStepResultsJSON	= item.playExperienceStepResultsJSON
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayResultDataParameterKeys.RelativeMemberID)", value: "\(self.relativeMemberID)")
		result.setParameterValue(key: "\(PlayResultDataParameterKeys.PlayGamesJSON)", value: self.playGamesJSON)
		result.setParameterValue(key: "\(PlayResultDataParameterKeys.PlayGameDataJSON)", value: self.playGameDataJSON)
		result.setParameterValue(key: "\(PlayResultDataParameterKeys.PlayAreaTilesJSON)", value: self.playAreaTilesJSON)
		result.setParameterValue(key: "\(PlayResultDataParameterKeys.PlayAreaTileDataJSON)", value: self.playAreaTileDataJSON)
		result.setParameterValue(key: "\(PlayResultDataParameterKeys.PlayExperienceStepResultsJSON)", value: self.playExperienceStepResultsJSON)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN 				= false
		
		// Copy all properties
		self.id 							= dataWrapper.ID
		self.relativeMemberID 				= dataWrapper.getParameterValue(key: "\(PlayResultDataParameterKeys.RelativeMemberID)")!
		self.playGamesJSON 					= dataWrapper.getParameterValue(key: "\(PlayResultDataParameterKeys.PlayGamesJSON)")!
		self.playGameDataJSON 				= dataWrapper.getParameterValue(key: "\(PlayResultDataParameterKeys.PlayGameDataJSON)")!
		self.playAreaTilesJSON 				= dataWrapper.getParameterValue(key: "\(PlayResultDataParameterKeys.PlayAreaTilesJSON)")!
		self.playAreaTileDataJSON 			= dataWrapper.getParameterValue(key: "\(PlayResultDataParameterKeys.PlayAreaTileDataJSON)")!
		self.playExperienceStepResultsJSON 	= dataWrapper.getParameterValue(key: "\(PlayResultDataParameterKeys.PlayExperienceStepResultsJSON)")!
		
		self.doValidationsYN 				= doValidationsYN
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
