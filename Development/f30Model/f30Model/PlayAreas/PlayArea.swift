//
//  PlayGame.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSerialization
import f30Core

public enum PlayGameDataParameterKeys {
	case ID
}

/// Encapsulates a PlayGame model item
public class PlayGame: ModelItemBase {
	
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

	
	public func toWrapper() -> PlayGameWrapper {
		
		let wrapper = PlayGameWrapper()
		
		wrapper.id					= self.id

		return wrapper
	}
	
	public func clone(fromWrapper wrapper: PlayGameWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 	Bool = self.doValidationsYN
		self.doValidationsYN	= false
		
		// Copy all properties from the wrapper
		self.id					= wrapper.id

		self.doValidationsYN 	= doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		super.initialiseDataNode()
		
		// Setup the node data
		
		//self.doSetProperty(key: nameKey,	    	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.playGame_id.rawValue
		endEnumIndex	= ModelProperties.playGame_id.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]				= ModelProperties.playGame_id.rawValue

	}
	
	public override var dataType: String {
		get {
			return "PlayGame"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the specified item
		if let item = item as? PlayGame {
			
			self.id					= item.id

		}
		
		self.doValidationsYN = doValidationsYN
	}
		
	public override func copyToWrapper() -> DataJSONWrapper {
		
		let result: 	DataJSONWrapper = DataJSONWrapper()

		result.ID 		= self.id

		//result.setParameterValue(key: "\(PlayGameDataParameterKeys.Name)", value: self.name)
		
		return result
	}
	
	public override func copyFromWrapper(dataWrapper: DataJSONWrapper, fromDateFormatter: DateFormatter) {
		
		// Validations should not be performed when copying the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties
		self.id 					= dataWrapper.ID
		//self.name 					= dataWrapper.getParameterValue(key: "\(PlayGameDataParameterKeys.Name)")!
		
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
