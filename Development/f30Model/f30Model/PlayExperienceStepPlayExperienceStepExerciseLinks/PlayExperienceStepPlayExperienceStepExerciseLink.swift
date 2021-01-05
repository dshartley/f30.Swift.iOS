//
//  PlayExperienceStepPlayExperienceStepExerciseLink.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSerialization
import f30Core

public enum PlayExperienceStepPlayExperienceStepExerciseLinkDataParameterKeys {
	case ID
	case PlayExperienceStepID
	case PlayExperienceStepExerciseID
	case Index
}

/// Encapsulates a PlayExperienceStepPlayExperienceStepExerciseLink model item
public class PlayExperienceStepPlayExperienceStepExerciseLink: ModelItemBase {
	
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
	
	let playexperiencestepexerciseidKey: String = "PlayExperienceStepExerciseID"
	
	/// Gets or sets the playExperienceStepExerciseID
	public var playExperienceStepExerciseID: String {
		get {
			
			return self.getProperty(key: playexperiencestepexerciseidKey)!
		}
		set(value) {
			
			self.setProperty(key: playexperiencestepexerciseidKey, value: value, setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayExperienceStepPlayExperienceStepExerciseLinkWrapper {
		
		let wrapper = PlayExperienceStepPlayExperienceStepExerciseLinkWrapper()
		
		wrapper.id								= self.id
		wrapper.playExperienceStepID 			= self.playExperienceStepID
		wrapper.playExperienceStepExerciseID 	= self.playExperienceStepExerciseID
		wrapper.index 							= self.index
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayExperienceStepPlayExperienceStepExerciseLinkWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id								= wrapper.id
		self.playExperienceStepID			= wrapper.playExperienceStepID
		self.playExperienceStepExerciseID	= wrapper.playExperienceStepExerciseID
		self.index 							= wrapper.index
		
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data

		self.doSetProperty(key: playexperiencestepidKey, value: "0")
		self.doSetProperty(key: playexperiencestepexerciseidKey, value: "0")
		self.doSetProperty(key: indexKey, value: "0")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playExperienceStepPlayExperienceStepExerciseLink_id.rawValue
		endEnumIndex	= ModelProperties.playExperienceStepPlayExperienceStepExerciseLink_index.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]								= ModelProperties.playExperienceStepPlayExperienceStepExerciseLink_id.rawValue
		keys[playexperiencestepidKey] 			= ModelProperties.playExperienceStepPlayExperienceStepExerciseLink_playExperienceStepID.rawValue
		keys[playexperiencestepexerciseidKey] 	= ModelProperties.playExperienceStepPlayExperienceStepExerciseLink_playExperienceStepExerciseID.rawValue
		keys[indexKey] 							= ModelProperties.playExperienceStepPlayExperienceStepExerciseLink_index.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayExperienceStepPlayExperienceStepExerciseLink"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN 	= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayExperienceStepPlayExperienceStepExerciseLink {
			
			self.id								= item.id
			self.playExperienceStepID			= item.playExperienceStepID
			self.playExperienceStepExerciseID	= item.playExperienceStepExerciseID
			self.index							= item.index

		}
		
		self.doValidationsYN 	= doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayExperienceStepPlayExperienceStepExerciseLinkDataParameterKeys.PlayExperienceStepID)", value: self.playExperienceStepID)
		result.setParameterValue(key: "\(PlayExperienceStepPlayExperienceStepExerciseLinkDataParameterKeys.PlayExperienceStepExerciseID)", value: self.playExperienceStepExerciseID)
		result.setParameterValue(key: "\(PlayExperienceStepPlayExperienceStepExerciseLinkDataParameterKeys.Index)", value: "\(self.index)")
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN:	Bool = self.doValidationsYN
		self.doValidationsYN	= false
		
		// Copy all properties
		self.id 							= dataWrapper.ID
		
		self.playExperienceStepID 			= dataWrapper.getParameterValue(key: "\(PlayExperienceStepPlayExperienceStepExerciseLinkDataParameterKeys.PlayExperienceStepID)")!
		self.playExperienceStepExerciseID 	= dataWrapper.getParameterValue(key: "\(PlayExperienceStepPlayExperienceStepExerciseLinkDataParameterKeys.PlayExperienceStepExerciseID)")!
		self.index 							= Int(dataWrapper.getParameterValue(key: "\(PlayExperienceStepPlayExperienceStepExerciseLinkDataParameterKeys.Index)")!) ?? 0
		
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
