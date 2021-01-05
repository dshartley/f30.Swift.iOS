//
//  PlayAreaTileData.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSerialization

public enum PlayAreaTileDataDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayAreaTileID
	case OnCompleteData
	case AttributeData
	case LoadRelationalTablesYN
}

/// Encapsulates a PlayAreaTileData model item
public class PlayAreaTileData: ModelItemBase {
	
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
	
	let playareatileidKey: String = "PlayAreaTileID"
	
	/// Gets or sets the playAreaTileID
	public var playAreaTileID: String {
		get {
			
			return self.getProperty(key: playareatileidKey)!
		}
		set(value) {
			
			self.setProperty(key: playareatileidKey, value: value, setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayAreaTileDataWrapper {
		
		let wrapper = PlayAreaTileDataWrapper()
		
		wrapper.id						= self.id
		wrapper.relativeMemberID		= self.relativeMemberID
		wrapper.playAreaTileID			= self.playAreaTileID

		// Nb: This sets up the PlayAreaTileDataOnCompleteData wrapper
		wrapper.set(onCompleteData: self.onCompleteData)
		
		// Nb: This sets up the PlayAreaTileDataAttributeData wrapper
		wrapper.set(attributeData: self.attributeData)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayAreaTileDataWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN		= false
		
		// Copy all properties from the wrapper
		self.id						= wrapper.id
		self.relativeMemberID		= wrapper.relativeMemberID
		self.playAreaTileID			= wrapper.playAreaTileID
		self.onCompleteData			= wrapper.onCompleteData
		self.attributeData			= wrapper.attributeData
		
		self.doValidationsYN 		= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: relativememberidKey,	value: "")
		self.doSetProperty(key: playareatileidKey,		value: "")
		self.doSetProperty(key: oncompletedataKey,		value: "")
		self.doSetProperty(key: attributedataKey,	   	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playAreaTileData_id.rawValue
		endEnumIndex	= ModelProperties.playAreaTileData_attributeData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.playAreaTileData_id.rawValue
		keys[relativememberidKey]		= ModelProperties.playAreaTileData_relativeMemberID.rawValue
		keys[playareatileidKey]			= ModelProperties.playAreaTileData_playAreaTileID.rawValue
		keys[oncompletedataKey]			= ModelProperties.playAreaTileData_onCompleteData.rawValue
		keys[attributedataKey]			= ModelProperties.playAreaTileData_attributeData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaTileData"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaTileData {
			
			self.id						= item.id
			self.relativeMemberID		= item.relativeMemberID
			self.playAreaTileID			= item.playAreaTileID
			self.onCompleteData			= item.onCompleteData
			self.attributeData			= item.attributeData
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.RelativeMemberID)", value: self.relativeMemberID)
		result.setParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.PlayAreaTileID)", value: self.playAreaTileID)
		result.setParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.OnCompleteData)", value: "\(self.onCompleteData)")
		result.setParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.AttributeData)", value: self.attributeData)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties
		self.id 					= dataWrapper.ID
		self.relativeMemberID 		= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.RelativeMemberID)")!
		self.playAreaTileID 		= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.PlayAreaTileID)")!
		self.onCompleteData 		= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.OnCompleteData)")!
		self.attributeData 			= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataDataParameterKeys.AttributeData)")!
		
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
