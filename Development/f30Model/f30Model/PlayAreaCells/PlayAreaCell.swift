//
//  PlayAreaCell.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlayAreaCellDataParameterKeys {
	case ID
	case RelativeMemberID
	case PlayGameID
	case CellTypeID
	case Column
	case Row
	case RotationDegrees
	case IsSpecialYN
	case ImageName
	case CellAttributesString
	case CellSideAttributesString
	case LoadRelationalTablesYN
	case FromColumn
	case FromRow
	case ToColumn
	case ToRow
}

/// Encapsulates a PlayAreaCell model item
public class PlayAreaCell: ModelItemBase, ProtocolGridScapeCell {
	
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
	
	let celltypeidKey: String = "CellTypeID"
	
	/// Gets or sets the cellTypeID
	public var cellTypeID: String {
		get {
			
			return self.getProperty(key: celltypeidKey)!
		}
		set(value) {
			
			self.setProperty(key: celltypeidKey, value: value, setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayAreaCellWrapper {
		
		let wrapper = PlayAreaCellWrapper()
		
		wrapper.id					= self.id
		wrapper.relativeMemberID	= self.relativeMemberID
		wrapper.playGameID			= self.playGameID
		wrapper.cellTypeID			= self.cellTypeID
		wrapper.column				= self.column
		wrapper.row					= self.row
		wrapper.rotationDegrees		= self.rotationDegrees
		wrapper.imageName			= self.imageName

		// Nb: This sets up the CellAttributesString wrapper
		wrapper.set(cellAttributesString: self.cellAttributesString)
		
		// Nb: This sets up the CellSideAttributesString wrapper
		wrapper.set(cellSideAttributesString: self.cellSideAttributesString)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayAreaCellWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id							= wrapper.id
		self.relativeMemberID			= wrapper.relativeMemberID
		self.playGameID					= wrapper.playGameID
		self.cellTypeID					= wrapper.cellTypeID
		self.column						= wrapper.column
		self.row						= wrapper.row
		self.rotationDegrees			= wrapper.rotationDegrees
		self.imageName					= wrapper.imageName
		self.cellAttributesString		= wrapper.cellAttributesString
		self.cellSideAttributesString	= wrapper.cellSideAttributesString
		
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: relativememberidKey,	value: "0")
		self.doSetProperty(key: playgameidKey,	value: "0")
		self.doSetProperty(key: celltypeidKey,	value: "0")
		self.doSetProperty(key: columnKey,	value: "0")
		self.doSetProperty(key: rowKey,	value: "0")
		self.doSetProperty(key: rotationdegreesKey,	value: "0")
		self.doSetProperty(key: imagenameKey, value: "")
		self.doSetProperty(key: cellattributesstringKey, value: "")
		self.doSetProperty(key: cellsideattributesstringKey, value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playAreaCell_id.rawValue
		endEnumIndex	= ModelProperties.playAreaCell_cellSideAttributesString.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]							= ModelProperties.playAreaCell_id.rawValue
		keys[relativememberidKey]			= ModelProperties.playAreaCell_relativeMemberID.rawValue
		keys[playgameidKey]					= ModelProperties.playAreaCell_playGameID.rawValue
		keys[celltypeidKey]					= ModelProperties.playAreaCell_cellTypeID.rawValue
		keys[columnKey]						= ModelProperties.playAreaCell_column.rawValue
		keys[rowKey]						= ModelProperties.playAreaCell_row.rawValue
		keys[rotationdegreesKey]			= ModelProperties.playAreaCell_rotationDegrees.rawValue
		keys[imagenameKey]					= ModelProperties.playAreaCell_imageName.rawValue
		keys[cellattributesstringKey]		= ModelProperties.playAreaCell_cellAttributesString.rawValue
		keys[cellsideattributesstringKey]	= ModelProperties.playAreaCell_cellSideAttributesString.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaCell"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN 				= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaCell {
			
			self.id							= item.id
			self.relativeMemberID			= item.relativeMemberID
			self.playGameID					= item.playGameID
			self.cellTypeID					= item.cellTypeID
			self.column						= item.column
			self.row						= item.row
			self.rotationDegrees			= item.rotationDegrees
			self.imageName					= item.imageName
			self.cellAttributesString		= item.cellAttributesString
			self.cellSideAttributesString	= item.cellSideAttributesString
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id
		
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.RelativeMemberID)", value: "\(self.relativeMemberID)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.PlayGameID)", value: "\(self.playGameID)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.CellTypeID)", value: "\(self.cellTypeID)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.Column)", value: "\(self.column)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.Row)", value: "\(self.row)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.RotationDegrees)", value: "\(self.rotationDegrees)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.ImageName)", value: "\(self.imageName)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.CellAttributesString)", value: "\(self.cellAttributesString)")
		result.setParameterValue(key: "\(PlayAreaCellDataParameterKeys.CellSideAttributesString)", value: "\(self.cellSideAttributesString)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties
		self.id 						= dataWrapper.ID
		self.relativeMemberID 			= dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.RelativeMemberID)")!
		self.playGameID 				= dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.PlayGameID)")!
		self.cellTypeID 				= dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.CellTypeID)")!
		self.column 					= Int(dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.Column)")!) ?? 0
		self.row 						= Int(dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.Row)")!) ?? 0
		self.rotationDegrees 			= Int(dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.RotationDegrees)")!) ?? 0
		self.imageName 					= dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.ImageName)")!
		self.cellAttributesString 		= dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.CellAttributesString)")!
		self.cellSideAttributesString 	= dataWrapper.getParameterValue(key: "\(PlayAreaCellDataParameterKeys.CellSideAttributesString)")!
		
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
