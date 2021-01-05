//
//  PlayGameData.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFCore
import SFSerialization

public enum PlayGameDataDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayGameID
	case DateLastPlayed
	case OnCompleteData
	case AttributeData
	case LoadRelationalTablesYN
}

/// Encapsulates a PlayGameData model item
public class PlayGameData: ModelItemBase {
	
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
	
	let datelastplayedKey: String = "DateLastPlayed"
	
	/// Gets or sets the dateLastPlayed
	public var dateLastPlayed: Date {
		get {
			
			let dateString = self.getProperty(key: datelastplayedKey)!
			
			return DateHelper.getDate(fromString: dateString, fromDateFormatter: self.storageDateFormatter!)
		}
		set(value) {
			
			self.setProperty(key: datelastplayedKey, value: self.getStorageDateString(fromDate: value), setWhenInvalidYN: false)
		}
	}
	
	let oncompletedataKey: String = "OnCompleteData"
	
	/// Gets or sets the onCompleteData
	public var onCompleteData: String {
		get {
			
			return self.getProperty(key: oncompletedataKey)!
		}
		set(value) {
			
			self.setProperty(key: oncompletedataKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let attributedataKey: String = "AttributeData"
	
	/// Gets or sets the attributeData
	public var attributeData: String {
		get {
			
			return self.getProperty(key: attributedataKey)!
		}
		set(value) {
			
			self.setProperty(key: attributedataKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayGameDataWrapper {
		
		let wrapper = PlayGameDataWrapper()
		
		wrapper.id							= self.id
		wrapper.relativeMemberID			= self.relativeMemberID
		wrapper.playGameID					= self.playGameID
		wrapper.dateLastPlayed				= self.dateLastPlayed

		// Nb: This sets up the PlayGameDataOnCompleteData wrapper
		wrapper.set(onCompleteData: self.onCompleteData)
		
		// Nb: This sets up the PlayGameDataAttributeData wrapper
		wrapper.set(attributeData: self.attributeData)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayGameDataWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN		= false
		
		// Copy all properties from the wrapper
		self.id						= wrapper.id
		self.relativeMemberID		= wrapper.relativeMemberID
		self.playGameID				= wrapper.playGameID
		self.dateLastPlayed			= wrapper.dateLastPlayed
		self.onCompleteData			= wrapper.onCompleteData
		self.attributeData			= wrapper.attributeData
		
		self.doValidationsYN 		= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: relativememberidKey,	value: "")
		self.doSetProperty(key: playgameidKey,			value: "")
		self.doSetProperty(key: datelastplayedKey,		value: "1/1/1900")
		self.doSetProperty(key: oncompletedataKey,		value: "")
		self.doSetProperty(key: attributedataKey,	   	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playGameData_id.rawValue
		endEnumIndex	= ModelProperties.playGameData_attributeData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.playGameData_id.rawValue
		keys[relativememberidKey]		= ModelProperties.playGameData_relativeMemberID.rawValue
		keys[playgameidKey]				= ModelProperties.playGameData_playGameID.rawValue
		keys[datelastplayedKey]			= ModelProperties.playGameData_dateLastPlayed.rawValue
		keys[oncompletedataKey]			= ModelProperties.playGameData_onCompleteData.rawValue
		keys[attributedataKey]			= ModelProperties.playGameData_attributeData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayGameData"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayGameData {
			
			self.id						= item.id
			self.relativeMemberID		= item.relativeMemberID
			self.playGameID				= item.playGameID
			self.dateLastPlayed			= item.dateLastPlayed
			self.onCompleteData			= item.onCompleteData
			self.attributeData			= item.attributeData
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayGameDataDataParameterKeys.RelativeMemberID)", value: self.relativeMemberID)
		result.setParameterValue(key: "\(PlayGameDataDataParameterKeys.PlayGameID)", value: self.playGameID)
		result.setParameterValue(key: "\(PlayGameDataDataParameterKeys.DateLastPlayed)", value: self.getStorageDateString(fromDate: self.dateLastPlayed))
		result.setParameterValue(key: "\(PlayGameDataDataParameterKeys.OnCompleteData)", value: "\(self.onCompleteData)")
		result.setParameterValue(key: "\(PlayGameDataDataParameterKeys.AttributeData)", value: self.attributeData)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties
		self.id 					= dataWrapper.ID
		self.relativeMemberID 		= dataWrapper.getParameterValue(key: "\(PlayGameDataDataParameterKeys.RelativeMemberID)")!
		self.playGameID 			= dataWrapper.getParameterValue(key: "\(PlayGameDataDataParameterKeys.PlayGameID)")!
		self.dateLastPlayed 		= DateHelper.getDate(fromString: dataWrapper.getParameterValue(key: "\(PlayGameDataDataParameterKeys.DateLastPlayed)")!, fromDateFormatter: self.storageDateFormatter!)
		self.onCompleteData 		= dataWrapper.getParameterValue(key: "\(PlayGameDataDataParameterKeys.OnCompleteData)")!
		self.attributeData 			= dataWrapper.getParameterValue(key: "\(PlayGameDataDataParameterKeys.AttributeData)")!
		
		self.doValidationsYN 		= doValidationsYN
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
