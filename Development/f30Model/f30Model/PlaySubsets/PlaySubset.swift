//
//  PlaySubset.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import SFGridScape

public enum PlaySubsetDataParameterKeys {
	case ID
	case Name
	case ContentData
}

public enum PlaySubsetContentDataKeys {
	case ThumbnailImageName
}

/// Encapsulates a PlaySubset model item
public class PlaySubset: ModelItemBase {
	
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

	let contentdataKey: String = "ContentData"
	
	/// Gets or sets the contentData
	public var contentData: String {
		get {
			
			return self.getProperty(key: contentdataKey)!
		}
		set(value) {
			
			self.setProperty(key: contentdataKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlaySubsetWrapper {
		
		let wrapper = PlaySubsetWrapper()
		
		wrapper.id		= self.id
		wrapper.name	= self.name

		// Nb: This sets up the PlayExperienceContentData wrapper
		wrapper.set(contentData: self.contentData)

		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlaySubsetWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN		= false
		
		// Copy all properties from the wrapper
		self.id						= wrapper.id
		self.name					= wrapper.name
		self.contentData 			= wrapper.contentData
		
		self.doValidationsYN 		= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: nameKey, value: "")
		self.doSetProperty(key: contentdataKey, value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playSubset_id.rawValue
		endEnumIndex	= ModelProperties.playSubset_contentData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]				= ModelProperties.playSubset_id.rawValue
		keys[nameKey]			= ModelProperties.playSubset_name.rawValue
		keys[contentdataKey]	= ModelProperties.playSubset_contentData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlaySubset"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the specified item
		if let item = item as? PlaySubset {
			
			self.id					= item.id
			self.name				= item.name
			self.contentData		= item.contentData
			
		}
		
		self.doValidationsYN 		= doValidationsYN
	}
	
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()
		
		result.ID 		= self.id
		
		result.setParameterValue(key: "\(PlaySubsetDataParameterKeys.Name)", value: self.name)
		result.setParameterValue(key: "\(PlaySubsetDataParameterKeys.ContentData)", value: self.contentData)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties
		self.id 					= dataWrapper.ID
		self.name 					= dataWrapper.getParameterValue(key: "\(PlaySubsetDataParameterKeys.Name)")!
		self.contentData 			= dataWrapper.getParameterValue(key: "\(PlaySubsetDataParameterKeys.ContentData)")!
		
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
