//
//  ProtocolUserProfileWrapperDelegate.swift
//  f30Core
//
//  Created by David on 19/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

/// Defines a delegate for a UserProfileWrapper class
public protocol ProtocolUserProfileWrapperDelegate: class {

	// MARK: - Methods
	
	func userProfileWrapper(loadSuccessful userProfileWrapper: UserProfileWrapper)
	
	func userProfileWrapper(loadFailed error: Error?, code: UserProfileWrapperErrorCodes)
	
}
