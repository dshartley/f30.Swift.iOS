//
//  UserProfile.swift
//  f30Model
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import f30Core

/// Encapsulates a UserProfile model item
public class UserProfile: ModelItemBase {
	
	// MARK: - Public Stored Properties
	
	public var avatarImageData: Data?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(collection: 			ProtocolModelItemCollection,
						 storageDateFormatter:	DateFormatter) {
		super.init(collection: collection,
				   storageDateFormatter: storageDateFormatter)
	}
	
	
	// MARK: - Public Methods
	
	let applicationidKey: String = "applicationid"
	
	/// Gets or sets the applicationID
	public var applicationID: String {
		get {
			
			return self.getProperty(key: applicationidKey)!
		}
		set(value) {
			
			self.setProperty(key: applicationidKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let userpropertiesidKey: String = "userpropertiesid"
	
	/// Gets or sets the userPropertiesID
	public var userPropertiesID: String {
		get {
			
			return self.getProperty(key: userpropertiesidKey)!
		}
		set(value) {
			
			self.setProperty(key: userpropertiesidKey, value: value, setWhenInvalidYN: false)
		}
	}

	let emailKey: String = "email"
	
	/// Gets or sets the email
	public var email: String {
		get {
			
			return self.getProperty(key: emailKey)!
		}
		set(value) {
			
			self.setProperty(key: emailKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	let dateofbirthKey: String = "dateofbirth"
	
	/// Gets or sets the dateofBirth
	public var dateofBirth: Date {
		get {

			let dateString = self.getProperty(key: dateofbirthKey)!
			
			return DateHelper.getDate(fromString: dateString, fromDateFormatter: self.storageDateFormatter!)
		}
		set(value) {

			self.setProperty(key: dateofbirthKey, value: self.getStorageDateString(fromDate: value), setWhenInvalidYN: false)
		}
	}
	
	let avatarimagefilenameKey: String = "avatarimagefilename"
	
	/// Gets or sets the avatarImageFileName
	public var avatarImageFileName: String {
		get {
			
			return self.getProperty(key: avatarimagefilenameKey)!
		}
		set(value) {
			
			self.setProperty(key: avatarimagefilenameKey, value: value, setWhenInvalidYN: false)
		}
	}

	let fullnameKey: String = "fullname"
	
	/// Gets or sets the fullName
	public var fullName: String {
		get {
			
			return self.getProperty(key: fullnameKey)!
		}
		set(value) {
			
			self.setProperty(key: fullnameKey, value: value, setWhenInvalidYN: false)
		}
	}
	
	public func toWrapper() -> UserProfileWrapper {
		
		let wrapper = UserProfileWrapper()
		
		wrapper.id					= self.id
		wrapper.applicationID		= self.applicationID
		wrapper.userPropertiesID	= self.userPropertiesID
		wrapper.email 				= self.email
		wrapper.fullName 			= self.fullName
		wrapper.dateofBirth 		= self.dateofBirth
		wrapper.avatarImageData		= self.avatarImageData
		wrapper.avatarImageFileName = self.avatarImageFileName
		
		return wrapper
	}
	
	public func clone(fromWrapper wrapper: UserProfileWrapper) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 		Bool = self.doValidationsYN
		self.doValidationsYN 		= false
		
		// Copy all properties from the wrapper
		self.id						= wrapper.id
		self.applicationID			= wrapper.applicationID
		self.userPropertiesID		= wrapper.userPropertiesID
		self.email					= wrapper.email
		self.fullName 				= wrapper.fullName
		self.dateofBirth			= wrapper.dateofBirth
		self.avatarImageData		= wrapper.avatarImageData
		self.avatarImageFileName	= wrapper.avatarImageFileName
		
		self.doValidationsYN = doValidationsYN
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseDataNode() {
		
		// Setup the node data
		
		self.doSetProperty(key: idKey,					value: "0")
		self.doSetProperty(key: applicationidKey,		value: "")
		self.doSetProperty(key: userpropertiesidKey,	value: "")
		self.doSetProperty(key: emailKey,				value: "")
		self.doSetProperty(key: fullnameKey,			value: "")
		self.doSetProperty(key: dateofbirthKey,			value: "1/1/1900")
		self.doSetProperty(key: avatarimagefilenameKey,	value: "")
		
	}
	
	public override func initialiseDataItem() {
		
		// Setup foreign key dependency helpers
	}
	
	public override func initialisePropertyIndexes() {
		
		// Define the range of the properties using the enum values
		
		startEnumIndex	= ModelProperties.userProfile_id.rawValue
		endEnumIndex	= ModelProperties.userProfile_avatarFileName.rawValue
		
	}
	
	public override func initialisePropertyKeys() {
		
		// Populate the dictionary of property keys
		
		keys[idKey]						= ModelProperties.userProfile_id.rawValue
		keys[applicationidKey]			= ModelProperties.userProfile_applicationID.rawValue
		keys[userpropertiesidKey]		= ModelProperties.userProfile_userPropertiesID.rawValue
		keys[emailKey]					= ModelProperties.userProfile_email.rawValue
		keys[fullnameKey]				= ModelProperties.userProfile_fullName.rawValue
		keys[dateofbirthKey]			= ModelProperties.userProfile_dateofBirth.rawValue
		keys[avatarimagefilenameKey]	= ModelProperties.userProfile_avatarFileName.rawValue
		
	}
	
	public override var dataType: String {
		get {
			return "userProfile"
		}
	}
	
	public override func clone(item: ProtocolModelItem) {
		
		// Validations should not be performed when cloning the item
		let doValidationsYN: 			Bool = self.doValidationsYN
		self.doValidationsYN 			= false
		
		// Copy all properties from the specified item
		if let item = item as? UserProfile {
			
			self.id						= item.id
			self.applicationID			= item.applicationID
			self.userPropertiesID		= item.userPropertiesID
			self.email 					= item.email
			self.fullName 				= item.fullName
			self.dateofBirth			= item.dateofBirth
			self.avatarImageData		= item.avatarImageData
			self.avatarImageFileName	= item.avatarImageFileName
			
		}
		
		self.doValidationsYN = doValidationsYN
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
	
	// Note: This method is overridden to implement culture specific formatting
	public override func getProperty(propertyEnum: Int, toDateFormatter: DateFormatter) -> String? {
		
		var result: String = ""
		
		switch toProperty(propertyEnum: propertyEnum) {
		case .userProfile_dateofBirth:
			
			result = toDateFormatter.string(from: self.dateofBirth)
			break
			
		default:
			
			result = self.getProperty(propertyEnum: propertyEnum) ?? ""
			break
			
		}
		
		return result
		
	}
	
	// Note: This method is overridden to implement culture specific formatting
	public override func setProperty(key: String, value: String, setWhenInvalidYN: Bool, fromDateFormatter: DateFormatter) {
		
		var s: 				String = ""
		let propertyEnum: 	Int = self.toEnum(key: key)
		
		switch toProperty(propertyEnum: propertyEnum) {
		case .userProfile_dateofBirth:
			
			// Parse the value using fromDateFormatter
			s = self.doParseToStorageDateString(value: value, fromDateFormatter: fromDateFormatter)
			break
			
		default:
			
			s = value
			break
			
		}
		
		self.setProperty(key: key, value: s, setWhenInvalidYN: setWhenInvalidYN)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func toProperty(propertyEnum: Int) -> ModelProperties {
		
		return ModelProperties(rawValue: propertyEnum)!
	}
	
	
	// MARK: - Validations
	
}
