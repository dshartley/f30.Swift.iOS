//
//  UserProfileWrapper.swift
//  f30Core
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Specifies settings keys
public enum UserProfileWrapperErrorCodes {
	
	case none
	case unspecified
	case notconnected
	
}

/// A wrapper for a UserProfile model item
public class UserProfileWrapper {
	
	// MARK: - Private Static Stored Properties
	
	fileprivate static var _current:	UserProfileWrapper? = nil
	fileprivate static var _copy:		UserProfileWrapper? = nil
	
	
	// MARK: - Public Stored Properties
	
	public var id:						String = ""
	public var applicationID:			String = ""
	public var userPropertiesID:		String = ""
	public var email:					String = ""
	public var fullName:				String = ""
	public var dateofBirth:				Date = Date()
	public var avatarImageData: 		Data?
	public var avatarImageFileName: 	String = ""
	
	
	// MARK: - Public Static Stored Properties
	
	public static weak var delegate:	ProtocolUserProfileWrapperDelegate? = nil
	public static var errorCode:		UserProfileWrapperErrorCodes = .none
	
	
	// MARK: - Public Class Computed Properties
	
	public class var current: UserProfileWrapper? {
		get {
			return UserProfileWrapper._current
		}
		set(value) {
			UserProfileWrapper._current = value
		}
	}

	public class var copy: UserProfileWrapper? {
		get {
			return UserProfileWrapper._copy
		}
	}
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func makeCopy() -> UserProfileWrapper? {
		
		guard (self._current != nil) else { return nil }
		
		self._copy = UserProfileWrapper()
		
		self._copy!.clone(item: self._current!)

		return self._copy
	}
	
	public class func revertToCopy() {
		
		guard (	self._current != nil
				&& self._copy != nil) else { return }
		
		self._current!.clone(item: self._copy!)
		
	}
	
	public class func notifyLoadFailed(code: UserProfileWrapperErrorCodes) {
		
		self.errorCode = code
		
		// Notify the delegate
		UserProfileWrapper.delegate?.userProfileWrapper(loadFailed: nil, code: code)
		
	}

	public class func notifyLoadSuccessful() {
		
		self.errorCode = .none
		
		// Notify the delegate
		UserProfileWrapper.delegate?.userProfileWrapper(loadSuccessful: UserProfileWrapper.current!)
		
	}

	
	// MARK: - Public Methods

	
	// MARK: - Private Methods
	
	fileprivate func clone(item: UserProfileWrapper) {
		
		self.id 					= item.id
		self.applicationID			= item.applicationID
		self.userPropertiesID 		= item.userPropertiesID
		self.email 					= item.email
		self.fullName 				= item.fullName
		self.dateofBirth 			= item.dateofBirth
		self.avatarImageData 		= item.avatarImageData
		self.avatarImageFileName 	= item.avatarImageFileName
		
	}
	
}
