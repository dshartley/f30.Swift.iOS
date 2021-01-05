//
//  PlayAreaTileType.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlayAreaTileTypeDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlaySubsetID
	case PlayGameID
	case Name
	case IsSpecialYN
	case DeckWeighting
	case ImageName
	case WidthPixels
	case HeightPixels
	case Position
	case PositionFixToCellRotationYN
	case TileAttributesString
	case TileSideAttributesString
	case LoadRelationalTablesYN
}

/// Encapsulates a PlayAreaTileType model item
public class PlayAreaTileType: ModelItemBase {
	
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
	
	let widthpixelsKey: String = "WidthPixels"
	
	/// Gets or sets the widthPixels
	public var widthPixels: Int {
		get {
			
			return Int(self.getProperty(key: widthpixelsKey)!)!
		}
		set(value) {
			
			self.setProperty(key: widthpixelsKey, value: String(value), setWhenInvalidYN: false)
		}
	}
	
	let heightpixelsKey: String = "HeightPixels"
	
	/// Gets or sets the heightPixels
	public var heightPixels: Int {
		get {
			
			return Int(self.getProperty(key: heightpixelsKey)!)!
		}
		set(value) {
			
			self.setProperty(key: heightpixelsKey, value: String(value), setWhenInvalidYN: false)
		}
	}
	
	let positionKey: String = "Position"
	
	/// Gets or sets the playReferenceType
	public var position: CellContentPositionTypes {
		get {
			let i = Int(self.getProperty(key: positionKey)!)!
			
			return CellContentPositionTypes(rawValue: i)!
		}
		set(value) {
			
			let i = value.rawValue
			
			self.setProperty(key: positionKey, value: String(i), setWhenInvalidYN: false)
		}
	}
	
	let positionfixtocellrotationynKey: String = "PositionFixToCellRotationYN"
	
	/// Gets or sets the positionFixToCellRotationYN
	public var positionFixToCellRotationYN: Bool {
		get {
			
			return BoolHelper.fromString(value: self.getProperty(key: positionfixtocellrotationynKey)!)
		}
		set(value) {
			
			self.setProperty(key: positionfixtocellrotationynKey, value: "\(BoolHelper.toInt(value: value))", setWhenInvalidYN: false)
		}
	}
	
	let tileattributesstringKey: String = "TileAttributesString"
	
