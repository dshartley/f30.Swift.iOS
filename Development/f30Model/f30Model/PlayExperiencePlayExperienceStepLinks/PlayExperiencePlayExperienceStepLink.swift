//
//  PlayExperiencePlayExperienceStepLink.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import f30Core

public enum PlayExperiencePlayExperienceStepLinkDataParameterKeys {
	case ID
	case PlayExperienceID
	case PlayExperienceStepID
	case Index
}

/// Encapsulates a PlayExperiencePlayExperienceStepLink model item
public class PlayExperiencePlayExperienceStepLink: ModelItemBase {
	
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
	
	let playexperienceidKey: String = "PlayExperienceID"
	
	/// Gets or sets the playExperienceID
	public var playExperienceID: String {
		get {
			
			return self.getProperty(key: playexperienceidKey)!
		}
		set(value) {
			
			self.setProperty(key: playexperienceidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playexperiencestepidKey: String = "PlayExperienceStepID"
	
	/// Gets or sets the playExperienceStepID
	public var playExperienceStepID: String {
		get {
			
			return self.getProperty(key: playexperiencestepidKey)!
		}
		set(value) {
			
			self.setProperty(key: playexperiencestepidKey, value: value, setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayExperiencePlayExperienceStepLinkWrapper {
		
		let wrapper = PlayExperiencePlayExperienceStepLinkWrapper()
		
		wrapper.id						= self.id
		wrapper.playExperienceID 		= self.playExperienceID
		wrapper.playExperienceStepID 	= self.playExperienceStepID
		wrapper.index 					= self.index
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayExperiencePlayExperienceStepLinkWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id							= wrapper.id
		self.playExperienceID			= wrapper.playExperienceID
		self.playExperienceStepID		= wrapper.playExperienceStepID
		self.index 						= wrapper.index
		
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data

		self.doSetProperty(key: playexperienceidKey, value: "0")
		self.doSetProperty(key: playexperiencestepidKey, value: "0")
		self.doSetProperty(key: indexKey, value: "0")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playExperiencePlayExperienceStepLink_id.rawValue
		endEnumIndex	= ModelProperties.playExperiencePlayExperienceStepLink_index.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.playExperiencePlayExperienceStepLink_id.rawValue
		keys[playexperienceidKey] 		= ModelProperties.playExperiencePlayExperienceStepLink_playExperienceID.rawValue
		keys[playexperiencestepidKey] 	= ModelProperties.playExperiencePlayExperienceStepLink_playExperienceStepID.rawValue
		keys[indexKey] 					= ModelProperties.playExperiencePlayExperienceStepLink_index.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayExperiencePlayExperienceStepLink"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN 	= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayExperiencePlayExperienceStepLink {
			
			self.id						= item.id
			self.playExperienceID		= item.playExperienceID
			self.playExperienceStepID	= item.playExperienceStepID
			self.index					= item.index

		}
		
		self.doValidationsYN 	= doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayExperiencePlayExperienceStepLinkDataParameterKeys.PlayExperienceID)", value: self.playExperienceID)
		result.setParameterValue(key: "\(PlayExperiencePlayExperienceStepLinkDataParameterKeys.PlayExperienceStepID)", value: self.playExperienceStepID)
		result.setParameterValue(key: "\(PlayExperiencePlayExperienceStepLinkDataParameterKeys.Index)", value: "\(self.index)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN:	Bool = self.doValidationsYN
		self.doValidationsYN	= false
		
		// Copy all properties
		self.id 					= dataWrapper.ID
		
		self.playExperienceID 		= dataWrapper.getParameterValue(key: "\(PlayExperiencePlayExperienceStepLinkDataParameterKeys.PlayExperienceID)")!
		self.playExperienceStepID 	= dataWrapper.getParameterValue(key: "\(PlayExperiencePlayExperienceStepLinkDataParameterKeys.PlayExperienceStepID)")!
		self.index 					= Int(dataWrapper.getParameterValue(key: "\(PlayExperiencePlayExperienceStepLinkDataParameterKeys.Index)")!) ?? 0
		
		self.doValidationsYN	= doValidationsYN
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
