//
//  AppDelegateControlManager.swift
//  f30Controller
//
//  Created by David on 07/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFController
import SFSecurity
import SFSocial
import f30Core
import f30Model

/// Manages the AppDelegate control layer
public class AppDelegateControlManager: ControlManagerBase {

	// MARK: - Public Stored Properties
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager) {
		super.init(modelManager: modelManager)

	}
	
	
	// MARK: - Public Methods
	
	public func loadUserProfile() {
		
		guard (AuthenticationManager.shared.currentUserProperties != nil) else { return }
		
		// Create completion handler
		let createRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in

			if (item != nil && error == nil) {
				
				self.notifyUserProfileWrapperLoadSuccessful()
	
			} else {

				self.notifyUserProfileWrapperLoadFailed(error: error, code: .unspecified)
				
			}
			
		}
		
		// Create completion handler
		let loadRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				self.notifyUserProfileWrapperLoadSuccessful()

			} else if (item == nil && error == nil && self.checkIsConnected()) {
				
				// Create relative member
				self.createRelativeMember(applicationID: self.ApplicationID, oncomplete: createRelativeMemberCompletionHandler)
				
			} else {
				
				self.notifyUserProfileWrapperLoadFailed(error: error, code: .unspecified)
				
			}
			
		}
		
		// Create completion handler
		let createUserProfileCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			// Check current user profile and no error
			if (UserProfileWrapper.current != nil && error == nil) {
				
				if (SocialManager.shared.isSetupYN) {
					
					// Create relative member
					self.createRelativeMember(applicationID: self.ApplicationID, oncomplete: createRelativeMemberCompletionHandler)
					
				} else {
					
					self.notifyUserProfileWrapperLoadSuccessful()
					
				}

			
			} else if (error == nil && !self.checkIsConnected()) {
				
				self.notifyUserProfileWrapperLoadFailed(error: error, code: .notconnected)
				
			} else {
				
				self.notifyUserProfileWrapperLoadFailed(error: error, code: .unspecified)
				
			}
			
		}
		
		// Create completion handler
		let loadUserProfileCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			// Check whether to create user profile
			if (UserProfileWrapper.current == nil && error == nil && self.checkIsConnected()) {
				
				// create user profile
				self.createUserProfile(userProperties: AuthenticationManager.shared.currentUserProperties!, copyFrom: nil, oncomplete: createUserProfileCompletionHandler)
					
			} else if (UserProfileWrapper.current == nil) {
					
				// Check no error and not connected
				if (error == nil && !self.checkIsConnected()) {
					
					self.notifyUserProfileWrapperLoadFailed(error: error, code: .notconnected)
					
				} else {
					
					self.notifyUserProfileWrapperLoadFailed(error: error, code: .unspecified)
					
				}
				
			} else {
				
				if (SocialManager.shared.isSetupYN) {
					
					// Load relative member
					self.loadRelativeMember(applicationID: self.ApplicationID, oncomplete: loadRelativeMemberCompletionHandler)
					
				} else {
					
					self.notifyUserProfileWrapperLoadSuccessful()
					
				}
				
			}

		}
		
		self.loadUserProfile(userProperties: AuthenticationManager.shared.currentUserProperties!, oncomplete: loadUserProfileCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods

	fileprivate func notifyUserProfileWrapperLoadFailed(error: Error?, code: UserProfileWrapperErrorCodes) {

		UserProfileWrapper.notifyLoadFailed(code: code)

	}

	fileprivate func notifyUserProfileWrapperLoadSuccessful() {
		
		UserProfileWrapper.notifyLoadSuccessful()
		
	}
	
}
