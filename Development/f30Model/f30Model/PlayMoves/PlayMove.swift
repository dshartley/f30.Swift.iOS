//
//  PlayMove.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSerialization
import f30Core

public enum PlayMoveDataParameterKeys {
	case ID
	case PlaySubsetID
	case PlayReferenceData
	case PlayReferenceActionType
	case ContentData
	case OnCompleteData
	case PlayAreaPathData
}

public enum PlayMoveContentDataKeys {
	case Title
	case ThumbnailImageName
}

/// Encapsulates a PlayMove model item
public class PlayMove: ModelItemBase {
	
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
	
	let playreferencedataKey: String = "PlayReferenceData"
	
	/// Gets or sets the playReferenceData
	public var playReferenceData: String {
		get {
			
			return self.getProperty(key: playreferencedataKey)!
		}
		set(value) {
			
			self.setProperty(key: playreferencedataKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let playreferenceactiontypeKey: String = "PlayReferenceActionType"
	
	/// Gets or sets the playReferenceActionType
	public var playReferenceActionType: PlayReferenceActionTypes {
		get {
			let i = Int(self.getProperty(key: playreferenceactiontypeKey)!)!
			
			return PlayReferenceActionTypes(rawValue: i)!
		}
		set(value) {
			
			let i = value.rawValue
			
			self.setProperty(key: playreferenceactiontypeKey, value: String(i), setWhenInvalidYN: false)
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
	
	public func toWrapper() -> PlayMoveWrapper {
		
		let wrapper = PlayMoveWrapper()
		
		wrapper.id						= self.id
		wrapper.playSubsetID			= self.playSubsetID
		wrapper.playReferenceActionType	= self.playReferenceActionType

		// Nb: This sets up the PlayMovePlayReferenceData wrapper
		wrapper.set(playReferenceData: self.playReferenceData)
		
		// Nb: This sets up the PlayMoveContentData wrapper
		wrapper.set(contentData: self.contentData)
		
		// Nb: This sets up the PlayMoveOnCompleteData wrapper
		wrapper.set(onCompleteData: self.onCompleteData)
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayMoveWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN			= false
		
		// Copy all properties from the wrapper
		self.id							= wrapper.id
		self.playSubsetID				= wrapper.playSubsetID
		self.playReferenceData 			= wrapper.playReferenceData
		self.playReferenceActionType	= wrapper.playReferenceActionType
		self.contentData				= wrapper.contentData
		self.onCompleteData				= wrapper.onCompleteData
		
		self.doValidationsYN 			= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		self.doSetProperty(key: playsubsetidKey, 			value: "")
		self.doSetProperty(key: playreferencedataKey,		value: "")
		self.doSetProperty(key: playreferenceactiontypeKey,	value: "1")
		self.doSetProperty(key: contentdataKey,				value: "")
		self.doSetProperty(key: oncompletedataKey,	   		value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playMove_id.rawValue
		endEnumIndex	= ModelProperties.playMove_onCompleteData.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]							= ModelProperties.playMove_id.rawValue
		keys[playsubsetidKey]				= ModelProperties.playMove_playSubsetID.rawValue
		keys[playreferencedataKey]			= ModelProperties.playMove_playReferenceData.rawValue
		keys[playreferenceactiontypeKey]	= ModelProperties.playMove_playReferenceActionType.rawValue
		keys[contentdataKey]				= ModelProperties.playMove_contentData.rawValue
		keys[oncompletedataKey]				= ModelProperties.playMove_onCompleteData.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "PlayMove"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 				Bool = self.doValidationsYN
		self.doValidationsYN 				= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayMove {
			
			self.id							= item.id
			self.playSubsetID				= item.playSubsetID
			self.playReferenceData			= item.playReferenceData
			self.playReferenceActionType	= item.playReferenceActionType
			self.contentData				= item.contentData
			self.onCompleteData				= item.onCompleteData
			
		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		result.setParameterValue(key: "\(PlayMoveDataParameterKeys.PlaySubsetID)", value: self.playSubsetID)
		result.setParameterValue(key: "\(PlayMoveDataParameterKeys.PlayReferenceData)", value: self.playReferenceData)
		result.setParameterValue(key: "\(PlayMoveDataParameterKeys.PlayReferenceActionType)", value: String(self.playReferenceActionType.rawValue))
		result.setParameterValue(key: "\(PlayMoveDataParameterKeys.ContentData)", value: self.contentData)
		result.setParameterValue(key: "\(PlayMoveDataParameterKeys.OnCompleteData)", value: self.onCompleteData)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties
		self.id 						= dataWrapper.ID
		self.playSubsetID 				= dataWrapper.getParameterValue(key: "\(PlayMoveDataParameterKeys.PlaySubsetID)")!
		self.playReferenceData 			= dataWrapper.getParameterValue(key: "\(PlayMoveDataParameterKeys.PlayReferenceData)")!
		self.playReferenceActionType 	= PlayReferenceActionTypes(rawValue: Int(dataWrapper.getParameterValue(key: "\(PlayMoveDataParameterKeys.PlayReferenceActionType)")!)!)!
		self.contentData 				= dataWrapper.getParameterValue(key: "\(PlayMoveDataParameterKeys.ContentData)")!
		self.onCompleteData 			= dataWrapper.getParameterValue(key: "\(PlayMoveDataParameterKeys.OnCompleteData)")!
		
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
