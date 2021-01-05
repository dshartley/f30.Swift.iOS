//
//  PlayAreaTile.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlayAreaTileDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayGameID
	case TileTypeID
	case Column
	case Row
	case RotationDegrees
	case IsSpecialYN
	case ImageName
	case WidthPixels
	case HeightPixels
	case Position
	case PositionFixToCellRotationYN
	case TileAttributesString
	case TileSideAttributesString
	case LoadRelationalTablesYN
	case FromColumn
	case FromRow
	case ToColumn
	case ToRow
}

/// Encapsulates a PlayAreaTile model item
public class PlayAreaTile: ModelItemBase, ProtocolGridScapeTile {
	
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
	
	let tiletypeidKey: String = "TileTypeID"
	
	/// Gets or sets the tileTypeID
	public var tileTypeID: String {
		get {
			
			return self.getProperty(key: tiletypeidKey)!
		}
		set(value) {
			
			self.setProperty(key: tiletypeidKey, value: value, setWhenInvalidYN: false)
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
	
	let rotationdegreesKey: String = "RotationDegrees"
	
	/// Gets or sets the rotationDegrees
	public var rotationDegrees: Int {
		get {
			
			return Int(self.getProperty(key: rotationdegreesKey)!)!
		}
		set(value) {
			
			self.setProperty(key: rotationdegreesKey, value: String(value), setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayAreaTileWrapper {
		
		let wrapper 						= PlayAreaTileWrapper()
		
		wrapper.id							= self.id
		wrapper.relativeMemberID			= self.relativeMemberID
		wrapper.playGameID					= self.playGameID
		wrapper.tileTypeID					= self.tileTypeID
		wrapper.column						= self.column
		wrapper.row							= self.row
		wrapper.rotationDegrees				= self.rotationDegrees
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
	
	public func clone(fromWrapper wrapper: PlayAreaTileWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN				= false
		
		// Copy all properties from the wrapper
		self.id								= wrapper.id
		self.relativeMemberID				= wrapper.relativeMemberID
		self.playGameID						= wrapper.playGameID
		self.tileTypeID						= wrapper.tileTypeID
		self.column							= wrapper.column
		self.row							= wrapper.row
		self.rotationDegrees				= wrapper.rotationDegrees
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
		
		self.doSetProperty(key: relativememberidKey,	value: "0")
		self.doSetProperty(key: playgameidKey,	value: "0")
		self.doSetProperty(key: tiletypeidKey,	value: "0")
		self.doSetProperty(key: columnKey,	value: "0")
		self.doSetProperty(key: rowKey,	value: "0")
		self.doSetProperty(key: rotationdegreesKey,	value: "0")
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
		
		startEnumIndex	= ModelProperties.playAreaTile_id.rawValue
		endEnumIndex	= ModelProperties.playAreaTile_tileSideAttributesString.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]								= ModelProperties.playAreaTile_id.rawValue
		keys[relativememberidKey]				= ModelProperties.playAreaTile_relativeMemberID.rawValue
		keys[playgameidKey]						= ModelProperties.playAreaTile_playGameID.rawValue
		keys[tiletypeidKey]						= ModelProperties.playAreaTile_tileTypeID.rawValue
		keys[columnKey]							= ModelProperties.playAreaTile_column.rawValue
		keys[rowKey]							= ModelProperties.playAreaTile_row.rawValue
		keys[rotationdegreesKey]				= ModelProperties.playAreaTile_rotationDegrees.rawValue
		keys[imagenameKey]						= ModelProperties.playAreaTile_imageName.rawValue
		keys[widthpixelsKey]					= ModelProperties.playAreaTile_widthPixels.rawValue
		keys[heightpixelsKey]					= ModelProperties.playAreaTile_heightPixels.rawValue
		keys[positionKey]						= ModelProperties.playAreaTile_position.rawValue
		keys[positionfixtocellrotationynKey]	= ModelProperties.playAreaTile_positionFixToCellRotationYN.rawValue
		keys[tileattributesstringKey]			= ModelProperties.playAreaTile_tileAttributesString.rawValue
		keys[tilesideattributesstringKey]		= ModelProperties.playAreaTile_tileSideAttributesString.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaTile"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 					Bool = self.doValidationsYN
		self.doValidationsYN 					= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaTile {
			
			self.id								= item.id
			self.relativeMemberID				= item.relativeMemberID
			self.playGameID						= item.playGameID
			self.tileTypeID						= item.tileTypeID
			self.column							= item.column
			self.row							= item.row
			self.rotationDegrees				= item.rotationDegrees
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
		
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.RelativeMemberID)", value: "\(self.relativeMemberID)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.PlayGameID)", value: "\(self.playGameID)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.TileTypeID)", value: "\(self.tileTypeID)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.Column)", value: "\(self.column)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.Row)", value: "\(self.row)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.RotationDegrees)", value: "\(self.rotationDegrees)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.ImageName)", value: "\(self.imageName)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.WidthPixels)", value: "\(self.widthPixels)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.HeightPixels)", value: "\(self.heightPixels)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.Position)", value: String(self.position.rawValue))
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.PositionFixToCellRotationYN)", value: "\(self.positionFixToCellRotationYN)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.TileAttributesString)", value: "\(self.tileAttributesString)")
		result.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.TileSideAttributesString)", value: "\(self.tileSideAttributesString)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN 				= false
		
		// Copy all properties
		self.id 							= dataWrapper.ID
		self.relativeMemberID 				= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.RelativeMemberID)")!
		self.playGameID 					= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.PlayGameID)")!
		self.tileTypeID 					= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.TileTypeID)")!
		self.column 						= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.Column)")!) ?? 0
		self.row 							= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.Row)")!) ?? 0
		self.rotationDegrees 				= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.RotationDegrees)")!) ?? 0
		self.imageName 						= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.ImageName)")!
		self.widthPixels 					= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.WidthPixels)")!) ?? 0
		self.heightPixels 					= Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.HeightPixels)")!) ?? 0
		self.position 						= CellContentPositionTypes(rawValue: Int(dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.Position)")!)!)!
		self.positionFixToCellRotationYN	= Bool(dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.PositionFixToCellRotationYN)")!)!
		self.tileAttributesString 			= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.TileAttributesString)")!
		self.tileSideAttributesString 		= dataWrapper.getParameterValue(key: "\(PlayAreaTileDataParameterKeys.TileSideAttributesString)")!
		
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

