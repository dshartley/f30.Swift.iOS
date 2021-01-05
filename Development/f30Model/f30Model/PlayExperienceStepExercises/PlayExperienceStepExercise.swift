//
//  PlayExperienceStepExercise.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import f30Core

public enum PlayExperienceStepExerciseDataParameterKeys {
	case ID
	case PlaySubsetID
	case Name
	case PlayExperienceStepExerciseType
	case IsCompleteYN
	case ContentData
	case OnCompleteData
}

public enum PlayExperienceStepExerciseContentDataKeys {
	case Index
	case Text
	case ImageName
	case Answer
	case ContentImages
}

/// Encapsulates a PlayExperienceStepExercise model item
public class PlayExperienceStepExercise: ModelItemBase {
	
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
	
	let playexperiencetypeKey: String = "PlayExperienceStepExerciseType"
	
	/// Gets or sets the playExperienceStepExerciseType
	public var playExperienceStepExerciseType: PlayExperienceStepExerciseTypes {
		get {
			let i = Int(self.getProperty(key: playexperiencetypeKey)!)!
			
			return PlayExperienceStepExerciseTypes(rawValue: i)!
		}
		set(value) {
			
			let i = value.rawValue
			
			self.setProperty(key: playexperiencetypeKey, value: String(i), setWhenInvalidYN: false)
		}
	}
	
	let iscompleteynKey: String = "IsCompleteYN"
	
	/// Gets or sets the isCompleteYN
	public var isCompleteYN: Bool {
		get {
			
			return BoolHelper.fromString(value: self.getProperty(key: iscompleteynKey)!)
		}
		set(value) {
			
			self.setProperty(key: iscompleteynKey, value: "\(BoolHelper.toInt(value: value))", setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayExperienceStepExerciseWrapper {
		
		let wrapper = PlayExperienceStepExerciseWrapper()
		
		wrapper.id								= self.id
		wrapper.playSubsetID					= self.playSubsetID
		wrapper.name 							= self.name
		wrapper.playExperienceStepExerciseType	= self.playExperienceStepExerciseType
		wrapper.isCompleteYN					= self.isCompleteYN
		
		// Nb: This sets up the PlayExperienceStepExerciseContentData wrapper
		wrapper.set(contentData: self.contentData)
		
		// Nb: This sets up the PlayExperienceStepExerciseOnCompleteData wrapper
		wrapper.set(onCompleteData: self.onCompleteData)

		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayExperienceStepExerciseWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 						Bool = self.doValidationsYN
		self.doValidationsYN						= false
		
		// Copy all properties from the wrapper
		self.id										= wrapper.id
		self.playSubsetID							= wrapper.playSubsetID
		self.name 									= wrapper.name
		self.playExperienceStepExerciseType			= wrapper.playExperienceStepExerciseType
		self.isCompleteYN							= wrapper.isCompleteYN
		self.contentData							= wrapper.contentData
		self.onCompleteData							= wrapper.onCompleteData
		self.doValidationsYN 						= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: playsubsetidKey, 			value: "")
		self.doSetProperty(key: nameKey,					value: "")
		self.doSetProperty(key: playexperiencetypeKey,		value: "1")
		self.doSetProperty(key: iscompleteynKey,			value: "0")
		self.doSetProperty(key: contentdataKey,	    		value: "")
		self.doSetProperty(key: oncompletedataKey,	    	value: "")

	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playExperienceStepExercise_id.rawValue
		endEnumIndex	= ModelProperties.playExperienceStepExercise_onCompleteData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.playExperienceStepExercise_id.rawValue
		keys[playsubsetidKey]			= ModelProperties.playExperienceStepExercise_playSubsetID.rawValue
		keys[nameKey]					= ModelProperties.playExperienceStepExercise_name.rawValue
		keys[playexperiencetypeKey]		= ModelProperties.playExperienceStepExercise_playExperienceStepExerciseType.rawValue
		keys[iscompleteynKey]			= ModelProperties.playExperienceStepExercise_isCompleteYN.rawValue
		keys[contentdataKey]			= ModelProperties.playExperienceStepExercise_contentData.rawValue
		keys[oncompletedataKey]			= ModelProperties.playExperienceStepExercise_onCompleteData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayExperienceStepExercise"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 						Bool = self.doValidationsYN
		self.doValidationsYN 						= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayExperienceStepExercise {
			
			self.id									= item.id
			self.playSubsetID						= item.playSubsetID
			self.name 								= item.name
			self.playExperienceStepExerciseType		= item.playExperienceStepExerciseType
			self.isCompleteYN						= item.isCompleteYN
			self.contentData						= item.contentData
			self.onCompleteData						= item.onCompleteData
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.Name)", value: self.name)
		result.setParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.PlayExperienceStepExerciseType)", value: String(self.playExperienceStepExerciseType.rawValue))
		result.setParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.IsCompleteYN)", value: "\(self.isCompleteYN)")
		result.setParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.ContentData)", value: self.contentData)
		result.setParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.OnCompleteData)", value: self.onCompleteData)

		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 					Bool = self.doValidationsYN
		self.doValidationsYN 					= false
		
		// Copy all properties
		self.id 								= dataWrapper.ID
		
		self.playSubsetID 						= dataWrapper.getParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.PlaySubsetID)")!
		self.name 								= dataWrapper.getParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.Name)")!
		self.playExperienceStepExerciseType 	= PlayExperienceStepExerciseTypes(rawValue: Int(dataWrapper.getParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.PlayExperienceStepExerciseType)")!)!)!
		self.isCompleteYN 						= Bool(dataWrapper.getParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.IsCompleteYN)")!)!
		self.contentData 						= dataWrapper.getParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.ContentData)")!
		self.onCompleteData 					= dataWrapper.getParameterValue(key: "\(PlayExperienceStepExerciseDataParameterKeys.OnCompleteData)")!

		self.doValidationsYN 					= doValidationsYN
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
