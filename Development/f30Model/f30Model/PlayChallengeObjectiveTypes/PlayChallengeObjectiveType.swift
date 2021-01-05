//
//  PlayChallengeObjectiveType.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSerialization
import f30Core

public enum PlayChallengeObjectiveTypeDataParameterKeys {
	case ID
	case PlaySubsetID
	case Name
	case ContentData
	case OnCompleteData
	case Code
	case DefinitionData
}

public enum PlayChallengeObjectiveTypeContentDataKeys {
	case Title
	case ThumbnailImageName
}

/// Encapsulates a PlayChallengeObjectiveType model item
public class PlayChallengeObjectiveType: ModelItemBase {
	
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
	
	let codeKey: String = "Code"
	
	/// Gets or sets the code
	public var code: String {
		get {
			
			return self.getProperty(key: codeKey)!
		}
		set(value) {
			
			self.setProperty(key: codeKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let definitiondataKey: String = "DefinitionData"
	
	/// Gets or sets the definitionData
	public var definitionData: String {
		get {
			
			return self.getProperty(key: definitiondataKey)!
		}
		set(value) {
			
			self.setProperty(key: definitiondataKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayChallengeObjectiveTypeWrapper {
		
		let wrapper = PlayChallengeObjectiveTypeWrapper()
		
		wrapper.id				= self.id
		wrapper.playSubsetID	= self.playSubsetID
		wrapper.name 			= self.name
		wrapper.code 			= self.code
		
		// Nb: This sets up the PlayChallengeObjectiveTypeContentData wrapper
		wrapper.set(contentData: self.contentData)
		
		// Nb: This sets up the PlayChallengeObjectiveTypeOnCompleteData wrapper
		wrapper.set(onCompleteData: self.onCompleteData)

		// Nb: This sets up the PlayChallengeObjectiveTypeDefinitionData wrapper
		wrapper.set(definitionData: self.definitionData)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayChallengeObjectiveTypeWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN	= false
		
		// Copy all properties from the wrapper
		self.id					= wrapper.id
		self.playSubsetID		= wrapper.playSubsetID
		self.name 				= wrapper.name
		self.contentData		= wrapper.contentData
		self.onCompleteData		= wrapper.onCompleteData
		self.code 				= wrapper.code
		self.definitionData 	= wrapper.definitionData
		
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
		self.doSetProperty(key: codeKey,			value: "")
		self.doSetProperty(key: definitiondataKey,	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playChallengeObjectiveType_id.rawValue
		endEnumIndex	= ModelProperties.playChallengeObjectiveType_definitionData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]					= ModelProperties.playChallengeObjectiveType_id.rawValue
		keys[playsubsetidKey]		= ModelProperties.playChallengeObjectiveType_playSubsetID.rawValue
		keys[nameKey]				= ModelProperties.playChallengeObjectiveType_name.rawValue
		keys[contentdataKey]		= ModelProperties.playChallengeObjectiveType_contentData.rawValue
		keys[oncompletedataKey]		= ModelProperties.playChallengeObjectiveType_onCompleteData.rawValue
		keys[codeKey]				= ModelProperties.playChallengeObjectiveType_code.rawValue
		keys[oncompletedataKey]		= ModelProperties.playChallengeObjectiveType_definitionData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayChallengeObjectiveType"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayChallengeObjectiveType {
			
			self.id					= item.id
			self.playSubsetID		= item.playSubsetID
			self.name 				= item.name
			self.contentData		= item.contentData
			self.onCompleteData		= item.onCompleteData
			self.code 				= item.code
			self.definitionData 	= item.definitionData
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.Name)", value: self.name)
		result.setParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.ContentData)", value: self.contentData)
		result.setParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.OnCompleteData)", value: self.onCompleteData)
		result.setParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.Code)", value: self.code)
		result.setParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.DefinitionData)", value: self.definitionData)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN 	= false
		
		// Copy all properties
		self.id 				= dataWrapper.ID
		self.playSubsetID 		= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.PlaySubsetID)")!
		self.name 				= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.Name)")!
		self.contentData 		= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.ContentData)")!
		self.onCompleteData 	= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.OnCompleteData)")!
		self.code 				= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.Code)")!
		self.definitionData 	= dataWrapper.getParameterValue(key: "\(PlayChallengeObjectiveTypeDataParameterKeys.DefinitionData)")!
		
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
