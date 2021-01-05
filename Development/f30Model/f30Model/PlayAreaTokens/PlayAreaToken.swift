//
//  PlayAreaToken.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlayAreaTokenDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayGameID
	case Column
	case Row
	case ImageName
	case TokenAttributesString
	case LoadRelationalTablesYN
}

/// Encapsulates a PlayAreaToken model item
public class PlayAreaToken: ModelItemBase, ProtocolGridScapeToken {
	
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
	
	let columnKey: String = "Column"
	
	/// Gets or sets the column
	public var column: Int {
		get {
			
			return Int(self.getProperty(key: columnKey)!)!
		}
		set(value) {
			
			self.setProperty(key: columnKey, value: String(value), setWhenInvalidYN: false)
		}
	}
	
	let rowKey: String = "Row"
	
	/// Gets or sets the row
	public var row: Int {
		get {
			
			return Int(self.getProperty(key: rowKey)!)!
		}
		set(value) {
			
			self.setProperty(key: rowKey, value: String(value), setWhenInvalidYN: false)
		}
	}
	
	let imagenameKey: String = "ImageName"
	
	/// Gets or sets the imageName
	public var imageName: String {
		get {
			
			return self.getProperty(key: imagenameKey)!
		}
		set(value) {
			
			self.setProperty(key: imagenameKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let tokenattributesstringKey: String = "TokenAttributesString"
	
	/// Gets or sets the tokenAttributesString
	public var tokenAttributesString: String {
		get {
			
			return self.getProperty(key: tokenattributesstringKey)!
		}
		set(value) {
			
			self.setProperty(key: tokenattributesstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayAreaTokenWrapper {
		
		let wrapper = PlayAreaTokenWrapper()
		
		wrapper.id					= self.id
		wrapper.relativeMemberID	= self.relativeMemberID
		wrapper.playGameID			= self.playGameID
		wrapper.column				= self.column
		wrapper.row					= self.row
		wrapper.imageName			= self.imageName
		
		// Nb: This sets up the TokenAttributesString wrapper
		wrapper.set(tokenAttributesString: self.tokenAttributesString)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayAreaTokenWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id							= wrapper.id
		self.relativeMemberID			= wrapper.relativeMemberID
		self.playGameID					= wrapper.playGameID
		self.column						= wrapper.column
		self.row						= wrapper.row
		self.imageName					= wrapper.imageName
		self.tokenAttributesString		= wrapper.tokenAttributesString
	
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: relativememberidKey,	value: "0")
		self.doSetProperty(key: playgameidKey,	value: "0")
		self.doSetProperty(key: columnKey,	value: "0")
		self.doSetProperty(key: rowKey,	value: "0")
		self.doSetProperty(key: imagenameKey, value: "")
		self.doSetProperty(key: tokenattributesstringKey, value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playAreaToken_id.rawValue
		endEnumIndex	= ModelProperties.playAreaToken_tokenAttributesString.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]							= ModelProperties.playAreaToken_id.rawValue
		keys[relativememberidKey]			= ModelProperties.playAreaToken_relativeMemberID.rawValue
		keys[playgameidKey]					= ModelProperties.playAreaToken_playGameID.rawValue
		keys[columnKey]						= ModelProperties.playAreaToken_column.rawValue
		keys[rowKey]						= ModelProperties.playAreaToken_row.rawValue
		keys[imagenameKey]					= ModelProperties.playAreaToken_imageName.rawValue
		keys[tokenattributesstringKey]		= ModelProperties.playAreaToken_tokenAttributesString.rawValue
	
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaToken"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN 				= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaToken {
			
			self.id							= item.id
			self.relativeMemberID			= item.relativeMemberID
			self.playGameID					= item.playGameID
			self.column						= item.column
			self.row						= item.row
			self.imageName					= item.imageName
			self.tokenAttributesString		= item.tokenAttributesString
	
		}
		
		self.doValidationsYN = doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id
		
		result.setParameterValue(key: "\(PlayAreaTokenDataParameterKeys.RelativeMemberID)", value: "\(self.relativeMemberID)")
		result.setParameterValue(key: "\(PlayAreaTokenDataParameterKeys.PlayGameID)", value: "\(self.playGameID)")
		result.setParameterValue(key: "\(PlayAreaTokenDataParameterKeys.Column)", value: "\(self.column)")
		result.setParameterValue(key: "\(PlayAreaTokenDataParameterKeys.Row)", value: "\(self.row)")
		result.setParameterValue(key: "\(PlayAreaTokenDataParameterKeys.ImageName)", value: "\(self.imageName)")
		result.setParameterValue(key: "\(PlayAreaTokenDataParameterKeys.TokenAttributesString)", value: "\(self.tokenAttributesString)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties
		self.id 						= dataWrapper.ID
		self.relativeMemberID 			= dataWrapper.getParameterValue(key: "\(PlayAreaTokenDataParameterKeys.RelativeMemberID)")!
		self.playGameID 				= dataWrapper.getParameterValue(key: "\(PlayAreaTokenDataParameterKeys.PlayGameID)")!
		self.column 					= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTokenDataParameterKeys.Column)")!) ?? 0
		self.row 						= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTokenDataParameterKeys.Row)")!) ?? 0
		self.imageName 					= dataWrapper.getParameterValue(key: "\(PlayAreaTokenDataParameterKeys.ImageName)")!
		self.tokenAttributesString 		= dataWrapper.getParameterValue(key: "\(PlayAreaTokenDataParameterKeys.TokenAttributesString)")!
		
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