	/// Gets or sets the tileAttributesString
	public var tileAttributesString: String {
		get {
			
			return self.getProperty(key: tileattributesstringKey)!
		}
		set(value) {
			
			self.setProperty(key: tileattributesstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let tilesideattributesstringKey: String = "TileSideAttributesString"
	
	/// Gets or sets the tileSideAttributesString
	public var tileSideAttributesString: String {
		get {
			
			return self.getProperty(key: tilesideattributesstringKey)!
		}
		set(value) {
			
			self.setProperty(key: tilesideattributesstringKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayAreaTileTypeWrapper {
		
		let wrapper 						= PlayAreaTileTypeWrapper()
		
		wrapper.id							= self.id
		wrapper.playSubsetID				= self.playSubsetID
		wrapper.name						= self.name
		wrapper.isSpecialYN					= self.isSpecialYN
		wrapper.deckWeighting				= self.deckWeighting
		wrapper.imageName					= self.imageName
		wrapper.widthPixels					= self.widthPixels
		wrapper.heightPixels				= self.heightPixels
		wrapper.position					= self.position
		wrapper.positionFixToCellRotationYN	= self.positionFixToCellRotationYN
		
		// Nb: This sets up the TileAttributesString wrapper
		wrapper.set(tileAttributesString: self.tileAttributesString)
		
		// Nb: This sets up the TileSideAttributesString wrapper
		wrapper.set(tileSideAttributesString: self.tileSideAttributesString)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayAreaTileTypeWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN				= false
		
		// Copy all properties from the wrapper
		self.id								= wrapper.id
		self.playSubsetID					= wrapper.playSubsetID
		self.name							= wrapper.name
		self.isSpecialYN					= wrapper.isSpecialYN
		self.deckWeighting					= wrapper.deckWeighting
		self.imageName						= wrapper.imageName
		self.widthPixels					= wrapper.widthPixels
		self.heightPixels					= wrapper.heightPixels
		self.position						= wrapper.position
		self.positionFixToCellRotationYN	= wrapper.positionFixToCellRotationYN
		self.tileAttributesString			= wrapper.tileAttributesString
		self.tileSideAttributesString		= wrapper.tileSideAttributesString
		
		self.doValidationsYN 				= doValidationsYN
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
		self.doSetProperty(key: widthpixelsKey,	value: "0")
		self.doSetProperty(key: heightpixelsKey, value: "0")
		self.doSetProperty(key: positionKey, value: "0")
		self.doSetProperty(key: positionfixtocellrotationynKey,	value: "0")
		self.doSetProperty(key: tileattributesstringKey, value: "")
		self.doSetProperty(key: tilesideattributesstringKey, value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playAreaTileType_id.rawValue
		endEnumIndex	= ModelProperties.playAreaTileType_tileSideAttributesString.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]								= ModelProperties.playAreaTileType_id.rawValue
		keys[playsubsetidKey]					= ModelProperties.playAreaTileType_playSubsetID.rawValue
		keys[nameKey]							= ModelProperties.playAreaTileType_name.rawValue
		keys[isspecialynKey]					= ModelProperties.playAreaTileType_isSpecialYN.rawValue
		keys[deckweightingKey]					= ModelProperties.playAreaTileType_deckWeighting.rawValue
		keys[imagenameKey]						= ModelProperties.playAreaTileType_imageName.rawValue
		keys[widthpixelsKey]					= ModelProperties.playAreaTileType_widthPixels.rawValue
		keys[heightpixelsKey]					= ModelProperties.playAreaTileType_heightPixels.rawValue
		keys[positionKey]						= ModelProperties.playAreaTileType_position.rawValue
		keys[positionfixtocellrotationynKey]	= ModelProperties.playAreaTileType_positionFixToCellRotationYN.rawValue
		keys[tileattributesstringKey]			= ModelProperties.playAreaTileType_tileAttributesString.rawValue
		keys[tilesideattributesstringKey]		= ModelProperties.playAreaTileType_tileSideAttributesString.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaTileType"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 					Bool = self.doValidationsYN
		self.doValidationsYN 					= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaTileType {
			
			self.id								= item.id
			self.playSubsetID					= item.playSubsetID
			self.name							= item.name
			self.isSpecialYN					= item.isSpecialYN
			self.deckWeighting					= item.deckWeighting
			self.imageName						= item.imageName
			self.widthPixels					= item.widthPixels
			self.heightPixels					= item.heightPixels
			self.position						= item.position
			self.positionFixToCellRotationYN	= item.positionFixToCellRotationYN
			self.tileAttributesString			= item.tileAttributesString
			self.tileSideAttributesString		= item.tileSideAttributesString
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id
		
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.Name)", value: "\(self.name)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.IsSpecialYN)", value: "\(self.isSpecialYN)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.DeckWeighting)", value: "\(self.deckWeighting)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.ImageName)", value: "\(self.imageName)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.WidthPixels)", value: "\(self.widthPixels)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.HeightPixels)", value: "\(self.heightPixels)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.Position)", value: String(self.position.rawValue))
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.PositionFixToCellRotationYN)", value: "\(self.positionFixToCellRotationYN)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.TileAttributesString)", value: "\(self.tileAttributesString)")
		result.setParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.TileSideAttributesString)", value: "\(self.tileSideAttributesString)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN 				= false
		
		// Copy all properties
		self.id 							= dataWrapper.ID
		self.playSubsetID 					= dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.PlaySubsetID)")!
		self.name 							= dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.Name)")!
		self.isSpecialYN 					= Bool(dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.IsSpecialYN)")!)!
		self.deckWeighting 					= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.DeckWeighting)")!) ?? 0
		self.imageName 						= dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.ImageName)")!
		self.widthPixels 					= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.WidthPixels)")!) ?? 0
		self.heightPixels 					= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.HeightPixels)")!) ?? 0
		self.position 						= CellContentPositionTypes(rawValue: Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.Position)")!)!)!
		self.positionFixToCellRotationYN	= Bool(dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.PositionFixToCellRotationYN)")!)!
		self.tileAttributesString 			= dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.TileAttributesString)")!
		self.tileSideAttributesString 		= dataWrapper.getParameterValue(key: "\(PlayAreaTileTypeDataParameterKeys.TileSideAttributesString)")!
		
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

