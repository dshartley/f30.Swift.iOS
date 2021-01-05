//
//  PlayGame.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFCore
import SFSerialization
import f30Core

public enum PlayGameDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlaySubsetID
	case DateCreated
	case Name
	case LoadLatestOnlyYN
	case LoadRelationalTablesYN
}

/// Encapsulates a PlayGame model item
public class PlayGame: ModelItemBase {
	
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
	
	let playsubsetidKey: String = "PlaySubsetID"
	
	/// Gets or sets the playSubsetID
	public var playSubsetID: String {
		get {
			
			return self.getProperty(key: playsubsetidKey)!
		}
		set(value) {
			
			self.setProperty(key: playsubsetidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let datecreatedKey: String = "DateCreated"
	
	/// Gets or sets the dateCreated
	public var dateCreated: Date {
		get {
			
			let dateString = self.getProperty(key: datecreatedKey)!
			
			return DateHelper.getDate(fromString: dateString, fromDateFormatter: self.storageDateFormatter!)
		}
		set(value) {
			
			self.setProperty(key: datecreatedKey, value: self.getStorageDateString(fromDate: value), setWhenInvalidYN: false)
		}
	}
	
	let nameKey: String = "Name"
	
	/// Gets or sets the name
	public var name: String {
		get {
			
			return self.getProperty(key: nameKey)!
		}
		set(value) {
			
			self.setProperty(key: nameKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayGameWrapper {
		
		let wrapper = PlayGameWrapper()
		
		wrapper.id						= self.id
		wrapper.relativeMemberID		= self.relativeMemberID
		wrapper.playSubsetID			= self.playSubsetID
		wrapper.dateCreated				= self.dateCreated
		wrapper.name					= self.name
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayGameWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN		= false
		
		// Copy all properties from the wrapper
		self.id						= wrapper.id
		self.relativeMemberID		= wrapper.relativeMemberID
		self.playSubsetID			= wrapper.playSubsetID
		self.dateCreated			= wrapper.dateCreated
		self.name					= wrapper.name
		
		self.doValidationsYN 		= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: relativememberidKey, value: "")
		self.doSetProperty(key: playsubsetidKey, value: "")
		self.doSetProperty(key: datecreatedKey, value: "1/1/1900")
		self.doSetProperty(key: nameKey, value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playGame_id.rawValue
		endEnumIndex	= ModelProperties.playGame_name.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.playGame_id.rawValue
		keys[relativememberidKey]		= ModelProperties.playGame_relativeMemberID.rawValue
		keys[playsubsetidKey]			= ModelProperties.playGame_playSubsetID.rawValue
		keys[datecreatedKey]			= ModelProperties.playGame_dateCreated.rawValue
		keys[nameKey]					= ModelProperties.playGame_name.rawValue

	}
	
	public override var dataType: String {
		get {
			return "PlayGame"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayGame {
			
			self.id						= item.id
			self.relativeMemberID		= item.relativeMemberID
			self.playSubsetID			= item.playSubsetID
			self.dateCreated			= item.dateCreated
			self.name					= item.name

		}
		
		self.doValidationsYN 			= doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayGameDataParameterKeys.RelativeMemberID)", value: self.relativeMemberID)
		result.setParameterValue(key: "\(PlayGameDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayGameDataParameterKeys.DateCreated)", value: self.getStorageDateString(fromDate: self.dateCreated))
		result.setParameterValue(key: "\(PlayGameDataParameterKeys.Name)", value: self.name)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties
		self.id 					= dataWrapper.ID
		self.relativeMemberID 		= dataWrapper.getParameterValue(key: "\(PlayGameDataParameterKeys.RelativeMemberID)")!
		self.playSubsetID 			= dataWrapper.getParameterValue(key: "\(PlayGameDataParameterKeys.PlaySubsetID)")!
		self.dateCreated 			= DateHelper.getDate(fromString: dataWrapper.getParameterValue(key: "\(PlayGameDataParameterKeys.DateCreated)")!, fromDateFormatter: self.storageDateFormatter!)
		self.name 					= dataWrapper.getParameterValue(key: "\(PlayGameDataParameterKeys.Name)")!
		
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
