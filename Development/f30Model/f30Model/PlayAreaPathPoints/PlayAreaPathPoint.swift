//
//  PlayAreaPathPoint.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlayAreaPathPointDataParameterKeys {
	case ID
	case PlayGameID
	case PlayAreaPathID
	case Index
	case Column
	case Row
}

/// Encapsulates a PlayAreaPathPoint model item
public class PlayAreaPathPoint: ModelItemBase, ProtocolGridScapePathPoint {

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

	let playareapathidKey: String = "PlayAreaPathID"
	
	/// Gets or sets the playAreaPathID
	public var playAreaPathID: String {
		get {
			
			return self.getProperty(key: playareapathidKey)!
		}
		set(value) {
			
			self.setProperty(key: playareapathidKey, value: value, setWhenInvalidYN: false)
		}
	}

	public var pathID: String {
		get {
			
			return self.playAreaPathID
		}
		set(value) {
			
			self.playAreaPathID = value
		}
	}
	
	let indexKey: String = "Index"
	
	/// Gets or sets the index
	public var index: Int {
		get {
			
			return Int(self.getProperty(key: indexKey)!)!
		}
		set(value) {
			
			self.setProperty(key: indexKey, value: String(value), setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayAreaPathPointWrapper {
		
		let wrapper 			= PlayAreaPathPointWrapper()
		
		wrapper.id				= self.id
		wrapper.playGameID		= self.playGameID
		wrapper.pathID			= self.playAreaPathID	// Nb: SFGridScape base class
		wrapper.index			= self.index
		wrapper.column			= self.column
		wrapper.row				= self.row

		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayAreaPathPointWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id							= wrapper.id
		self.playGameID					= wrapper.playGameID
		self.playAreaPathID				= wrapper.pathID	// Nb: SFGridScape base class
		self.index						= wrapper.index
		self.column						= wrapper.column
		self.row						= wrapper.row
		
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: playgameidKey, value: "")
		self.doSetProperty(key: playareapathidKey, value: "")
		self.doSetProperty(key: indexKey, value: "0")
		self.doSetProperty(key: columnKey, value: "0")
		self.doSetProperty(key: rowKey, value: "0")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playAreaPathPoint_id.rawValue
		endEnumIndex	= ModelProperties.playAreaPathPoint_row.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]					= ModelProperties.playAreaPathPoint_id.rawValue
		keys[playgameidKey]			= ModelProperties.playAreaPathPoint_playGameID.rawValue
		keys[playareapathidKey]		= ModelProperties.playAreaPathPoint_playAreaPathID.rawValue
		keys[indexKey]				= ModelProperties.playAreaPathPoint_index.rawValue
		keys[columnKey]				= ModelProperties.playAreaPathPoint_column.rawValue
		keys[rowKey]				= ModelProperties.playAreaPathPoint_row.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayAreaPathPoint"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN:		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayAreaPathPoint {
			
			self.id					= item.id
			self.playGameID			= item.playGameID
			self.playAreaPathID		= item.playAreaPathID
			self.index				= item.index
			self.column				= item.column
			self.row				= item.row
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id
		
		result.setParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.PlayGameID)", value: "\(self.playGameID)")
		result.setParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.PlayAreaPathID)", value: "\(self.playAreaPathID)")
		result.setParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.Index)", value: "\(self.index)")
		result.setParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.Column)", value: "\(self.column)")
		result.setParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.Row)", value: "\(self.row)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN 	= false
		
		// Copy all properties
		self.id 				= dataWrapper.ID
		self.playGameID 		= dataWrapper.getParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.PlayGameID)")!
		self.playAreaPathID 	= dataWrapper.getParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.PlayAreaPathID)")!
		self.index 				= Int(dataWrapper.getParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.Index)")!) ?? 0
		self.column 			= Int(dataWrapper.getParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.Column)")!) ?? 0
		self.row 				= Int(dataWrapper.getParameterValue(key: "\(PlayAreaPathPointDataParameterKeys.Row)")!) ?? 0
		
		self.doValidationsYN 	= doValidationsYN
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

