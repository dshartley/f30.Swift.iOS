//
//  PlayChallengeType.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSerialization
import f30Core

public enum PlayChallengeTypeDataParameterKeys {
	case ID
	case PlaySubsetID
	case Name
	case ContentData
	case OnCompleteData
}

public enum PlayChallengeTypeContentDataKeys {
	case Title
	case ThumbnailImageName
}

/// Encapsulates a PlayChallengeType model item
public class PlayChallengeType: ModelItemBase {
	
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
	
	public func toWrapper() -> PlayChallengeTypeWrapper {
		
		let wrapper = PlayChallengeTypeWrapper()
		
		wrapper.id				= self.id
		wrapper.playSubsetID	= self.playSubsetID
		wrapper.name 			= self.name
		
		// Nb: This sets up the PlayChallengeTypeContentData wrapper
		wrapper.set(contentData: self.contentData)
		
		// Nb: This sets up the PlayChallengeTypeOnCompleteData wrapper
		wrapper.set(onCompleteData: self.onCompleteData)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayChallengeTypeWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN	= false
		
		// Copy all properties from the wrapper
		self.id					= wrapper.id
		self.playSubsetID		= wrapper.playSubsetID
		self.name 				= wrapper.name
		self.contentData		= wrapper.contentData
		self.onCompleteData		= wrapper.onCompleteData
		
		self.doValidationsYN 	= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: playsubsetidKey, 	value: "")
		self.doSetProperty(key: nameKey,			value: "")
		self.doSetProperty(key: contentdataKey,		value: "")
		self.doSetProperty(key: oncompletedataKey,	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playChallengeType_id.rawValue
		endEnumIndex	= ModelProperties.playChallengeType_onCompleteData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]					= ModelProperties.playChallengeType_id.rawValue
		keys[playsubsetidKey]		= ModelProperties.playChallengeType_playSubsetID.rawValue
		keys[nameKey]				= ModelProperties.playChallengeType_name.rawValue
		keys[contentdataKey]		= ModelProperties.playChallengeType_contentData.rawValue
		keys[oncompletedataKey]		= ModelProperties.playChallengeType_onCompleteData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayChallengeType"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayChallengeType {
			
			self.id					= item.id
			self.playSubsetID		= item.playSubsetID
			self.name 				= item.name
			self.contentData		= item.contentData
			self.onCompleteData		= item.onCompleteData
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.Name)", value: self.name)
		result.setParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.ContentData)", value: self.contentData)
		result.setParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.OnCompleteData)", value: self.onCompleteData)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN 	= false
		
		// Copy all properties
		self.id 				= dataWrapper.ID
		self.playSubsetID 		= dataWrapper.getParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.PlaySubsetID)")!
		self.name 				= dataWrapper.getParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.Name)")!
		self.contentData 		= dataWrapper.getParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.ContentData)")!
		self.onCompleteData 	= dataWrapper.getParameterValue(key: "\(PlayChallengeTypeDataParameterKeys.OnCompleteData)")!
		
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
