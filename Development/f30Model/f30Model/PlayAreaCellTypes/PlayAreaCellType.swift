//
//  PlayAreaCellType.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlayAreaCellTypeDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlaySubsetID
	case PlayGameID
	case Name
	case IsSpecialYN
	case DeckWeighting
	case ImageName
	case BlockedContentPositionsString
	case CellAttributesString
	case CellSideAttributesString
	case LoadRelationalTablesYN
}

/// Encapsulates a PlayAreaCellType model item
public class PlayAreaCellType: ModelItemBase {
	
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
	
	let isspecialynKey: String = "IsSpecialYN"
	
	/// Gets or sets the isSpecialYN
	public var isSpecialYN: Bool {
		get {
			
			return BoolHelper.fromString(value: self.getProperty(key: isspecialynKey)!)
		}
		set(value) {
			
			self.setProperty(key: isspecialynKey, value: "\(BoolHelper.toInt(value: value))", setWhenInvalidYN: false)
		}
	}
	
	let deckweightingKey: String = "DeckWeighting"
	
	/// Gets or sets the deckWeighting
	public var deckWeighting: Int {
		get {
			
			return Int(self.getProperty(key: deckweightingKey)!)!
		}
		set(value) {
			
			self.setProperty(key: deckweightingKey, value: String(value), setWhenInvalidYN: false)
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

	let cellattributesstringKey: String = "CellAttributesString"
	
	/// Gets or sets the cellAttributesString
	public var cellAttributesString: String {
		get {
			
			return self.getProperty(key: cellattributesstringKey)!
		}
		set(value) {
			
			self.setProperty(key: cellattributesstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let blockedcontentpositionsstringKey: String = "BlockedContentPositionsString"
	
	/// Gets or sets the blockedContentPositionsString
	public var blockedContentPositionsString: String {
		get {
			
			return self.getProperty(key: blockedcontentpositionsstringKey)!
		}
		set(value) {
			
			self.setProperty(key: blockedcontentpositionsstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let cellsideattributesstringKey: String = "CellSideAttributesString"
	
	/// Gets or sets the cellSideAttributesString
	public var cellSideAttributesString: String {
		get {
			
			return self.getProperty(key: cellsideattributesstringKey)!
		}
		set(value) {
			
			self.setProperty(key: cellsideattributesstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayAreaCellTypeWrapper {
		
		let wrapper = PlayAreaCellTypeWrapper()
		
		wrapper.id					= self.id
		wrapper.playSubsetID		= self.playSubsetID
		wrapper.name				= self.name
		wrapper.isSpecialYN			= self.isSpecialYN
		wrapper.deckWeighting		= self.deckWeighting
		wrapper.imageName			= self.imageName

		wrapper.set(blockedContentPositionsString: self.blockedContentPositionsString)
		
		// Nb: This sets up the CellAttributesString wrapper
		wrapper.set(cellAttributesString: self.cellAttributesString)
		
		// Nb: This sets up the CellSideAttributesString wrapper
		wrapper.set(cellSideAttributesString: self.cellSideAttributesString)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayAreaCellTypeWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 					Bool = self.doValidationsYN
		self.doValidationsYN					= false
		
		// Copy all properties from the wrapper
		self.id									= wrapper.id
		self.playSubsetID						= wrapper.playSubsetID
		self.name								= wrapper.name
		self.isSpecialYN						= wrapper.isSpecialYN
		self.deckWeighting						= wrapper.deckWeighting
		self.imageName							= wrapper.imageName
		self.blockedContentPositionsString		= wrapper.blockedContentPositionsString
		self.cellAttributesString				= wrapper.cellAttributesString
		self.cellSideAttributesString			= wrapper.cellSideAttributesString
		
		self.doValidationsYN 					= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: playsubsetidKey, value: "")
		self.doSetProperty(key: nameKey, value: "")
		self.doSetProperty(key: isspecialynKey, value: "0")
		self.doSetProperty(key: deckweightingKey, value: "1")
		self.doSetProperty(key: imagenameKey, value: "")
		self.doSetProperty(key: blockedcontentpositionsstringKey, value: "")
		self.doSetProperty(key: cellattributesstringKey, value: "")
		self.doSetProperty(key: cellsideattributesstringKey, value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playAreaCellType_id.rawValue
		endEnumIndex	= ModelProperties.playAreaCellType_cellSideAttributesString.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]							= ModelProperties.playAreaCellType_id.rawValue
		keys[playsubsetidKey]				= ModelProperties.playAreaCellType_playSubsetID.rawValue
		keys[nameKey]						= ModelProperties.playAreaCellType_name.rawValue
		keys[isspecialynKey]				= ModelProperties.playAreaCellType_isSpecialYN.rawValue
		keys[deckweightingKey]				= ModelProperties.playAreaCellType_deckWeighting.rawValue
		keys[imagenameKey]					= ModelProperties.playAreaCellType_imageName.rawValue
		keys[blockedcontentpositionsstringKey]	= ModelProperties.playAreaCellType_blockedContentPositionsString.rawValue
		keys[cellattributesstringKey]		= ModelProperties.playAreaCellType_cellAttributesString.rawValue
		keys[cellsideattributesstringKey]	= ModelProperties.playAreaCellType_cellSideAttributesString.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaCellType"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 						Bool = self.doValidationsYN
		self.doValidationsYN 						= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaCellType {
			
			self.id									= item.id
			self.playSubsetID						= item.playSubsetID
			self.name								= item.name
			self.isSpecialYN						= item.isSpecialYN
			self.deckWeighting						= item.deckWeighting
			self.imageName							= item.imageName
			self.blockedContentPositionsString		= item.blockedContentPositionsString
			self.cellAttributesString				= item.cellAttributesString
			self.cellSideAttributesString			= item.cellSideAttributesString
			
		}
		
		self.doValidationsYN 						= doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id
		
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.Name)", value: "\(self.name)")
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.IsSpecialYN)", value: "\(self.isSpecialYN)")
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.DeckWeighting)", value: "\(self.deckWeighting)")
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.ImageName)", value: "\(self.imageName)")
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.BlockedContentPositionsString)", value: "\(self.blockedContentPositionsString)")
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.CellAttributesString)", value: "\(self.cellAttributesString)")
		result.setParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.CellSideAttributesString)", value: "\(self.cellSideAttributesString)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties
		self.id 						= dataWrapper.ID
		self.playSubsetID 				= dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.PlaySubsetID)")!
		self.name 						= dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.Name)")!
		self.isSpecialYN 				= Bool(dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.IsSpecialYN)")!)!
		self.deckWeighting 				= Int(dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.DeckWeighting)")!) ?? 0
		self.imageName 					= dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.ImageName)")!
		self.blockedContentPositionsString 	= dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.BlockedContentPositionsString)")!
		self.cellAttributesString 		= dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.CellAttributesString)")!
		self.cellSideAttributesString 	= dataWrapper.getParameterValue(key: "\(PlayAreaCellTypeDataParameterKeys.CellSideAttributesString)")!
		
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
