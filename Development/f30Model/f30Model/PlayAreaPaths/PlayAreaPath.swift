//
//  PlayAreaPath.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlayAreaPathDataParameterKeys {
	case ID
	case PlayGameID
	case PathAttributesString
	case PathLogString
	case FromColumn
	case FromRow
	case ToColumn
	case ToRow
	case PlayAreaPathAbilityType
	case LoadRelationalTablesYN
}

/// Encapsulates a PlayAreaPath model item
public class PlayAreaPath: ModelItemBase, ProtocolGridScapePath {
	
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
	
	let pathattributesstringKey: String = "PathAttributesString"
	
	/// Gets or sets the pathAttributesString
	public var pathAttributesString: String {
		get {
			
			return self.getProperty(key: pathattributesstringKey)!
		}
		set(value) {
			
			self.setProperty(key: pathattributesstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let pathlogstringKey: String = "PathLogString"
	
	/// Gets or sets the pathLogString
	public var pathLogString: String {
		get {
			
			return self.getProperty(key: pathlogstringKey)!
		}
		set(value) {
			
			self.setProperty(key: pathlogstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayAreaPathWrapper {
		
		let wrapper 			= PlayAreaPathWrapper()
		
		wrapper.id				= self.id
		wrapper.playGameID		= self.playGameID

		// Nb: This sets up the PathAttributesString wrapper
		wrapper.set(pathAttributesString: self.pathAttributesString)
		
		// Nb: This sets up the PathLogString wrapper
		wrapper.set(pathLogString: self.pathLogString)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayAreaPathWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id							= wrapper.id
		self.playGameID					= wrapper.playGameID
		self.pathAttributesString		= wrapper.pathAttributesString
		self.pathLogString				= wrapper.pathLogString
		
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: playgameidKey, value: "")
		self.doSetProperty(key: pathattributesstringKey, value: "")
		self.doSetProperty(key: pathlogstringKey, value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playAreaPath_id.rawValue
		endEnumIndex	= ModelProperties.playAreaPath_pathLogString.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.playAreaPath_id.rawValue
		keys[playgameidKey]				= ModelProperties.playAreaPath_playGameID.rawValue
		keys[pathattributesstringKey]	= ModelProperties.playAreaPath_pathAttributesString.rawValue
		keys[pathlogstringKey]			= ModelProperties.playAreaPath_pathLogString.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaPath"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN:			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaPath {
			
			self.id						= item.id
			self.playGameID				= item.playGameID
			self.pathAttributesString	= item.pathAttributesString
			self.pathLogString			= item.pathLogString
		}
		
		self.doValidationsYN = doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id
		
		result.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.PlayGameID)", value: "\(self.playGameID)")
		result.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.PathAttributesString)", value: "\(self.pathAttributesString)")
		result.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.PathLogString)", value: "\(self.pathLogString)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties
		self.id 					= dataWrapper.ID
		self.playGameID 			= dataWrapper.getParameterValue(key: "\(PlayAreaPathDataParameterKeys.PlayGameID)")!
		self.pathAttributesString 	= dataWrapper.getParameterValue(key: "\(PlayAreaPathDataParameterKeys.PathAttributesString)")!
		self.pathLogString 			= dataWrapper.getParameterValue(key: "\(PlayAreaPathDataParameterKeys.PathLogString)")!
		
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

