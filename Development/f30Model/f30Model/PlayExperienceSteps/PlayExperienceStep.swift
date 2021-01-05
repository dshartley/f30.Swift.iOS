//
//  PlayExperienceStep.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import f30Core

public enum PlayExperienceStepDataParameterKeys {
	case ID
	case PlaySubsetID
	case PlayExperienceStepType
	case Name
	case IsCompleteYN
	case ContentData
	case OnCompleteData
	case PlayChallengeObjectiveDefinitionData
	case LoadRelationalTablesYN
}

public enum PlayExperienceStepContentDataKeys {
	case Title
	case Index
	case ImageName
	case ThumbnailImageName
}

/// Encapsulates a PlayExperienceStep model item
public class PlayExperienceStep: ModelItemBase {
	
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
	
	let playexperiencetypeKey: String = "PlayExperienceStepType"
	
	/// Gets or sets the playExperienceStepType
	public var playExperienceStepType: PlayExperienceStepTypes {
		get {
			let i = Int(self.getProperty(key: playexperiencetypeKey)!)!
			
			return PlayExperienceStepTypes(rawValue: i)!
		}
		set(value) {
			
			let i = value.rawValue
			
			self.setProperty(key: playexperiencetypeKey, value: String(i), setWhenInvalidYN: false)
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

	let playchallengeobjectivedefinitiondataKey: String = "PlayChallengeObjectiveDefinitionData"
	
	/// Gets or sets the playChallengeObjectiveDefinitionData
	public var playChallengeObjectiveDefinitionData: String {
		get {
			
			return self.getProperty(key: playchallengeobjectivedefinitiondataKey)!
		}
		set(value) {
			
			self.setProperty(key: playchallengeobjectivedefinitiondataKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> PlayExperienceStepWrapper {
		
		let wrapper = PlayExperienceStepWrapper()
		
		wrapper.id						= self.id
		wrapper.playSubsetID			= self.playSubsetID
		wrapper.playExperienceStepType	= self.playExperienceStepType
		wrapper.name					= self.name
		wrapper.isCompleteYN			= self.isCompleteYN
		
		// Nb: This sets up the PlayExperienceStepContentData wrapper
		wrapper.set(contentData: self.contentData)
		
		// Nb: This sets up the PlayExperienceStepOnCompleteData wrapper
		wrapper.set(onCompleteData: self.onCompleteData)

		// Nb: This sets up the PlayChallengeObjectiveDefinitionData wrapper
		wrapper.set(playChallengeObjectiveDefinitionData: self.playChallengeObjectiveDefinitionData)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayExperienceStepWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 						Bool = self.doValidationsYN
		self.doValidationsYN						= false
		
		// Copy all properties from the wrapper
		self.id										= wrapper.id
		self.playSubsetID							= wrapper.playSubsetID
		self.playExperienceStepType					= wrapper.playExperienceStepType
		self.name									= wrapper.name
		self.isCompleteYN							= wrapper.isCompleteYN
		self.contentData							= wrapper.contentData
		self.onCompleteData							= wrapper.onCompleteData
		self.playChallengeObjectiveDefinitionData	= wrapper.playChallengeObjectiveDefinitionData
		self.doValidationsYN 						= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: playsubsetidKey, 							value: "")
		self.doSetProperty(key: playexperiencetypeKey,						value: "1")
		self.doSetProperty(key: nameKey,									value: "")
		self.doSetProperty(key: iscompleteynKey,							value: "0")
		self.doSetProperty(key: contentdataKey,	    						value: "")
		self.doSetProperty(key: oncompletedataKey,	    					value: "")
		self.doSetProperty(key: playchallengeobjectivedefinitiondataKey,	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playExperienceStep_id.rawValue
		endEnumIndex	= ModelProperties.playExperienceStep_playChallengeObjectiveDefinitionData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]										= ModelProperties.playExperienceStep_id.rawValue
		keys[playsubsetidKey]							= ModelProperties.playExperienceStep_playSubsetID.rawValue
		keys[playexperiencetypeKey]						= ModelProperties.playExperienceStep_playExperienceStepType.rawValue
		keys[nameKey]									= ModelProperties.playExperienceStep_name.rawValue
		keys[iscompleteynKey]							= ModelProperties.playExperienceStep_isCompleteYN.rawValue
		keys[contentdataKey]							= ModelProperties.playExperienceStep_contentData.rawValue
		keys[oncompletedataKey]							= ModelProperties.playExperienceStep_onCompleteData.rawValue
		keys[playchallengeobjectivedefinitiondataKey]	= ModelProperties.playExperienceStep_playChallengeObjectiveDefinitionData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayExperienceStep"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 							Bool = self.doValidationsYN
		self.doValidationsYN 							= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayExperienceStep {
			
			self.id										= item.id
			self.playSubsetID							= item.playSubsetID
			self.playExperienceStepType					= item.playExperienceStepType
			self.name									= item.name
			self.isCompleteYN							= item.isCompleteYN
			self.contentData							= item.contentData
			self.onCompleteData							= item.onCompleteData
			self.playChallengeObjectiveDefinitionData	= item.playChallengeObjectiveDefinitionData
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayExperienceStepDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayExperienceStepDataParameterKeys.PlayExperienceStepType)", value: String(self.playExperienceStepType.rawValue))
		result.setParameterValue(key: "\(PlayExperienceStepDataParameterKeys.Name)", value: self.name)
		result.setParameterValue(key: "\(PlayExperienceStepDataParameterKeys.IsCompleteYN)", value: "\(self.isCompleteYN)")
		result.setParameterValue(key: "\(PlayExperienceStepDataParameterKeys.ContentData)", value: self.contentData)
		result.setParameterValue(key: "\(PlayExperienceStepDataParameterKeys.OnCompleteData)", value: self.onCompleteData)
		result.setParameterValue(key: "\(PlayExperienceStepDataParameterKeys.PlayChallengeObjectiveDefinitionData)", value: self.playChallengeObjectiveDefinitionData)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 						Bool = self.doValidationsYN
		self.doValidationsYN 						= false
		
		// Copy all properties
		self.id 									= dataWrapper.ID
		
		self.playSubsetID 							= dataWrapper.getParameterValue(key: "\(PlayExperienceStepDataParameterKeys.PlaySubsetID)")!
		self.playExperienceStepType 				= PlayExperienceStepTypes(rawValue: Int(dataWrapper.getParameterValue(key: "\(PlayExperienceStepDataParameterKeys.PlayExperienceStepType)")!)!)!
		self.name 									= dataWrapper.getParameterValue(key: "\(PlayExperienceStepDataParameterKeys.Name)")!
		self.isCompleteYN 							= Bool(dataWrapper.getParameterValue(key: "\(PlayExperienceStepDataParameterKeys.IsCompleteYN)")!)!
		self.contentData 							= dataWrapper.getParameterValue(key: "\(PlayExperienceStepDataParameterKeys.ContentData)")!
		self.onCompleteData 						= dataWrapper.getParameterValue(key: "\(PlayExperienceStepDataParameterKeys.OnCompleteData)")!
		self.playChallengeObjectiveDefinitionData 	= dataWrapper.getParameterValue(key: "\(PlayExperienceStepDataParameterKeys.PlayChallengeObjectiveDefinitionData)")!
		
		self.doValidationsYN 						= doValidationsYN
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
