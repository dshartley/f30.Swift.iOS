//
//  AuthenticationViewLogicManager.swift
//  f30Controller
//
//  Created by David on 02/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import SFSecurity
import SFSocial
import f30View
import f30Model
import f30Core

/// Manages the AuthenticationView control layer
public class AuthenticationViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:	ProtocolAuthenticationViewControlManagerDelegate?
	public var viewManager:		AuthenticationViewViewManager?
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: AuthenticationViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager	= viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func signInWithTwitter(attributes: [String : Any]?) {
		
		// Sign in
		AuthenticationManager.shared.signIn(withTwitter: attributes)
	}
	
	public func signInWithFacebook(attributes: [String : Any]?) {
		
		// Sign in
		AuthenticationManager.shared.signIn(withFacebook: attributes)
	}
	
	public func signInWithEmail() {
		
		let email		= self.viewManager!.getSignInEmail()
		let password	= self.viewManager!.getSignInPassword()
		
		// Sign in
		AuthenticationManager.shared.signIn(withEmail: email, password: password)
	}
	
	public func signUp() {
		
		let email		= self.viewManager!.getSignUpEmail()
		let password	= self.viewManager!.getSignUpPassword()
		
		// Sign up
		AuthenticationManager.shared.signUp(email: email, password: password)
	}

	public func recoverPasswordWithEmail() {
		
		let email = self.viewManager!.getRecoverPasswordEmail()

		// Recover password
		AuthenticationManager.shared.recoverPassword(withEmail: email)
	}
	
	
	// MARK: - Override Methods
	
	public override func onSignInSuccessful(userProperties: UserProperties) {

		// Create completion handler
		let createRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signInSuccessful: userProperties)
				
			} else {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signInFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			}
			
		}
		
		// Create completion handler
		let loadRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signInSuccessful: userProperties)
				
			} else if (item == nil && error == nil) {
				
				// Create relative member
				self.createRelativeMember(applicationID: self.ApplicationID, oncomplete: createRelativeMemberCompletionHandler)
				
			} else {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signInFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			}
			
		}
		
		// Create completion handler
		let createUserProfileCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			// Check current user profile and no error
			if (UserProfileWrapper.current != nil && error == nil) {

				if (SocialManager.shared.isSetupYN) {
					
					// Create relative member
					self.createRelativeMember(applicationID: self.ApplicationID, oncomplete: createRelativeMemberCompletionHandler)
					
				} else {
					
					// Notify the delegate
					self.delegate?.authenticationViewControlManager(signInSuccessful: userProperties)
					
				}
				
			} else {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signInFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			}
			
		}
		
		// Create completion handler
		let loadUserProfileCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			// Check no current user profile and no error
			if (UserProfileWrapper.current == nil && error == nil) {
				
				// create userProfile
				self.createUserProfile(userProperties: userProperties, copyFrom: nil, oncomplete: createUserProfileCompletionHandler)
			
			} else if (error != nil) {
			
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signInFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			} else {
			
				if (SocialManager.shared.isSetupYN) {
					
					// Load relative member
					self.loadRelativeMember(applicationID: self.ApplicationID, oncomplete: loadRelativeMemberCompletionHandler)
					
				} else {
					
					// Notify the delegate
					self.delegate?.authenticationViewControlManager(signInSuccessful: userProperties)
					
				}
				
			}
			
		}

		// Load userProfile
		self.loadUserProfile(userProperties: userProperties, oncomplete: loadUserProfileCompletionHandler)

	}
	
	public override func onSignInFailed(userProperties: UserProperties?,
	                                    error: 			Error?,
	                                    code: 			AuthenticationErrorCodes?) {
		
		self.unloadUserProfile()
		self.unloadRelativeMember()

		// Notify the delegate
		self.delegate?.authenticationViewControlManager(signInFailed: userProperties, error: error, code: code)
		
	}
	
	public override func onSignUpSuccessful(userProperties: UserProperties) {

		// Create completion handler
		let createRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signUpSuccessful: userProperties)
				
			} else {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signUpFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			}
			
		}
		
		// Create completion handler
		let loadRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signUpSuccessful: userProperties)
				
			} else if (item == nil && error == nil) {
				
				// Create relative member
				self.createRelativeMember(applicationID: self.ApplicationID, oncomplete: createRelativeMemberCompletionHandler)
				
			} else {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signUpFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			}
			
		}
		
		// Create completion handler
		let createUserProfileCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			// Check current user profile and no error
			if (UserProfileWrapper.current != nil && error == nil) {
				
				if (SocialManager.shared.isSetupYN) {
					
					// Create relative member
					self.createRelativeMember(applicationID: self.ApplicationID, oncomplete: createRelativeMemberCompletionHandler)
					
				} else {
					
					// Notify the delegate
					self.delegate?.authenticationViewControlManager(signUpSuccessful: userProperties)
					
				}
				
			} else {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signUpFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			}
			
		}
		
		// Create completion handler
		let loadUserProfileCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			[unowned self] (item, error) -> Void in
			
			// Check no current user profile and no error
			if (UserProfileWrapper.current == nil && error == nil) {
				
				// Create wrapper to copy additional sign up details from
				let userProfileWrapper: UserProfileWrapper = self.createNewSignUpUserProfileWrapper()
				
				// create userProfile
				self.createUserProfile(userProperties: userProperties, copyFrom: userProfileWrapper, oncomplete: createUserProfileCompletionHandler)
				
			} else if (error != nil) {
				
				// Notify the delegate
				self.delegate?.authenticationViewControlManager(signUpFailed: userProperties, error: error, code: AuthenticationErrorCodes.unspecified)
				
			} else {
				
				if (SocialManager.shared.isSetupYN) {
					
					// Load relative member
					self.loadRelativeMember(applicationID: self.ApplicationID, oncomplete: loadRelativeMemberCompletionHandler)
					
				} else {
					
					// Notify the delegate
					self.delegate?.authenticationViewControlManager(signUpSuccessful: userProperties)
					
				}

			}
			
		}
		
		// Load userProfile
		self.loadUserProfile(userProperties: userProperties, oncomplete: loadUserProfileCompletionHandler)
		
	}
	
	public override func onSignUpFailed(userProperties: UserProperties?,
	                                    error: 			Error?,
	                                    code: 			AuthenticationErrorCodes?) {
		
		self.unloadUserProfile()
		self.unloadRelativeMember()
		
		// Notify the delegate
		self.delegate?.authenticationViewControlManager(signUpFailed: userProperties, error: error, code: code)
		
	}
	
	public override func onRecoverPasswordSuccessful() {
		
		// Notify the delegate
		self.delegate?.authenticationViewControlManager(recoverPasswordSuccessful: self)
		
	}
	
	public override func onRecoverPasswordFailed(error: Error?, code: AuthenticationErrorCodes?) {
		
		// Notify the delegate
		self.delegate?.authenticationViewControlManager(recoverPasswordFailed: error, code: code)
		
	}
	
	
	// MARK: - Private Methods

	fileprivate func createNewSignUpUserProfileWrapper() -> UserProfileWrapper {
		
		let result: UserProfileWrapper = UserProfileWrapper()
		
		result.dateofBirth = self.viewManager!.getSignUpDateofBirth()
		
		return result
	}
	
}
