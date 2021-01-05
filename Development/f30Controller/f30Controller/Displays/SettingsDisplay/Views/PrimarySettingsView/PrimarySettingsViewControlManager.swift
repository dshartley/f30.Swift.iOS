//
//  PrimarySettingsViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFCore
import SFController
import SFGraphics
import SFSecurity
import f30View
import f30Model
import f30Core

/// Manages the PrimarySettingsView control layer
public class PrimarySettingsViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:						ProtocolPrimarySettingsViewControlManagerDelegate?
	public var viewManager:							PrimarySettingsViewViewManager?
	
	
	// MARK: - Private Stored Properties

	fileprivate var userProfileAvatarImageSize:		CGSize = CGSize(width: 50, height: 50)
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PrimarySettingsViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager				= viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func displayAvatar() {
	
		guard (UserProfileWrapper.current != nil) else { return }
		
		// Get image from avatarImageData
		let avatarImageData: Data? = UserProfileWrapper.current!.avatarImageData
		
		if (avatarImageData != nil) {
			
			// Create image
			let image: UIImage = UIImage(data: avatarImageData!)!
			
			// Display image
			self.viewManager!.displayAvatar(image: image)
			
		}

	}
	
	public func displayFullName() {
		
		guard (UserProfileWrapper.current != nil) else { return }
		
		// Display full name
		self.viewManager!.displayFullName(value: UserProfileWrapper.current!.fullName)
		
	}
	
	public func checkFullNameIsChanged() -> Bool {
		
		var result: 		Bool = false
		
		// Get from view
		let fullName: 		String = self.viewManager!.getFullName()
		
		if (fullName != UserProfileWrapper.current!.fullName) { result = true }
		
		return result
		
	}
	
	public func checkDateofBirthIsChanged() -> Bool {
		
		var result: 		Bool = false
		
		// Get from view
		let dateofBirth: 	Date = self.viewManager!.getDateofBirth()
		
		if (dateofBirth != UserProfileWrapper.current!.dateofBirth) { result = true }
		
		return result
		
	}
	
	public func displayDateofBirth() {
		
		guard (UserProfileWrapper.current != nil) else { return }

		// Display date of birth
		self.viewManager!.displayDateofBirth(dateofBirth: UserProfileWrapper.current!.dateofBirth)
		
	}
	
	public func displayAppSetting() {
		
		// Load appSetting
		let appSetting: Bool? = SettingsManager.get(boolForKey: "\(SettingsKeys.appsetting)") ?? false
		
		self.viewManager!.displayAppSetting(value: appSetting!)
	}
	
	public func saveUserProfileAvatarImageFromDisplay(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Make copy of user profile
		_ = UserProfileWrapper.makeCopy()
		
		// Get the picked image from the display
		self.getPickedAvatarImageFromDisplay()
	
		// Create completion handler
		let saveUserProfileCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			if (error == nil) {

				// Remove the existing image
				self.removeExistingUserProfileAvatarImage()
				
			} else {
				
				self.onSaveUserProfileAvatarImageFailed()
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Create completion handler
		let saveUserProfileAvatarImageCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			if (error == nil) {
				
				// Save user profile
				self.saveUserProfile(oncomplete: saveUserProfileCompletionHandler)
				
			} else {
	
				self.onSaveUserProfileAvatarImageFailed()
				
				// Call completion handler
				completionHandler(error)
				
			}
			
		}
		
		// Save user profile avatar image
		self.saveUserProfileAvatarImage(oncomplete: saveUserProfileAvatarImageCompletionHandler)
		
	}
	
	public func clearUserProfileAvatarImage(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let saveUserProfileCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Remove image from cache
		let fileName: String = UserProfileWrapper.current!.avatarImageFileName
		if (!fileName.isEmpty) {
			
			UserProfilesCacheManager.shared.removeImageFromCache(with: fileName)
			
		}
		
		// Clear image in user profile wrapper
		UserProfileWrapper.current!.avatarImageData 		= nil
		UserProfileWrapper.current!.avatarImageFileName 	= ""
		
		// Save user profile
		self.saveUserProfile(oncomplete: saveUserProfileCompletionHandler)
		
	}

	public func saveUserProfileFullNameFromDisplay(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Make copy of user profile
		_ = UserProfileWrapper.makeCopy()
		
		// Get the full name
		self.getFullNameFromDisplay()
		
		// Create completion handler
		let saveUserProfileCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			if (error != nil) {
				
				self.onSaveUserProfileFailed()
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Save user profile
		self.saveUserProfile(oncomplete: saveUserProfileCompletionHandler)
		
	}
	
	public func saveUserProfileDateofBirthFromDisplay(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Make copy of user profile
		_ = UserProfileWrapper.makeCopy()
		
		// Get the date of birth
		self.getDateofBirthFromDisplay()
		
		// Create completion handler
		let saveUserProfileCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			if (error != nil) {
				
				self.onSaveUserProfileFailed()
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Save user profile
		self.saveUserProfile(oncomplete: saveUserProfileCompletionHandler)
		
	}
	
	public func saveAppSettingFromDisplay() {
		
		let value: Bool = self.viewManager!.getAppSetting()
		
		// Save appSetting
		SettingsManager.set(bool: value, forKey: "\(SettingsKeys.appsetting)")
		
	}
	
	public func getAllowChangePasswordYN() -> Bool {
		
		var result: Bool = false
		
		if (AuthenticationManager.shared.currentUserProperties!.credentialProviderKey == .app) {
			
			result = true
			
		}
		
		return result
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
	fileprivate func getPickedAvatarImageFromDisplay() {
		
		// Get from view
		let image: 				UIImage = self.viewManager!.getAvatarImage()!
		
		// Resize the image
		let resizedImage: 		UIImage = ImageHelper.resize(image: image, targetSize: self.userProfileAvatarImageSize)
		
		// Create file name
		let uniqueFileName: 	String = "\(UUID().uuidString).jpg"
		
		// Get image
		let avatarImageData: 	Data = ImageHelper.toJPEGData(image: resizedImage)
		
		// Set in user profile wrapper
		UserProfileWrapper.current!.avatarImageData 		= avatarImageData
		UserProfileWrapper.current!.avatarImageFileName 	= uniqueFileName
		
	}

	fileprivate func getFullNameFromDisplay() {
		
		// Get from view
		let fullName: 								String = self.viewManager!.getFullName()
		
		// Set in user profile wrapper
		UserProfileWrapper.current!.fullName 		= fullName
		
	}
	
	fileprivate func getDateofBirthFromDisplay() {
		
		// Get from view
		let dateofBirth: 							Date = self.viewManager!.getDateofBirth()

		// Set in user profile wrapper
		UserProfileWrapper.current!.dateofBirth 	= dateofBirth
		
	}
	
	fileprivate func onSaveUserProfileAvatarImageFailed() {
		
		guard (UserProfileWrapper.copy != nil) else { return }
		
		// Remove the new image
		self.removeNewUserProfileAvatarImage()
		
		// Revert user profile to copied state
		UserProfileWrapper.revertToCopy()
		
		// Save to cache
		self.saveUserProfileToCache()
		
	}

	fileprivate func onSaveUserProfileFailed() {
		
		guard (UserProfileWrapper.copy != nil) else { return }
		
		// Revert user profile to copied state
		UserProfileWrapper.revertToCopy()
		
		// Save to cache
		self.saveUserProfileToCache()
		
	}
	
	fileprivate func removeExistingUserProfileAvatarImage() {
		
		// Check the existing avatarImageFileName
		if (!UserProfileWrapper.copy!.avatarImageFileName.isEmpty) {
			
			// Remove the existing image
			self.removeUserProfileAvatarImage(avatarImageFileName: UserProfileWrapper.copy!.avatarImageFileName, oncomplete: nil)
			
		}
		
	}
	
	fileprivate func removeNewUserProfileAvatarImage() {
		
		guard (UserProfileWrapper.copy != nil) else { return }
		
		// Check avatarImageFileName
		if (UserProfileWrapper.copy!.avatarImageFileName != UserProfileWrapper.current!.avatarImageFileName) {
			
			// Remove the new image
			self.removeUserProfileAvatarImage(avatarImageFileName: UserProfileWrapper.current!.avatarImageFileName, oncomplete: nil)
			
		}
		
	}
	
}
