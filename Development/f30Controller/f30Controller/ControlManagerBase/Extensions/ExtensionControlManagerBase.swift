//
//  ExtensionControlManagerBase.swift
//  f30Controller
//
//  Created by David on 06/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import SFSecurity
import SFNet
import SFModel
import SFSocial
import SFCore
import SFView
import SFGraphics
import SFGridScape
import f30Core
import f30Model

// MARK: - Extension Cacheing

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func setupCacheing(managedObjectContext:	NSManagedObjectContext) {
		
		// Setup cacheing for UserProfiles
		UserProfilesCacheManager.shared.set(managedObjectContext: managedObjectContext)
		
		// DEBUG:
		//UserProfilesCacheManager.shared.deleteAllFromCache()
		
		// Setup cacheing for RelativeMembers
		if (SocialManager.shared.isSetupYN) {
			
			RelativeMembersCacheManager.shared.set(managedObjectContext: managedObjectContext)
		
			// DEBUG:
			//RelativeMembersCacheManager.shared.deleteAllFromCache()
			
		}

		// Setup cacheing for PlayGames
		PlayGamesCacheManager.shared.set(managedObjectContext: managedObjectContext)
		
		// Setup cacheing for PlayGameData
		PlayGameDataCacheManager.shared.set(managedObjectContext: managedObjectContext)
		
		// Setup cacheing for PlayAreaTokens
		PlayAreaTokensCacheManager.shared.set(managedObjectContext: managedObjectContext)
		
		// Setup cacheing for PlayAreaCells
		PlayAreaCellsCacheManager.shared.set(managedObjectContext: managedObjectContext)

		// Setup cacheing for PlayAreaTiles
		PlayAreaTilesCacheManager.shared.set(managedObjectContext: managedObjectContext)

		// Setup cacheing for PlayAreaTileData
		PlayAreaTileDataCacheManager.shared.set(managedObjectContext: managedObjectContext)
		
	}

	public func clearCacheManagers() {
		
		UserProfilesCacheManager.shared.clear()
		RelativeMembersCacheManager.shared.clear()
		PlayGamesCacheManager.shared.clear()
		PlayGameDataCacheManager.shared.clear()
		PlayAreaCellsCacheManager.shared.clear()
		PlayAreaTilesCacheManager.shared.clear()
		PlayAreaTileDataCacheManager.shared.clear()
		
	}
	
}

// MARK: - Extension Model

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func clearModelAdministrators() {
		
		self.getPlayResultModelAdministrator().initialise()
		self.getPlayGameModelAdministrator().initialise()
		self.getPlayGameDataModelAdministrator().initialise()
		self.getPlayAreaCellTypeModelAdministrator().initialise()
		self.getPlayAreaTileTypeModelAdministrator().initialise()
		self.getPlayAreaPathModelAdministrator().initialise()
		self.getPlayAreaPathPointModelAdministrator().initialise()
		self.getPlayMoveModelAdministrator().initialise()
		self.getPlayExperienceModelAdministrator().initialise()
		self.getPlayExperienceStepModelAdministrator().initialise()
		self.getPlayChallengeModelAdministrator().initialise()
		self.getPlayChallengeObjectiveModelAdministrator().initialise()
		
	}
	
}


// MARK: - Extension UserProfile

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getUserProfileModelAdministrator() -> UserProfileModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getUserProfileModelAdministrator!
	}
	
	public func unloadUserProfile() {
		
		// Unload current userProfile
		UserProfileWrapper.current = nil
		
		// Unload cache
		UserProfilesCacheManager.shared.clear()
		
	}
	
	
	// MARK: - Internal Methods
	
	internal func loadUserProfile(userProperties: UserProperties, oncomplete completionHandler:@escaping (UserProfileWrapper?, Error?) -> Void) {
		
		// Set current user profile
		UserProfileWrapper.current 		= nil
		UserProfileWrapper.errorCode 	= .none
		
		// Create completion handler
		let loadAvatarImageCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(UserProfileWrapper.current, error)
			
		}
		
		// Create completion handler
		let loadUserProfileFromCacheCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				// Load image
				self.loadUserProfileAvatarImage(for: item!, oncomplete: loadAvatarImageCompletionHandler)
				
			} else {
				
				// Set state
				self.setStateAfterLoad()
				
				// Call completion handler
				completionHandler(item, error)
				
			}
			
		}
		
		// Create completion handler
		let loadUserProfileFromDataSourceCompletionHandler: ((UserProfileWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				// Get the collection
				let collection = self.getUserProfileModelAdministrator().collection as! UserProfileCollection
				
				// Merge to cache
				UserProfilesCacheManager.shared.mergeToCache(from: collection)
				
				// Save to cache
				UserProfilesCacheManager.shared.saveToCache()
				
				// Load image
				self.loadUserProfileAvatarImage(for: item!, oncomplete: loadAvatarImageCompletionHandler)
				
			} else {
				
				// Load from cache
				self.loadUserProfileFromCache(userProperties: userProperties, oncomplete: loadUserProfileFromCacheCompletionHandler)
				
			}
			
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from cache
			if (UserProfilesCacheManager.shared.collection == nil) {
				
				// Setup the cache
				UserProfilesCacheManager.shared.set(userPropertiesID: userProperties.id!)
				
				UserProfilesCacheManager.shared.loadFromCache()
				
			}
			
			// Load from data source
			self.loadUserProfileFromDataSource(userProperties: userProperties, oncomplete: loadUserProfileFromDataSourceCompletionHandler)
			
		} else {
			
			// Load from cache
			self.loadUserProfileFromCache(userProperties: userProperties, oncomplete: loadUserProfileFromCacheCompletionHandler)
			
		}
		
	}
	
	internal func loadUserProfileAvatarImage(for item: UserProfileWrapper, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Check avatarImageFileName is set
		if (item.avatarImageFileName.isEmpty) {
			
			// Call completion handler
			completionHandler(nil, nil)
			
			return
		}
		
		let fileName: String	= item.avatarImageFileName
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?, Error?) -> Void) =
		{
			(isCachedYN, imageData, error) -> Void in
			
			if (imageData != nil && error == nil) {
				
				item.avatarImageData = imageData
				
				// Check isCachedYN
				if (!isCachedYN) {
					
					// Save to cache
					UserProfilesCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: fileName)
				}
				
			}
			
			// Call completion handler
			completionHandler(imageData, error)
			
		}
		
		// Load image data
		self.loadUserProfileAvatarImageData(userProfileWrapper: item, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	internal func createUserProfile(userProperties: UserProperties, copyFrom userProfileWrapper: UserProfileWrapper?, oncomplete completionHandler:((UserProfileWrapper?, Error?) -> Void)?) {
		
		// Create item
		let item: 					UserProfile = self.createNewUserProfileItem(userProperties: userProperties, copyFrom: userProfileWrapper)
		
		// Set status to ensure item is inserted
		item.status 				= .new
		
		// Set current user profile
		UserProfileWrapper.current 	= item.toWrapper()
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
		
			UserProfileWrapper.current!.id = item.id
			
			// Save item to cache
			self.saveUserProfileToCache(userProfile: item)
			
			// Call completion handler
			completionHandler?(UserProfileWrapper.current!, error)
			
		}
		
		// Save data
		self.saveUserProfileToDataSource(oncomplete: saveCompletionHandler)
		
	}
	
	internal func saveUserProfile(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Get the collection
		let collection: 	UserProfileCollection = self.getUserProfileModelAdministrator().collection as! UserProfileCollection
		
		// Create item
		let item: 			UserProfile = (collection.addItem() as! UserProfile)
		
		// Copy from wrapper
		item.clone(fromWrapper: UserProfileWrapper.current!)
		
		// Set status to ensure item is updated
		item.status 		= .modified
		
		// Save item to cache
		self.saveUserProfileToCache(userProfile: item)
		
		// Save item to data source
		self.saveUserProfileToDataSource(oncomplete: completionHandler)
		
		// Save RelativeMember from the updated UserProfile
		self.saveRelativeMember(oncomplete: nil)
		
	}
	
	internal func saveUserProfileToCache() {
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Get the collection
		let collection: 	UserProfileCollection = self.getUserProfileModelAdministrator().collection as! UserProfileCollection
		
		// Create item
		let item: 			UserProfile = (collection.addItem() as! UserProfile)
		
		// Copy from wrapper
		item.clone(fromWrapper: UserProfileWrapper.current!)
		
		// Set status to ensure item is updated
		item.status 		= .modified
		
		// Save item to cache
		self.saveUserProfileToCache(userProfile: item)
		
	}
	
	internal func saveUserProfileAvatarImage(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Get the collection
		let collection: 			UserProfileCollection = self.getUserProfileModelAdministrator().collection as! UserProfileCollection
		
		// Create item
		let item: 					UserProfile = (collection.addItem() as! UserProfile)
		
		// Set status to ensure item is updated
		item.status 				= .modified
		
		// Copy from wrapper
		item.clone(fromWrapper: UserProfileWrapper.current!)
		
		// Save image to cache
		self.saveUserProfileAvatarImageToCache(userProfile: item)
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Save image to data source
			self.saveUserProfileAvatarImageToDataSource(oncomplete: completionHandler)
			
		} else {

			// Call completion handler
			completionHandler(NSError())
			
		}
		
	}
	
	internal func removeUserProfileAvatarImage(avatarImageFileName: String, oncomplete completionHandler: ((Error?) -> Void)?) {
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Get the collection
		let collection: 			UserProfileCollection = self.getUserProfileModelAdministrator().collection as! UserProfileCollection
		
		// Create item
		let item: 					UserProfile = (collection.addItem() as! UserProfile)
		
		// Set status to ensure item is updated
		item.status 				= .modified
		
		// Set avatar image
		item.avatarImageData 		= nil
		item.avatarImageFileName 	= avatarImageFileName
		
		// Remove image from cache
		self.removeUserProfileAvatarImageFromCache(userProfile: item)
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Remove image from data source
			self.removeUserProfileAvatarImageFromDataSource(oncomplete: completionHandler)
			
		} else {
			
			// Call completion handler
			completionHandler?(NSError())
			
		}
		
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadUserProfileFromDataSource(userProperties: UserProperties, oncomplete completionHandler:@escaping (UserProfileWrapper?, Error?) -> Void) {
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			if (data != nil && error == nil) {
				
				// Copy item to wrapper
				let result: UserProfileWrapper? = self.loadedUserProfileToWrapper()
				
				// Set current user profile
				UserProfileWrapper.current = result
				
			}
			
			// Call completion handler
			completionHandler(UserProfileWrapper.current, error)
			
		}
		
		// Load data
		self.getUserProfileModelAdministrator().select(byUserPropertiesID: userProperties.id!, applicationID: self.ApplicationID, oncomplete: loadCompletionHandler)
		
	}
	
	fileprivate func loadUserProfileFromCache(userProperties: UserProperties, oncomplete completionHandler:@escaping (UserProfileWrapper?, Error?) -> Void) {
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Check cache is loaded
		if (UserProfilesCacheManager.shared.collection == nil) {
			
			// Setup the cache
			UserProfilesCacheManager.shared.set(userPropertiesID: userProperties.id!)
			
			// Load from cache
			UserProfilesCacheManager.shared.loadFromCache()
			
		}
		
		// Select items from the cache
		let cacheData: [Any] = UserProfilesCacheManager.shared.select()
		
		// Put loaded data into the model administrator collection
		self.getUserProfileModelAdministrator().load(data: cacheData)
		
		// Copy item to wrapper
		let result: UserProfileWrapper? = self.loadedUserProfileToWrapper()
		
		// Set current user profile
		UserProfileWrapper.current = result
		
		// Call completion handler
		completionHandler(UserProfileWrapper.current, nil)
		
	}
	
	fileprivate func loadUserProfileAvatarImageData(userProfileWrapper: UserProfileWrapper, oncomplete completionHandler:@escaping (Bool, Data?, Error?) -> Void) {
		
		// Check avatarImageFileName is set
		if (userProfileWrapper.avatarImageFileName.isEmpty) {
			
			// Call completion handler
			completionHandler(false, nil, nil)
			
			return
		}
		
		var imageData: Data? = nil
		
		// Load image from cache
		imageData = UserProfilesCacheManager.shared.loadImageFromCache(with: userProfileWrapper.avatarImageFileName)
		
		if (imageData != nil) {
			
			let isCachedYN: Bool = true
			
			userProfileWrapper.avatarImageData = imageData
			
			// Call completion handler
			completionHandler(isCachedYN, imageData, nil)
			
		} else {
			
			// Load image from data source
			self.loadUserProfileAvatarImageFromDataSource(userProfileWrapper: userProfileWrapper, oncomplete: completionHandler)
		}
	}
	
	fileprivate func loadUserProfileAvatarImageFromDataSource(userProfileWrapper: UserProfileWrapper, oncomplete completionHandler:@escaping (Bool, Data?, Error?) -> Void) {
		
		// Check avatarImageFileName is set
		if (userProfileWrapper.avatarImageFileName.isEmpty) {
			
			// Call completion handler
			completionHandler(false, nil, nil)
			
			return
		}
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Get the collection
		let collection: 			UserProfileCollection = self.getUserProfileModelAdministrator().collection as! UserProfileCollection
		
		// Create item
		let item: 					UserProfile = (collection.addItem() as! UserProfile)
		item.avatarImageFileName 	= userProfileWrapper.avatarImageFileName
		
		// Create completion handler
		let loadCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			let isCachedYN: Bool = false
			
			if (error == nil) {
				
				// Get the loaded avatar image
				self.loadedUserProfileAvatarImageToWrapper(wrapper: userProfileWrapper)
				
			} else {
				
				userProfileWrapper.avatarImageData = nil
				
			}
			
			// Call completion handler
			completionHandler(isCachedYN, userProfileWrapper.avatarImageData, error)
			
		}
		
		// Load data
		self.getUserProfileModelAdministrator().loadAvatarImage(oncomplete: loadCompletionHandler)
		
	}
	
	fileprivate func createNewUserProfileItem(userProperties: UserProperties, copyFrom userProfileWrapper: UserProfileWrapper?) -> UserProfile {
		
		var result: UserProfile? = nil
		
		self.getUserProfileModelAdministrator().initialise()
		
		// Get the collection
		if let collection = self.getUserProfileModelAdministrator().collection as? UserProfileCollection {
			
			// Create item
			result = (collection.addItem() as! UserProfile)
			
			result!.applicationID		= self.ApplicationID
			result!.userPropertiesID 	= userProperties.id!
			result!.email 				= userProperties.email!
			
			// Copy from wrapper if specified
			if let userProfileWrapper = userProfileWrapper {
				
				result?.dateofBirth = userProfileWrapper.dateofBirth
			}
		}
		
		return result!
	}
	
	fileprivate func saveUserProfileToCache(userProfile: UserProfile) {
		
		UserProfilesCacheManager.shared.collection!.clear()
		UserProfilesCacheManager.shared.collection!.addItem(item: userProfile)
		
		UserProfilesCacheManager.shared.saveToCache()
		
	}
	
	fileprivate func saveUserProfileAvatarImageToCache(userProfile: UserProfile) {
		
		UserProfilesCacheManager.shared.saveImageToCache(imageData: userProfile.avatarImageData!, fileName: userProfile.avatarImageFileName)
	}
	
	fileprivate func removeUserProfileAvatarImageFromCache(userProfile: UserProfile) {
		
		UserProfilesCacheManager.shared.removeImageFromCache(with: userProfile.avatarImageFileName)
	}
	
	fileprivate func saveUserProfileToDataSource(oncomplete completionHandler:@escaping (Error?) -> Void) {
			
		self.getUserProfileModelAdministrator().save(oncomplete: completionHandler)
		
	}
	
	fileprivate func saveUserProfileAvatarImageToDataSource(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		self.getUserProfileModelAdministrator().saveAvatarImage(oncomplete: completionHandler)
	}
	
	fileprivate func removeUserProfileAvatarImageFromDataSource(oncomplete completionHandler: ((Error?) -> Void)?) {
		
		self.getUserProfileModelAdministrator().removeAvatarImage(oncomplete: completionHandler)
	}
	
	fileprivate func loadedUserProfileToWrapper() -> UserProfileWrapper? {
		
		var result:	UserProfileWrapper?	= nil
		
		if let collection = self.getUserProfileModelAdministrator().collection {
			
			// Check number of items
			guard (collection.items!.count > 0) else { return result }
			
			for item in collection.items! {
				
				let item = item as! UserProfile
				
				// Check applicationID
				if (result == nil && item.applicationID == self.ApplicationID) {
					
					// Get item wrapper
					result = item.toWrapper()
					
				}
				
			}
			
		}
		
		return result
	}
	
	fileprivate func loadedUserProfileAvatarImageToWrapper(wrapper: UserProfileWrapper) {
		
		if let collection = self.getUserProfileModelAdministrator().collection {
			
			// Check number of items
			guard (collection.items!.count > 0) else { return }
			
			// Get the first item
			let item: UserProfile = collection.items![0] as! UserProfile
			
			// Get avatar image
			wrapper.avatarImageData = item.avatarImageData
			
		}
		
	}
	
}

// MARK: - Extension RelativeMember

extension ControlManagerBase {
	
	// MARK: - Public Methods

	public func getRelativeMemberModelAdministrator() -> RelativeMemberModelAdministrator {
		
		return SocialManager.shared.modelManager!.getRelativeMemberModelAdministrator!
	}
	
	public func unloadRelativeMember() {
		
		// Unload current RelativeMember
		RelativeMemberWrapper.current = nil
		
		// Unload cache
		RelativeMembersCacheManager.shared.clear()
		
	}
	
	
	// MARK: - Internal Methods
	
	internal func loadRelativeMember(applicationID: String, oncomplete completionHandler: ((RelativeMemberWrapper?, Error?) -> Void)?) {
		
		// Check there is a current user profile and social manager is setup
		guard (UserProfileWrapper.current != nil && SocialManager.shared.isSetupYN) else {
			// Call completion handler
			completionHandler?(nil, nil)
			return
		}
		
		// Check RelativeMemberWrapper already loaded
		if (RelativeMemberWrapper.current != nil && RelativeMemberWrapper.current!.userProfileID == UserProfileWrapper.current!.id) {
			
			// Call completion handler
			completionHandler?(RelativeMemberWrapper.current, nil)
			return
			
		}
		
		// Set current relative member
		RelativeMemberWrapper.current = nil
		
		// Create completion handler
		let loadRelativeMemberFromCacheCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler?(RelativeMemberWrapper.current, error)
			
		}
		
		// Create completion handler
		let loadRelativeMemberFromDataSourceCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			if (item != nil && error == nil) {
				
				// Merge to cache
				RelativeMembersCacheManager.shared.mergeToCache(from: RelativeMemberWrapper.current!)
				
				// Save to cache
				RelativeMembersCacheManager.shared.saveToCache()
				
				// Set state
				self.setStateAfterLoad()
				
				// Call completion handler
				completionHandler?(RelativeMemberWrapper.current, error)
				
			} else {
				
				// Load from cache
				self.loadRelativeMemberFromCache(oncomplete: loadRelativeMemberFromCacheCompletionHandler)
				
			}
			
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from cache
			if (RelativeMembersCacheManager.shared.collection == nil) {
				
				// Setup the cache
				RelativeMembersCacheManager.shared.set(userProfileID: UserProfileWrapper.current!.id)
				
				RelativeMembersCacheManager.shared.loadFromCache()
				
			}
			
			// Load from data source
			self.loadRelativeMemberFromDataSource(applicationID: applicationID, oncomplete: loadRelativeMemberFromDataSourceCompletionHandler)
			
		} else {
			
			// Load from cache
			self.loadRelativeMemberFromCache(oncomplete: loadRelativeMemberFromCacheCompletionHandler)
			
		}
		
	}
	
	internal func createRelativeMember(applicationID: String, oncomplete completionHandler: ((RelativeMemberWrapper?, Error?) -> Void)?) {
		
		// Check there is a current user profile and social manager is setup
		guard (UserProfileWrapper.current != nil && SocialManager.shared.isSetupYN) else {
			// Call completion handler
			completionHandler?(nil, nil)
			return
		}
		
		// Create completion handler
		let insertRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in	// [unowned self]
			
			// Set current relative member
			RelativeMemberWrapper.current = item
			
			// Get item
			let relativeMember: RelativeMember = self.getRelativeMemberModelAdministrator().collection!.items!.first as! RelativeMember
			
			// Save item to cache
			self.saveRelativeMemberToCache(relativeMember: relativeMember)

			// Call completion handler
			completionHandler?(item, error)
			
		}
		
		// Get current UserProfileWrapper
		let userProfileWrapper: UserProfileWrapper = UserProfileWrapper.current!
		
		// Create RelativeMember
		SocialManager.shared.insertRelativeMember(applicationID: applicationID, userProfileID: userProfileWrapper.id, email: userProfileWrapper.email, fullName: userProfileWrapper.fullName, avatarImageFileName: userProfileWrapper.avatarImageFileName, oncomplete: insertRelativeMemberCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadRelativeMemberFromCache(oncomplete completionHandler:@escaping (RelativeMemberWrapper?, Error?) -> Void) {
		
		// Setup the cache
		RelativeMembersCacheManager.shared.set(userProfileID: UserProfileWrapper.current!.id)
		
		RelativeMembersCacheManager.shared.loadFromCache()
		
		// Set current RelativeMember
		RelativeMemberWrapper.current = RelativeMembersCacheManager.shared.getWrapper()
		
		// Call completion handler
		completionHandler(RelativeMemberWrapper.current, nil)
		
	}
	
	fileprivate func loadRelativeMemberFromDataSource(applicationID: String, oncomplete completionHandler:@escaping (RelativeMemberWrapper?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([RelativeMemberWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && items?.first != nil && error == nil) {
				
				// Set current relative member
				RelativeMemberWrapper.current = items?.first
				
			}
			
			// Call completion handler
			completionHandler(RelativeMemberWrapper.current, error)
			
		}
		
		// Load data
		SocialManager.shared.loadRelativeMember(userProfileID: UserProfileWrapper.current!.id, applicationID: applicationID, oncomplete: loadCompletionHandler)
		
	}
	
	fileprivate func saveRelativeMember(oncomplete completionHandler: ((Error?) -> Void)?) {
		
		// Check there is a current user profile and social manager is setup
		guard (UserProfileWrapper.current != nil && SocialManager.shared.isSetupYN) else {
			// Call completion handler
			completionHandler?(nil)
			return
		}
		
		// Create completion handler
		let updateRelativeMemberCompletionHandler: ((RelativeMemberWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in	// [unowned self]
			
			// Call completion handler
			completionHandler?(error)
			
		}
		
		// Get current UserProfileWrapper
		let userProfileWrapper: 					UserProfileWrapper = UserProfileWrapper.current!
		
		// Get current RelativeMemberWrapper
		let relativeMemberWrapper: 					RelativeMemberWrapper = RelativeMemberWrapper.current!
		
		// Set properties in RelativeMemberWrapper
		relativeMemberWrapper.email 				= userProfileWrapper.email
		relativeMemberWrapper.fullName 				= userProfileWrapper.fullName
		relativeMemberWrapper.avatarImageFileName 	= userProfileWrapper.avatarImageFileName
		
		// Save the RelativeMember
		SocialManager.shared.updateRelativeMember(relativeMemberWrapper: relativeMemberWrapper, oncomplete: updateRelativeMemberCompletionHandler)
		
	}
	
	fileprivate func saveRelativeMemberToCache(relativeMember: RelativeMember) {
		
		// Load from cache
		if (RelativeMembersCacheManager.shared.collection == nil) {
			
			// Setup the cache
			RelativeMembersCacheManager.shared.set(userProfileID: UserProfileWrapper.current!.id)
			
			RelativeMembersCacheManager.shared.loadFromCache()
			
		}
		
		RelativeMembersCacheManager.shared.collection!.clear()
		RelativeMembersCacheManager.shared.collection!.addItem(item: relativeMember)
		
		RelativeMembersCacheManager.shared.saveToCache()
		
	}
	
}

// MARK: - Extension ApplicationID

extension ControlManagerBase {

	// MARK: - Internal Methods
	
	public var ApplicationID: String {
		get {
			return ApplicationVariables.get(key: "ApplicationID") ?? ""
		}
	}
	
}

// MARK: - Extension PlayResults

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayResultModelAdministrator() -> PlayResultModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayResultModelAdministrator!
		
	}
	
	public func createPlayResultModelItem() -> PlayResult {
		
		var result: PlayResult? = nil
		
		// Get the collection
		if let collection = self.getPlayResultModelAdministrator().collection as? PlayResultCollection {
			
			// Create item
			result = (collection.addItem() as! PlayResult)
			
			result!.status = .new
			
		}
		
		return result!
	}
	
	public func doDummySaveResult(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// DEBUG:
		//let error: Error? = NSError()
		let error: Error? = nil
		
		// Call completion handler
		completionHandler(error)
		
	}
	
	public func savePlayResult(for playGameWrapper: PlayGameWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get playResult
		if let prw = PlayWrapper.current?.playResult {
			
			prw.relativeMemberID = RelativeMemberWrapper.current!.id
			
			// Generate the JSON data to be saved
			prw.generateJSON()
			
			// Create PlayResult model item
			let item: PlayResult = self.createPlayResultModelItem()
			
			item.clone(fromWrapper: prw)
			
		}
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			if (error == nil) {
				
				// Clear playResult
				PlayWrapper.current?.playResult.clear()
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
				
				// Save to cache
				self.savePlayAreaTileDataToCache(relativeMemberID: playGameWrapper.playGameData!.relativeMemberID, playGameID: playGameWrapper.id, playAreaID: "1")
				
				// Call completion handler
				saveCompletionHandler(nil)
				
				return
				
			}
			
			if (ApplicationFlags.flag(key: "SavePlayResultDummyDataYN")) {
				
				self.doDummySaveResult(oncomplete: saveCompletionHandler)
				return
				
			}
			
		#endif
		
		// Save data
		self.getPlayResultModelAdministrator().save(oncomplete: saveCompletionHandler)
		
	}
	
}


// MARK: - Extension PlaySubsets

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlaySubsetModelAdministrator() -> PlaySubsetModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlaySubsetModelAdministrator!
		
	}
	
	public func loadPlaySubsetImages(items: [PlaySubsetWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([PlaySubsetWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var resultCount: Int = 0
		
		// Create completion handler
		let loadPlaySubsetThumbnailImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlaySubsetThumbnailImageData(for: item, urlRoot: urlRoot, oncomplete: loadPlaySubsetThumbnailImageDataCompletionHandler)
			
		}
		
	}
	
	public func loadPlaySubsetsFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, oncomplete completionHandler:@escaping ([PlaySubsetWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlaySubsetWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlaySubsetsToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlaySubsetModelAdministrator().select(byRelativeMember: relativeMemberWrapper.id, oncomplete: loadCompletionHandler)

	}

	public func loadedPlaySubsetsToWrappers() -> [PlaySubsetWrapper] {
		
		// Get the PlaySubsetWrappers
		let result: [PlaySubsetWrapper] = self.getPlaySubsetModelAdministrator().toWrappers()
		
		return result
		
	}

	
	// MARK: - Private Methods
	
	fileprivate func loadPlaySubsetThumbnailImageData(for wrapper: PlaySubsetWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get fileName
		let fileName: 					String? = wrapper.playSubsetContentData!.get(key: "\(PlaySubsetContentDataKeys.ThumbnailImageName)")
		
		guard (fileName != nil && fileName!.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Get image
		let image: 						UIImage? = UIImage(named: fileName!)
		
		if (image != nil) {
			
			// Set thumbnailImageData
			wrapper.thumbnailImageData	= ImageHelper.toPNGData(image: image!)
			
		}
		
		// Call completion handler
		completionHandler(wrapper.thumbnailImageData, nil)
		
	}
	
}


// MARK: - Extension PlayGames

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayGameModelAdministrator() -> PlayGameModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayGameModelAdministrator!
		
	}
	
	public func createPlayGameModelItem() -> PlayGame {
		
		// Create PlayGame model item
		let result: PlayGame = self.getPlayGameModelAdministrator().collection!.addItem() as! PlayGame
		
		return result
		
	}
	
	public func savePlayGame(wrapper: PlayGameWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get ModelAdministrators
		let pgma: 		PlayGameModelAdministrator = self.getPlayGameModelAdministrator()
		let pgdma: 		PlayGameDataModelAdministrator = self.getPlayGameDataModelAdministrator()
		
		pgma.initialise()
		pgdma.initialise()
		
		guard (wrapper.playGameData != nil) else {
			
			// Call completion handler
			completionHandler(NSError())
			
			return
			
		}
		
		// Create PlayGame model item
		let pg: 		PlayGame = pgma.collection!.getNewItem() as! PlayGame
		pg.clone(fromWrapper: wrapper)
		pg.status 		= wrapper.status
		pgma.collection!.addItem(item: pg)
		
		// Create PlayGameData model item
		let pgd: 		PlayGameData = pgdma.collection!.getNewItem() as! PlayGameData
		pgd.status 		= wrapper.status	// Nb: Assume this is the same as PlayGame status
		pgd.clone(fromWrapper: wrapper.playGameData!)
		pgdma.collection!.addItem(item: pgd)
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				// Update the relational model item
				pgd.playGameID	= pg.id
				
				#if DEBUG
					
					if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
						
						if (wrapper.status == .new) {
							
							pg.id 			= UUID().uuidString
							pgd.id 			= UUID().uuidString
							pgd.playGameID	= pg.id
							
						}
						
					}
					
					if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
						
						// Save to cache
						self.savePlayGamesToCache(relativeMemberID: RelativeMemberWrapper.current!.id)
						self.savePlayGameDataToCache(relativeMemberID: RelativeMemberWrapper.current!.id)
						
					}
					
				#endif
				
				// Update the wrapper
				wrapper.id 							= pg.id
				wrapper.status						= .unmodified
				wrapper.playGameData?.id 			= pgd.id
				wrapper.playGameData?.playGameID 	= pgd.playGameID
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Set insertRelationalItemsYN
		pgma.insertRelationalItemsYN = true
		
		pgma.save(oncomplete: saveCompletionHandler)
		
	}
	
	public func savePlayGamesToDataSource(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		let pgma: PlayGameModelAdministrator = self.getPlayGameModelAdministrator()
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Save to data source
		pgma.save(oncomplete: saveCompletionHandler)
		
	}
	
	public func savePlayGamesToCache(relativeMemberID: String) {
		
		// Setup the cache
		PlayGamesCacheManager.shared.set(relativeMemberID: relativeMemberID)

		// Load from cache
		PlayGamesCacheManager.shared.loadFromCache()
		
		// Get the collection
		if let collection = self.getPlayGameModelAdministrator().collection as? PlayGameCollection {
			
			// Merge to cache
			PlayGamesCacheManager.shared.mergeToCache(from: collection)
		}
		
		// Save to cache
		PlayGamesCacheManager.shared.saveToCache()
		
		PlayGamesCacheManager.shared.clear()
		
	}
	
	public func createPlayGameWrapper(relativeMemberWrapper: RelativeMemberWrapper) -> PlayGameWrapper {
		
		let result: 				PlayGameWrapper = PlayGameWrapper()
		result.id 					= UUID().uuidString
		result.relativeMemberID		= relativeMemberWrapper.id
		result.playSubsetID			= "0"
		result.dateCreated			= Date()

		let pgdw: 					PlayGameDataWrapper = PlayGameDataWrapper()
		pgdw.id 					= UUID().uuidString
		//pgdw.dateLastPlayed		= Date.distantPast		// Nb: distantPast results in year 0001, which causes error on server. Leave default value.
		pgdw.relativeMemberID		= relativeMemberWrapper.id
		pgdw.playGameID 			= result.id
		
		result.set(playGameDataWrapper: pgdw)
		
		return result
		
	}

	public func loadPlayGamesFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, loadLatestOnlyYN: Bool, oncomplete completionHandler:@escaping ([PlayGameWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayGameWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayGamesToWrappers(appendYN: true)
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayGameModelAdministrator().select(byRelativeMemberID: relativeMemberWrapper.id, loadLatestOnlyYN: loadLatestOnlyYN, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadPlayGamesFromDataSource(for playGameID: String, oncomplete completionHandler:@escaping ([PlayGameWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayGameWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayGamesToWrappers(appendYN: true)
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayGameModelAdministrator().select(byID: playGameID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadPlayGamesFromCache(for relativeMemberWrapper: RelativeMemberWrapper, oncomplete completionHandler:@escaping ([PlayGameWrapper], Error?) -> Void) {
		
		self.loadPlayGamesFromCache(for: relativeMemberWrapper, loadLatestOnlyYN: false, oncomplete: completionHandler)
		
	}
	
	public func loadPlayGamesFromCache(for relativeMemberWrapper: RelativeMemberWrapper, loadLatestOnlyYN: Bool, oncomplete completionHandler:@escaping ([PlayGameWrapper], Error?) -> Void) {
		
		// Setup the cache
		PlayGamesCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id)
		
		// Load from cache
		PlayGamesCacheManager.shared.loadFromCache()

		// Set state
		self.setStateBeforeLoad()
		
		var cacheData: [Any]? = nil
		
		if (loadLatestOnlyYN) {
			
			// Select items from the cache
			cacheData = PlayGamesCacheManager.shared.select(byRelativeMemberID: relativeMemberWrapper.id, loadLatestOnlyYN: true)
			
		} else {
			
			// Select items from the cache
			cacheData = PlayGamesCacheManager.shared.select()
			
		}
		
		guard (cacheData != nil) else {
			
			// Call completion handler
			completionHandler([PlayGameWrapper](), NSError())
			
			return
			
		}
		
		// Put loaded data into the model administrator collection
		self.getPlayGameModelAdministrator().load(data: cacheData!)
		
		// Copy items to wrappers array
		let result: [PlayGameWrapper] = self.loadedPlayGamesToWrappers(appendYN: true)
		
		// Set state
		self.setStateAfterLoad()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	public func loadPlayGamesFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, oncomplete completionHandler:@escaping ([PlayGameWrapper], Error?) -> Void) {
		
		// Setup the cache
		PlayGamesCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id)
		
		// Load from cache
		PlayGamesCacheManager.shared.loadFromCache()

		// Set state
		self.setStateBeforeLoad()
		
		// Select items from the cache
		let cacheData: [Any] = PlayGamesCacheManager.shared.select(byID: playGameID)
		
		// Put loaded data into the model administrator collection
		self.getPlayGameModelAdministrator().load(data: cacheData)
		
		// Copy items to wrappers array
		let result: [PlayGameWrapper] = self.loadedPlayGamesToWrappers(appendYN: true)
		
		// Set state
		self.setStateAfterLoad()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	public func loadedPlayGamesToWrappers(appendYN: Bool) -> [PlayGameWrapper] {
		
		// Get the PlayGamesWrappers
		let result: [PlayGameWrapper] = self.getPlayGameModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func deletePlayGame(wrapper: PlayGameWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get ModelAdministrators
		let pgma: 		PlayGameModelAdministrator = self.getPlayGameModelAdministrator()
		let pgdma: 		PlayGameDataModelAdministrator = self.getPlayGameDataModelAdministrator()
		
		pgma.initialise()
		pgdma.initialise()
		
		// Create PlayGame model item
		let pg: 		PlayGame = pgma.collection!.getNewItem() as! PlayGame
		pg.clone(fromWrapper: wrapper)
		pg.status 		= .deleted		// Set status deleted
		pgma.collection!.addItem(item: pg)

		// Create PlayGameData model item
		let pgd: 		PlayGameData = pgdma.collection!.getNewItem() as! PlayGameData
		pgd.status 		= .deleted		// Set status deleted
		pgd.clone(fromWrapper: wrapper.playGameData!)
		pgdma.collection!.addItem(item: pgd)
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				#if DEBUG
					
					if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
						
						// Save to cache
						self.savePlayGamesToCache(relativeMemberID: RelativeMemberWrapper.current!.id)
						self.savePlayGameDataToCache(relativeMemberID: RelativeMemberWrapper.current!.id)
						
					}
					
				#endif
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Nb: Call save on the playGameModelAdministrator only. We assume that the PlayGameWrapper will be deleted by it's foreign key relationship with the PlayGame.
		pgma.save(oncomplete: saveCompletionHandler)
		
	}
	
}

// MARK: - Extension PlayGameData

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayGameDataModelAdministrator() -> PlayGameDataModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayGameDataModelAdministrator!
		
	}
	
	public func createPlayGameDataModelItem() -> PlayGameData {
		
		// Create PlayGame model item
		let result: PlayGameData = self.getPlayGameDataModelAdministrator().collection!.addItem() as! PlayGameData
		
		return result
		
	}
	
	public func savePlayGameDataToCache(relativeMemberID: String) {
		
		// Setup the cache
		PlayGameDataCacheManager.shared.set(relativeMemberID: relativeMemberID)
		
		// Load from cache
		PlayGameDataCacheManager.shared.loadFromCache()
		
		// Get the collection
		if let collection = self.getPlayGameDataModelAdministrator().collection as? PlayGameDataCollection {
			
			// Merge to cache
			PlayGameDataCacheManager.shared.mergeToCache(from: collection)
		}
		
		// Save to cache
		PlayGameDataCacheManager.shared.saveToCache()
		
		PlayGamesCacheManager.shared.clear()
		
	}
	
	public func loadPlayGameDataFromCache(for relativeMemberWrapper: RelativeMemberWrapper, oncomplete completionHandler:@escaping ([PlayGameDataWrapper], Error?) -> Void) {
		
		// Setup the cache
		PlayGameDataCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id)
		
		// Load from cache
		PlayGameDataCacheManager.shared.loadFromCache()

		// Set state
		self.setStateBeforeLoad()
		
		// Select items from the cache
		let cacheData: [Any] = PlayGameDataCacheManager.shared.select()
		
		// Put loaded data into the model administrator collection
		self.getPlayGameDataModelAdministrator().load(data: cacheData)
		
		// Copy items to wrappers array
		let result: [PlayGameDataWrapper] = self.loadedPlayGameDataToWrappers(appendYN: true)
		
		// Set state
		self.setStateAfterLoad()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	public func loadPlayGameDataFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, oncomplete completionHandler:@escaping ([PlayGameDataWrapper], Error?) -> Void) {
		
		// Setup the cache
		PlayGameDataCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id)
		
		// Load from cache
		PlayGameDataCacheManager.shared.loadFromCache()

		// Set state
		self.setStateBeforeLoad()
		
		// Select items from the cache
		let cacheData: [Any] = PlayGameDataCacheManager.shared.select(byPlayGameID: playGameID)
		
		// Put loaded data into the model administrator collection
		self.getPlayGameDataModelAdministrator().load(data: cacheData)
		
		// Copy items to wrappers array
		let result: [PlayGameDataWrapper] = self.loadedPlayGameDataToWrappers(appendYN: true)
		
		// Set state
		self.setStateAfterLoad()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	public func loadedPlayGameDataToWrappers(appendYN: Bool) -> [PlayGameDataWrapper] {
		
		// Get the PlayGameDataWrappers
		let result: [PlayGameDataWrapper] = self.getPlayGameDataModelAdministrator().toWrappers()
		
		return result
		
	}
	
}

// MARK: - Extension PlayAreaTokens

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaTokenModelAdministrator() -> PlayAreaTokenModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaTokenModelAdministrator!
		
	}
	
	public func createPlayAreaTokenWrapper(for playGameWrapper: PlayGameWrapper) -> PlayAreaTokenWrapper {

		// Create PlayAreaTokenWrapper
		let result: 				PlayAreaTokenWrapper = PlayAreaTokenWrapper()

		// Set properties
		result.relativeMemberID		= RelativeMemberWrapper.current!.id
		result.playGameID			= playGameWrapper.id

		return result

	}

	public func loadPlayAreaTokenImages(items: [PlayAreaTokenWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([PlayAreaTokenWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var resultCount: Int = 0
		
		// Create completion handler
		let loadPlayAreaTokenImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlayAreaTokenImageData(for: item, urlRoot: urlRoot, oncomplete: loadPlayAreaTokenImageDataCompletionHandler)
			
		}
		
	}
	
	public func savePlayAreaToken(wrapper: PlayAreaTokenWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {

		// Get ModelAdministrator
		let patma: 		PlayAreaTokenModelAdministrator = self.getPlayAreaTokenModelAdministrator()

		patma.initialise()

		// Create PlayAreaToken model item
		let pat: 		PlayAreaToken = patma.collection!.getNewItem() as! PlayAreaToken
		pat.clone(fromWrapper: wrapper)
		pat.status 		= wrapper.status
		patma.collection!.addItem(item: pat)

		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]

			if (error == nil) {

				#if DEBUG

					if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {

						if (wrapper.status == .new) {

							pat.id = UUID().uuidString

						}

					}

					if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {

						// Save to cache
						self.savePlayAreaTokensToCache(relativeMemberID: pat.relativeMemberID, playGameID: pat.playGameID, playAreaID: "1")

					}

				#endif

				// Update the wrapper
				wrapper.id 		= pat.id
				wrapper.status	= .unmodified

			}

			// Call completion handler
			completionHandler(error)

		}

		patma.save(oncomplete: saveCompletionHandler)

	}

	public func savePlayAreaTokensToCache(relativeMemberID: String, playGameID: String, playAreaID: String) {

		// Setup the cache
		PlayAreaTokensCacheManager.shared.set(relativeMemberID: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID)

		// Get the collection
		if let collection = self.getPlayAreaTokenModelAdministrator().collection as? PlayAreaTokenCollection {

			// Merge to cache
			PlayAreaTokensCacheManager.shared.mergeToCache(from: collection)
		}

		// Save to cache
		PlayAreaTokensCacheManager.shared.saveToCache()

	}

	public func loadPlayAreaTokensFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping ([PlayAreaTokenWrapper]?, Error?) -> Void) {

		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in

			var result: [PlayAreaTokenWrapper]? = nil

			if (data != nil && error == nil) {

				// Copy items to wrappers array
				result = self.loadedPlayAreaTokensToWrappers()
			}

			// Set state
			self.setStateAfterLoad()

			// Call completion handler
			completionHandler(result, error)
		}

		// Set state
		self.setStateBeforeLoad()

		// Load data
		self.getPlayAreaTokenModelAdministrator().select(byPlayGameID: playGameID, relativeMemberID: relativeMemberWrapper.id, playAreaID: playAreaID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)

	}

	public func loadPlayAreaTokensFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping ([PlayAreaTokenWrapper], Error?) -> Void) {

		// Setup the cache
		PlayAreaTokensCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID)

		// Load from cache
		PlayAreaTokensCacheManager.shared.loadFromCache()

		// Set state
		self.setStateBeforeLoad()

		// Select items from the cache
		let cacheData: [Any] = PlayAreaTokensCacheManager.shared.select()

		// Put loaded data into the model administrator collection
		self.getPlayAreaTokenModelAdministrator().load(data: cacheData)

		// Copy items to wrappers array
		let result: [PlayAreaTokenWrapper] = self.loadedPlayAreaTokensToWrappers()

		// Set state
		self.setStateAfterLoad()

		// Call completion handler
		completionHandler(result, nil)

	}

	public func loadedPlayAreaTokensToWrappers() -> [PlayAreaTokenWrapper] {

		// Get the PlayAreaTokenWrappers
		let result: [PlayAreaTokenWrapper] = self.getPlayAreaTokenModelAdministrator().toWrappers()

		return result

	}


	// MARK: - Private Methods
	
	fileprivate func loadPlayAreaTokenImageData(for wrapper: PlayAreaTokenWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		let fileName: String	= wrapper.imageName
		
		guard (fileName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Get image
		let image: 				UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			// Set imageData
			wrapper.imageData 	= ImageHelper.toPNGData(image: image!)
			
		}
		
		// Call completion handler
		completionHandler(wrapper.imageData, nil)
		
	}
	
}

// MARK: - Extension PlayAreaCellTypes

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaCellTypeModelAdministrator() -> PlayAreaCellTypeModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaCellTypeModelAdministrator!
		
	}
	
	public func loadPlayAreaCellTypesFromDataSource(for playSubsetID: String, relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, oncomplete completionHandler:@escaping ([PlayAreaCellTypeWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayAreaCellTypeWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayAreaCellTypesToWrappers(appendYN: true)
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayAreaCellTypeModelAdministrator().select(byPlaySubsetID: playSubsetID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadedPlayAreaCellTypesToWrappers(appendYN: Bool) -> [PlayAreaCellTypeWrapper] {
		
		// Get the PlayAreaCellTypesWrappers
		let result: [PlayAreaCellTypeWrapper] = self.getPlayAreaCellTypeModelAdministrator().toWrappers()
		
		return result
		
	}

	public func getRandomPlayAreaCellTypeWrapper(urlRoot: String, oncomplete completionHandler:@escaping (PlayAreaCellTypeWrapper?, Error?) -> Void) {
		
		guard (PlayWrapper.current!.playAreaCellTypes!.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, NSError())
			
			return
			
		}
		
		var result: 			PlayAreaCellTypeWrapper? = nil
		
		// Create completion handler
		let loadPlayAreaCellTypeImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			guard (data != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Get playAreaCellTypes that are not isSpecialYN
		let playAreaCellTypes:	[String:PlayAreaCellTypeWrapper] = PlayWrapper.current!.get(byIsSpecialYN: false)
		
		guard (playAreaCellTypes.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, NSError())
			
			return
			
		}
		
		var ids: 				[String] = [String]()
		
		// Go through each item
		for pactw in playAreaCellTypes.values {
			
			// Add ids for deckWeighting
			for _ in 1...pactw.deckWeighting { ids.append(pactw.id) }
			
		}
		
		let numberofItems: 		Int = ids.count
		let randomIndex: 		Int = MathHelper.random(0..<numberofItems)
		let randomID:			String = ids[randomIndex]
		result 					= playAreaCellTypes[randomID]
		
		// Check imageData
		if (result!.imageData != nil) {
			
			// Call completion handler
			completionHandler(result, nil)
			
		} else {
			
			// Check imageName
			if (result!.imageName.count > 0) {
				
				// Load image
				self.loadPlayAreaCellTypeImageData(for: result!, urlRoot: urlRoot, oncomplete: loadPlayAreaCellTypeImageDataCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(result, nil)
				
			}
			
		}
		
	}
	
	public func loadPlayAreaCellTypeImageData(for wrapper: PlayAreaCellTypeWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		let fileName: String	= wrapper.imageName
		
		guard (fileName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				wrapper.imageData = imageData
				
				if (!isCachedYN) {
					
					// Save to cache
					PlayAreaCellsCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: fileName)
				}
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayAreaCellTypeImageData(fileName: fileName, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadPlayAreaCellTypeImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		var isCachedYN: 	Bool = false
		
		// Load application image
		let image: 		UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData == nil) {
			
			// Load image from cache
			imageData = PlayAreaCellsCacheManager.shared.loadImageFromCache(with: fileName)
			
			isCachedYN = (imageData != nil)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayAreaCells

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaCellModelAdministrator() -> PlayAreaCellModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaCellModelAdministrator!
		
	}
	
	public func createPlayAreaCellWrapper(for playAreaCellTypeWrapper: PlayAreaCellTypeWrapper, urlRoot: String, oncomplete completionHandler:@escaping (PlayAreaCellWrapper?, Error?) -> Void) {
		
		let result: 						PlayAreaCellWrapper = PlayAreaCellWrapper()
		
		// Create completion handler
		let loadPlayAreaCellImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			guard (data != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Set in playAreaCellTypeWrapper
			playAreaCellTypeWrapper.imageData = result.imageData
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		result.cellTypeID		= playAreaCellTypeWrapper.id
		
		// Set cellTypeWrapper
		result.set(cellTypeWrapper: playAreaCellTypeWrapper)
		
		result.imageName 		= playAreaCellTypeWrapper.imageName
		result.imageData 		= playAreaCellTypeWrapper.imageData

		// Check imageData
		if (result.imageData != nil) {
			
			// Call completion handler
			completionHandler(result, nil)
			
		} else {
		
			// Check imageName
			if (result.imageName.count > 0) {
				
				// Load image
				self.loadPlayAreaCellImageData(for: result, urlRoot: urlRoot, oncomplete: loadPlayAreaCellImageDataCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(result, nil)
				
			}
			
		}
		
	}

	public func createPlayAreaCellWrapper(for playGameWrapper: PlayGameWrapper) -> PlayAreaCellWrapper {
		
		// Create PlayAreaCellWrapper
		let result: 				PlayAreaCellWrapper = PlayAreaCellWrapper()
		
		// Set properties
		result.relativeMemberID		= RelativeMemberWrapper.current!.id
		result.playGameID			= playGameWrapper.id
		
		return result
		
	}

	public func loadPlayAreaCellsImages(items: [PlayAreaCellWrapper], urlRoot: String, doLoadTilesImagesYN: Bool, oncomplete completionHandler:@escaping ([PlayAreaCellWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		let _items: 								[PlayAreaCellWrapper] = items
		
		// Create playAreaTiles
		var playAreaTiles: 							[PlayAreaTileWrapper] = [PlayAreaTileWrapper]()

		var loadPlayAreaCellImageDataResultCount: 	Int = 0
		
		// Create completion handler
		let loadPlayAreaTilesImagesCompletionHandler: (([PlayAreaTileWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(_items, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaCellImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			guard (data != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(_items, error)
				
				return
				
			}
			
			loadPlayAreaCellImageDataResultCount += 1
			
			// Check loadPlayAreaCellImageDataResultCount
			guard (loadPlayAreaCellImageDataResultCount >= _items.count) else { return }
			
			// Check doLoadTilesImagesYN
			if (doLoadTilesImagesYN && playAreaTiles.count > 0) {
				
				// Load playAreaTiles images
				self.loadPlayAreaTilesImages(items: playAreaTiles, urlRoot: urlRoot, oncomplete: loadPlayAreaTilesImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(_items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in _items {
			
			// Append tileWrapper to collection
			if (item.tileWrapper != nil) { playAreaTiles.append(item.tileWrapper as! PlayAreaTileWrapper) }
			
			// Load image data
			self.loadPlayAreaCellImageData(for: item, urlRoot: urlRoot, oncomplete: loadPlayAreaCellImageDataCompletionHandler)
			
		}
		
	}
	
	public func savePlayAreaCell(wrapper: PlayAreaCellWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get ModelAdministrator
		let pacma: 		PlayAreaCellModelAdministrator = self.getPlayAreaCellModelAdministrator()

		pacma.initialise()

		// Create PlayAreaCell model item
		let pac: 		PlayAreaCell = pacma.collection!.getNewItem() as! PlayAreaCell
		pac.clone(fromWrapper: wrapper)
		pac.status 		= wrapper.status
		pacma.collection!.addItem(item: pac)
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				#if DEBUG
					
					if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
						
						if (wrapper.status == .new) {
							
							pac.id = UUID().uuidString
							
						}
						
					}
					
					if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
						
						// Save to cache
						self.savePlayAreaCellsToCache(relativeMemberID: pac.relativeMemberID, playGameID: pac.playGameID, playAreaID: "1")
	
					}
					
				#endif
				
				// Update the wrapper
				wrapper.id 		= pac.id
				wrapper.status	= .unmodified
	
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		pacma.save(oncomplete: saveCompletionHandler)
		
	}
	
	public func savePlayAreaCellsToCache(relativeMemberID: String, playGameID: String, playAreaID: String) {
		
		// Setup the cache
		PlayAreaCellsCacheManager.shared.set(relativeMemberID: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID)
		
		// Get the collection
		if let collection = self.getPlayAreaCellModelAdministrator().collection as? PlayAreaCellCollection {
			
			// Merge to cache
			PlayAreaCellsCacheManager.shared.mergeToCache(from: collection)
		}
		
		// Save to cache
		PlayAreaCellsCacheManager.shared.saveToCache()
		
	}

	public func loadPlayAreaCellsFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, oncomplete completionHandler:@escaping ([PlayAreaCellWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayAreaCellWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayAreaCellsToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		let fcc: 	CellCoord = cellCoordRange.topLeft
		let tcc: 	CellCoord = cellCoordRange.bottomRight
		
		// Load data
		self.getPlayAreaCellModelAdministrator().select(byCellCoordRange: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID, fromColumn: fcc.column, fromRow: fcc.row, toColumn: tcc.column, toRow: tcc.row, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadPlayAreaCellsFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, isSpecialYN: Bool, oncomplete completionHandler:@escaping ([PlayAreaCellWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayAreaCellWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayAreaCellsToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()

		// Load data
		self.getPlayAreaCellModelAdministrator().select(byIsSpecialYN: isSpecialYN, relativeMemberID: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadPlayAreaCellsFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, gridScapeContainerViewControlManager: GridScapeContainerViewControlManager, oncomplete completionHandler:@escaping ([CellWrapperBase]?, Error?) -> Void) {
		
		// Create completion handler
		let loadTileDataCompletionHandler: (([PlayAreaTileDataWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Get cellWrappers by cellCoordRange
			let result: [CellWrapperBase] = gridScapeContainerViewControlManager.get(cellWrappers: cellCoordRange)
			
			gridScapeContainerViewControlManager.isGridScapeInitialLoadedYN = true
			
			// Call the completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let loadTilesCompletionHandler: (([PlayAreaTileWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (error == nil) {
				
				// Set tileWrappers
				gridScapeContainerViewControlManager.set(tileWrappers: items)
				
				// Load from cache
				self.loadPlayAreaTileDataFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, oncomplete: loadTileDataCompletionHandler)
				
			} else {
				
				// Call the completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Create completion handler
		let loadCellsCompletionHandler: (([PlayAreaCellWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (error == nil) {
				
				// Set cellWrappers
				gridScapeContainerViewControlManager.set(cellWrappers: items)
				
				// Load from cache
				self.loadPlayAreaTilesFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, oncomplete: loadTilesCompletionHandler)
				
			} else {
				
				// Call the completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		if (!gridScapeContainerViewControlManager.isGridScapeInitialLoadedYN) {
			
			// Load from cache
			self.loadPlayAreaCellsFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, isSpecialYN: nil, oncomplete: loadCellsCompletionHandler)
			
		} else {
			
			// Get cellWrappers by cellCoordRange
			let result: [CellWrapperBase] = gridScapeContainerViewControlManager.get(cellWrappers: cellCoordRange)
			
			// Call the completion handler
			completionHandler(result, nil)
			
		}
		
	}
	
	public func loadPlayAreaCellsFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, isSpecialYN: Bool?, oncomplete completionHandler:@escaping ([PlayAreaCellWrapper], Error?) -> Void) {
		
		// Create blank cellCoordRange
		let cellCoordRange: CellCoordRange = CellCoordRange(topLeft: CellCoord(), bottomRight: CellCoord())
		
		self.loadPlayAreaCellsFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, isSpecialYN: isSpecialYN, oncomplete: completionHandler)
		
	}
	
	public func loadPlayAreaCellsFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, isSpecialYN: Bool?, oncomplete completionHandler:@escaping ([PlayAreaCellWrapper], Error?) -> Void) {
		
		// Setup the cache
		PlayAreaCellsCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID)
		
		// Load from cache
		PlayAreaCellsCacheManager.shared.loadFromCache()
		
		// Set state
		self.setStateBeforeLoad()
		
		// Select items from the cache
		let cacheData: [Any] = PlayAreaCellsCacheManager.shared.select()
		
		// Put loaded data into the model administrator collection
		self.getPlayAreaCellModelAdministrator().load(data: cacheData)
		
		// Copy items to wrappers array
		let result: [PlayAreaCellWrapper] = self.loadedPlayAreaCellsToWrappers()
		
		// Check isSpecialYN
		// Nb: We can't do this here because the PlayAreaCellType is a relational item of PlayAreaCell and it can't be queried in the cache. So we have to load all cache items.
		
		// Set state
		self.setStateAfterLoad()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	public func loadedPlayAreaCellsToWrappers() -> [PlayAreaCellWrapper] {
		
		// Get the PlayAreaCellWrappers
		let result: [PlayAreaCellWrapper] = self.getPlayAreaCellModelAdministrator().toWrappers()
		
		return result
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadPlayAreaCellImageData(for wrapper: PlayAreaCellWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		let fileName: String	= wrapper.imageName
		
		guard (fileName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				wrapper.imageData = imageData
				
				if (!isCachedYN) {
					
					// Save to cache
					PlayAreaCellsCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: fileName)
				}
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayAreaCellImageData(fileName: fileName, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayAreaCellImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		var isCachedYN: 	Bool = false
		
		// Load application image
		let image: 		UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData == nil) {
			
			// Load image from cache
			imageData = PlayAreaCellsCacheManager.shared.loadImageFromCache(with: fileName)
			
			isCachedYN = (imageData != nil)
			
		}

		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayAreaTileTypes

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaTileTypeModelAdministrator() -> PlayAreaTileTypeModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaTileTypeModelAdministrator!
		
	}
	
	public func loadPlayAreaTileTypesFromDataSource(for playSubsetID: String, relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, oncomplete completionHandler:@escaping ([PlayAreaTileTypeWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayAreaTileTypeWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayAreaTileTypesToWrappers(appendYN: true)
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayAreaTileTypeModelAdministrator().select(byPlaySubsetID: playSubsetID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}
	
	public func loadedPlayAreaTileTypesToWrappers(appendYN: Bool) -> [PlayAreaTileTypeWrapper] {
		
		// Get the PlayAreaTileTypesWrappers
		let result: [PlayAreaTileTypeWrapper] = self.getPlayAreaTileTypeModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func getRandomPlayAreaTileTypeWrapper(urlRoot: String, oncomplete completionHandler:@escaping (PlayAreaTileTypeWrapper?, Error?) -> Void) {
		
		guard (PlayWrapper.current!.playAreaTileTypes!.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, NSError())
			
			return
			
		}
		
		var result: 			PlayAreaTileTypeWrapper? = nil
		
		// Create completion handler
		let loadPlayAreaTileTypeImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			guard (data != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Get playAreaCellTypes
		let playAreaTileTypes:	[String:PlayAreaTileTypeWrapper] = PlayWrapper.current!.playAreaTileTypes!
		
		guard (playAreaTileTypes.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, NSError())
			
			return
			
		}
		
		var ids: 				[String] = [String]()
		
		// Go through each item
		for pattw in playAreaTileTypes.values {
			
			// Add ids for deckWeighting
			for _ in 1...pattw.deckWeighting { ids.append(pattw.id) }
			
		}
		
		let numberofItems: 		Int = ids.count
		let randomIndex: 		Int = MathHelper.random(0..<numberofItems)
		let randomID:			String = ids[randomIndex]
		result 					= playAreaTileTypes[randomID]
	
		// Check imageData
		if (result!.imageData != nil) {
			
			// Call completion handler
			completionHandler(result, nil)
			
		} else {
			
			// Check imageName
			if (result!.imageName.count > 0) {
				
				// Load image
				self.loadPlayAreaTileTypeImageData(for: result!, urlRoot: urlRoot, oncomplete: loadPlayAreaTileTypeImageDataCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(result, nil)
				
			}
			
		}
		
	}
	
	public func loadPlayAreaTileTypeImageData(for wrapper: PlayAreaTileTypeWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		let fileName: String	= wrapper.imageName
		
		guard (fileName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				wrapper.imageData = imageData
				
				if (!isCachedYN) {
					
					// Save to cache
					PlayAreaTilesCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: fileName)
				}
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayAreaTileTypeImageData(fileName: fileName, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadPlayAreaTileTypeImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		var isCachedYN: 	Bool = false
		
		// Load application image
		let image: 		UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData == nil) {
			
			// Load image from cache
			imageData = PlayAreaTilesCacheManager.shared.loadImageFromCache(with: fileName)
			
			isCachedYN = (imageData != nil)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayAreaTiles

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaTileModelAdministrator() -> PlayAreaTileModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaTileModelAdministrator!
		
	}
	
	public func createPlayAreaTileWrapper(for playAreaTileTypeWrapper: PlayAreaTileTypeWrapper, urlRoot: String, oncomplete completionHandler:@escaping (PlayAreaTileWrapper?, Error?) -> Void) {
		
		let result: 						PlayAreaTileWrapper = PlayAreaTileWrapper()
		
		// Create completion handler
		let loadPlayAreaTileImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			guard (data != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Set in playAreaTileTypeWrapper
			playAreaTileTypeWrapper.imageData = result.imageData
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create PlayAreaTileDataWrapper
		let patdw: 					PlayAreaTileDataWrapper = PlayAreaTileDataWrapper()
		patdw.id 					= UUID().uuidString
		patdw.playAreaTileID 		= result.id
		
		// Set playAreaTileDataWrapper
		result.set(playAreaTileDataWrapper: patdw)
		
		result.tileTypeID			= playAreaTileTypeWrapper.id
		
		// Set tileTypeWrapper
		result.set(tileTypeWrapper: playAreaTileTypeWrapper)
		
		// Check imageData
		if (result.imageData != nil) {
			
			// Call completion handler
			completionHandler(result, nil)
			
		} else {
			
			// Check imageName
			if (result.imageName.count > 0) {
				
				// Load image
				self.loadPlayAreaTileImageData(for: result, urlRoot: urlRoot, oncomplete: loadPlayAreaTileImageDataCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(result, nil)
				
			}
			
		}
		
	}
	
	public func createPlayAreaTileWrapper(for playGameWrapper: PlayGameWrapper) -> PlayAreaTileWrapper {
		
		// Create PlayAreaTileWrapper
		let result: 				PlayAreaTileWrapper = PlayAreaTileWrapper()
		
		// Set properties
		result.relativeMemberID		= RelativeMemberWrapper.current!.id
		result.playGameID			= playGameWrapper.id
		
		// Create PlayAreaTileDataWrapper
		let patdw: 					PlayAreaTileDataWrapper = PlayAreaTileDataWrapper()
		patdw.id 					= UUID().uuidString
		patdw.playAreaTileID 		= result.id
		patdw.relativeMemberID		= result.relativeMemberID
		patdw.playGameID			= result.playGameID
		
		// Set playAreaTileDataWrapper
		result.set(playAreaTileDataWrapper: patdw)
		
		return result
		
	}
	
	public func loadPlayAreaTilesImages(items: [PlayAreaTileWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([PlayAreaTileWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var loadPlayAreaTileImageDataResultCount: Int = 0
		
		// Create completion handler
		let loadPlayAreaTileImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			loadPlayAreaTileImageDataResultCount += 1
			
			if (loadPlayAreaTileImageDataResultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlayAreaTileImageData(for: item, urlRoot: urlRoot, oncomplete: loadPlayAreaTileImageDataCompletionHandler)
			
		}
		
	}
	
	public func savePlayAreaTile(wrapper: PlayAreaTileWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get ModelAdministrator
		let patma: 		PlayAreaTileModelAdministrator = self.getPlayAreaTileModelAdministrator()
		
		patma.initialise()
		
		// Create PlayAreaTile model item
		let pat: 		PlayAreaTile = patma.collection!.getNewItem() as! PlayAreaTile
		pat.clone(fromWrapper: wrapper)
		pat.status 		= wrapper.status
		patma.collection!.addItem(item: pat)
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				#if DEBUG
					
					if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
						
						if (wrapper.status == .new) {
							
							pat.id = UUID().uuidString
							
						}
						
					}
					
					if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
						
						// Save to cache
						self.savePlayAreaTilesToCache(relativeMemberID: pat.relativeMemberID, playGameID: pat.playGameID, playAreaID: "1")
						
					}
					
				#endif
				
				// Update the wrapper
				wrapper.id 		= pat.id
				wrapper.status	= .unmodified
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		patma.save(oncomplete: saveCompletionHandler)
		
	}
	
	public func savePlayAreaTilesToCache(relativeMemberID: String, playGameID: String, playAreaID: String) {
		
		// Setup the cache
		PlayAreaTilesCacheManager.shared.set(relativeMemberID: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID)
		
		// Get the collection
		if let collection = self.getPlayAreaTileModelAdministrator().collection as? PlayAreaTileCollection {
			
			// Merge to cache
			PlayAreaTilesCacheManager.shared.mergeToCache(from: collection)
		}
		
		// Save to cache
		PlayAreaTilesCacheManager.shared.saveToCache()
		
	}
	
	public func loadPlayAreaTilesFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, oncomplete completionHandler:@escaping ([PlayAreaTileWrapper]?, Error?) -> Void) {
		
//		// Create completion handler
//		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
//		{
//			(data, error) -> Void in
//
//			var result: [PlayAreaTileWrapper]? = nil
//
//			if (data != nil && error == nil) {
//
//				// Copy items to wrappers array
//				result = self.loadedPlayAreaTilesToWrappers()
//			}
//
//			// Set state
//			self.setStateAfterLoad()
//
//			// Call completion handler
//			completionHandler(result, error)
//		}
//
//		// Set state
//		self.setStateBeforeLoad()
//
//		let fcc: 	CellCoord = cellCoordRange.topLeft
//		let tcc: 	CellCoord = cellCoordRange.bottomRight
		
		// TODO:
		
		// Load data
		//self.getPlayAreaTileModelAdministrator().select(byCellCoordRange: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID, fromColumn: fcc.column, fromRow: fcc.row, toColumn: tcc.column, toRow: tcc.row, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadPlayAreaTilesFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping ([PlayAreaTileWrapper], Error?) -> Void) {
		
		// Create blank cellCoordRange
		let cellCoordRange: CellCoordRange = CellCoordRange(topLeft: CellCoord(), bottomRight: CellCoord())
		
		self.loadPlayAreaTilesFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, oncomplete: completionHandler)
		
	}
	
	public func loadPlayAreaTilesFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, oncomplete completionHandler:@escaping ([PlayAreaTileWrapper], Error?) -> Void) {
		
		// Setup the cache
		PlayAreaTilesCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID)
		
		// Load from cache
		PlayAreaTilesCacheManager.shared.loadFromCache()
		
		// Set state
		self.setStateBeforeLoad()
		
		// Select items from the cache
		let cacheData: [Any] = PlayAreaTilesCacheManager.shared.select()
		
		// Put loaded data into the model administrator collection
		self.getPlayAreaTileModelAdministrator().load(data: cacheData)
		
		// Copy items to wrappers array
		let result: [PlayAreaTileWrapper] = self.loadedPlayAreaTilesToWrappers()

		// Set state
		self.setStateAfterLoad()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	public func loadedPlayAreaTilesToWrappers() -> [PlayAreaTileWrapper] {
		
		// Get the PlayAreaTileWrappers
		let result: [PlayAreaTileWrapper] = self.getPlayAreaTileModelAdministrator().toWrappers()
		
		return result
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadPlayAreaTileImageData(for wrapper: PlayAreaTileWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		let fileName: String	= wrapper.imageName
		
		guard (fileName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				wrapper.imageData = imageData
				
				if (!isCachedYN) {
					
					// Save to cache
					PlayAreaTilesCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: fileName)
				}
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayAreaTileImageData(fileName: fileName, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayAreaTileImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		var isCachedYN: 	Bool = false
		
		// Load application image
		let image: 		UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData == nil) {
			
			// Load image from cache
			imageData = PlayAreaTilesCacheManager.shared.loadImageFromCache(with: fileName)
			
			isCachedYN = (imageData != nil)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayAreaTileData

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaTileDataModelAdministrator() -> PlayAreaTileDataModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaTileDataModelAdministrator!
		
	}
	
	public func createPlayAreaTileDataWrapper(for playAreaTileWrapper: PlayAreaTileWrapper) -> PlayAreaTileDataWrapper {
		
		// Create PlayAreaTileDataWrapper
		let result: 				PlayAreaTileDataWrapper = PlayAreaTileDataWrapper()
		
		// Set properties
		result.relativeMemberID		= RelativeMemberWrapper.current!.id
		result.playGameID			= playAreaTileWrapper.playGameID
		result.playAreaTileID		= playAreaTileWrapper.id
		
		return result
		
	}
	
	public func savePlayAreaTileData(wrapper: PlayAreaTileDataWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get ModelAdministrator
		let patdma: 	PlayAreaTileDataModelAdministrator = self.getPlayAreaTileDataModelAdministrator()
		
		patdma.initialise()
		
		// Create PlayAreaTileData model item
		let patd: 		PlayAreaTileData = patdma.collection!.getNewItem() as! PlayAreaTileData
		patd.clone(fromWrapper: wrapper)
		patd.status 	= wrapper.status
		patdma.collection!.addItem(item: patd)
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				#if DEBUG
					
					if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
						
						if (wrapper.status == .new) {
							
							patd.id = UUID().uuidString
							
						}
						
					}
					
					if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
						
						// Save to cache
						self.savePlayAreaTileDataToCache(relativeMemberID: patd.relativeMemberID, playGameID: wrapper.playGameID, playAreaID: "1")
						
					}
					
				#endif
				
				// Update the wrapper
				wrapper.id 		= patd.id
				wrapper.status	= .unmodified
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		patdma.save(oncomplete: saveCompletionHandler)
		
	}
	
	public func savePlayAreaTileDataToCache(relativeMemberID: String, playGameID: String, playAreaID: String) {
		
		// Setup the cache
		PlayAreaTileDataCacheManager.shared.set(relativeMemberID: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID)
		
		// Get the collection
		if let collection = self.getPlayAreaTileDataModelAdministrator().collection as? PlayAreaTileDataCollection {
			
			// Merge to cache
			PlayAreaTileDataCacheManager.shared.mergeToCache(from: collection)
		}
		
		// Save to cache
		PlayAreaTileDataCacheManager.shared.saveToCache()
		
	}
	
	public func loadPlayAreaTileDataFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, oncomplete completionHandler:@escaping ([PlayAreaTileDataWrapper]?, Error?) -> Void) {
		
//		// Create completion handler
//		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
//		{
//			(data, error) -> Void in
//
//			var result: [PlayAreaTileDataWrapper]? = nil
//			
//			if (data != nil && error == nil) {
//
//				// Copy items to wrappers array
//				result = self.loadedPlayAreaTileDataToWrappers()
//			}
//
//			// Set state
//			self.setStateAfterLoad()
//
//			// Call completion handler
//			completionHandler(result, error)
//		}
//
//		// Set state
//		self.setStateBeforeLoad()
//
//		let fcc: 	CellCoord = cellCoordRange.topLeft
//		let tcc: 	CellCoord = cellCoordRange.bottomRight
//
		// TODO:
		
		// Load data
		//self.getPlayAreaTileDataModelAdministrator().select(byCellCoordRange: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID, fromColumn: fcc.column, fromRow: fcc.row, toColumn: tcc.column, toRow: tcc.row, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}
	
	public func loadPlayAreaTileDataFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping ([PlayAreaTileDataWrapper], Error?) -> Void) {
		
		// Create blank cellCoordRange
		let cellCoordRange: CellCoordRange = CellCoordRange(topLeft: CellCoord(), bottomRight: CellCoord())
		
		self.loadPlayAreaTileDataFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, oncomplete: completionHandler)
		
	}
	
	public func loadPlayAreaTileDataFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, oncomplete completionHandler:@escaping ([PlayAreaTileDataWrapper], Error?) -> Void) {
		
		// Setup the cache
		PlayAreaTileDataCacheManager.shared.set(relativeMemberID: relativeMemberWrapper.id, playGameID: playGameID, playAreaID: playAreaID)
		
		// Load from cache
		PlayAreaTileDataCacheManager.shared.loadFromCache()
		
		// Set state
		self.setStateBeforeLoad()
		
		// Select items from the cache
		let cacheData: [Any] = PlayAreaTileDataCacheManager.shared.select()
		
		// Put loaded data into the model administrator collection
		self.getPlayAreaTileDataModelAdministrator().load(data: cacheData)
		
		// Copy items to wrappers array
		let result: [PlayAreaTileDataWrapper] = self.loadedPlayAreaTileDataToWrappers()
		
		// Set state
		self.setStateAfterLoad()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	public func loadedPlayAreaTileDataToWrappers() -> [PlayAreaTileDataWrapper] {
		
		// Get the PlayAreaTileDataWrappers
		let result: [PlayAreaTileDataWrapper] = self.getPlayAreaTileDataModelAdministrator().toWrappers()
		
		return result
		
	}
	
}

// MARK: - Extension PlayAreaPaths

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaPathModelAdministrator() -> PlayAreaPathModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaPathModelAdministrator!
		
	}
	
	public func loadPlayAreaPathsFromDataSource(from fromCellCoord: CellCoord, to toCellCoord: CellCoord, playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, playGameID: String, oncomplete completionHandler:@escaping ([PlayAreaPathWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayAreaPathWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayAreaPathsToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayAreaPathModelAdministrator().select(byFromCellCoord: fromCellCoord, toCellCoord: toCellCoord, playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, playGameID: playGameID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadedPlayAreaPathsToWrappers() -> [PlayAreaPathWrapper] {
		
		// Get the PlayAreaPathWrappers
		let result: [PlayAreaPathWrapper] = self.getPlayAreaPathModelAdministrator().toWrappers()
		
		return result
		
	}

	public func loadPlayAreaPathsImages(items: [PlayAreaPathWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([PlayAreaPathWrapper], Error?) -> Void) {
		
		// Call completion handler
		completionHandler(items, nil)
		
		// Nb: Not required
		
	}
	
	
	// MARK: - Private Methods

}

// MARK: - Extension PlayAreaPathPoints

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayAreaPathPointModelAdministrator() -> PlayAreaPathPointModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayAreaPathPointModelAdministrator!
		
	}
	
	public func loadedPlayAreaPathPointsToWrappers() -> [PlayAreaPathPointWrapper] {
		
		// Get the PlayAreaPathPointWrappers
		let result: [PlayAreaPathPointWrapper] = self.getPlayAreaPathPointModelAdministrator().toWrappers()
		
		return result
		
	}
	
	
	// MARK: - Private Methods
	
}

// MARK: - Extension PlayMoves

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayMoveModelAdministrator() -> PlayMoveModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayMoveModelAdministrator!
		
	}
	
	public func loadPlayMovesFromDataSource(for playAreaTileWrapper: PlayAreaTileWrapper, oncomplete completionHandler:@escaping ([PlayMoveWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayMoveWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayMovesToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()

		// Load data
		self.getPlayMoveModelAdministrator().select(byPlayTileID: playAreaTileWrapper.id, playGameID: playAreaTileWrapper.playGameID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}
	
	public func loadPlayMovesFromDataSource(for playAreaTokenWrapper: PlayAreaTokenWrapper, oncomplete completionHandler:@escaping ([PlayMoveWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayMoveWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayMovesToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayMoveModelAdministrator().select(byPlayTokenID: playAreaTokenWrapper.id, playGameID: playAreaTokenWrapper.playGameID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}

	public func loadPlayMovesFromDataSource(for playAreaTokenWrapper: PlayAreaTokenWrapper, playAreaPathWrapper: PlayAreaPathWrapper, oncomplete completionHandler:@escaping ([PlayMoveWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayMoveWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayMovesToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayMoveModelAdministrator().select(byPlayTokenID: playAreaTokenWrapper.id, playGameID: playAreaTokenWrapper.playGameID, playAreaPathWrapper: playAreaPathWrapper, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}
	
	public func loadedPlayMovesToWrappers() -> [PlayMoveWrapper] {
		
		// Get the PlayMoveWrappers
		let result: [PlayMoveWrapper] = self.getPlayMoveModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func loadPlayMovesImages(items: [PlayMoveWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([PlayMoveWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var resultCount: Int = 0
		
		// Create completion handler
		let loadPlayMoveImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlayMoveImageData(for: item, urlRoot: urlRoot, oncomplete: loadPlayMoveImageDataCompletionHandler)
			
		}
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadPlayMoveImageData(for wrapper: PlayMoveWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get thumbnailImageName
		let thumbnailImageName: String = wrapper.playMoveContentData!.get(key: "\(PlayMoveContentDataKeys.ThumbnailImageName)") ?? ""
		
		guard (thumbnailImageName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				wrapper.thumbnailImageData = imageData
				
				if (!isCachedYN) {
					
					// Save to cache
					PlayGamesCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: thumbnailImageName)
				}
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayMoveImageData(fileName: thumbnailImageName, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayMoveImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		var isCachedYN: 	Bool = false
		
		// Load application image
		let image: 		UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData == nil) {
			
			// Load image from cache
			imageData = PlayGamesCacheManager.shared.loadImageFromCache(with: fileName)
			
			isCachedYN = (imageData != nil)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayExperiences

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayExperienceModelAdministrator() -> PlayExperienceModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayExperienceModelAdministrator!
		
	}
	
	public func loadPlayExperienceFromDataSource(for playMoveWrapper: PlayMoveWrapper, oncomplete completionHandler:@escaping ([PlayExperienceWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayExperienceWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayExperiencesToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayExperienceModelAdministrator().select(byPlayMoveID: playMoveWrapper.id, forPlayReferenceData: playMoveWrapper.playReferenceData, playSubsetID: playMoveWrapper.playSubsetID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}
	
	public func loadedPlayExperiencesToWrappers() -> [PlayExperienceWrapper] {
		
		// Get the PlayExperienceWrappers
		let result: [PlayExperienceWrapper] = self.getPlayExperienceModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func loadPlayExperienceImages(for wrapper: PlayExperienceWrapper, urlRoot: String, oncomplete completionHandler:@escaping (PlayExperienceWrapper, Error?) -> Void) {
		
		// Get ImageLoadWrappers
		let imageLoadWrappers: [ImageLoadWrapper] = self.getPlayExperienceImageLoadWrappers(for: wrapper)
		
		guard (imageLoadWrappers.count > 0) else {
			
			// Call completion handler
			completionHandler(wrapper, nil)
			
			return
			
		}
		
		// Create completion handler
		let loadPlayExperienceImagesCompletionHandler: (([ImageLoadWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(wrapper, error)
			
		}
		
		// Load images
		self.loadPlayExperienceImages(wrappers: imageLoadWrappers, urlRoot: urlRoot, oncomplete: loadPlayExperienceImagesCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func getPlayExperienceImageLoadWrappers(for wrapper: PlayExperienceWrapper)	-> [ImageLoadWrapper] {
		
		var result:					[ImageLoadWrapper] = [ImageLoadWrapper]()
		
		// Get ThumbnailImageName
		let thumbnailImageName: 	String? = wrapper.playExperienceContentData!.get(key: "\(PlayExperienceContentDataKeys.ThumbnailImageName)")
		
		if (thumbnailImageName != nil) {
			
			// Create ImageLoadWrapper
			let ilw: 				ImageLoadWrapper = ImageLoadWrapper()
			ilw.container 			= wrapper
			ilw.fileName 			= thumbnailImageName
			ilw.type 				= .PlayExperienceThumbnailImage
			
			// Add to list
			result.append(ilw)
			
		}
		
		var imageIndex: 			Int = 1
		var imageName: 				String? = nil
		
		// Go through each ImageName in PlayExperienceContentData
		repeat {
			
			// Get imageName
			imageName 				= wrapper.playExperienceContentData!.get(key: "\(PlayExperienceContentDataKeys.ImageName)_\(imageIndex)")
			
			if (imageName != nil) {
				
				// Create ImageLoadWrapper
				let ilw: 			ImageLoadWrapper = ImageLoadWrapper()
				ilw.container 		= wrapper
				ilw.fileName 		= imageName
				ilw.type 			= .PlayExperienceContentImage
				
				// Add to list
				result.append(ilw)
				
			}
			
			imageIndex += 1
			
		} while (imageName != nil);
		
		// Go through each item in playExperienceSteps
		for pesw in wrapper.playExperienceSteps().values {
			
			// Get ImageLoadWrappers
			let ilw: 			[ImageLoadWrapper] = self.getPlayExperienceStepImageLoadWrappers(for: pesw)
			
			result.append(contentsOf: ilw)
			
		}
		
		return result
		
	}
	
	fileprivate func loadPlayExperienceImages(wrappers: [ImageLoadWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([ImageLoadWrapper], Error?) -> Void) {
		
		guard (wrappers.count > 0) else {
			
			// Call completion handler
			completionHandler(wrappers, nil)
			
			return
			
		}
		
		let loadCount: 		Int = wrappers.count
		var resultCount: 	Int = 0
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= loadCount) {
				
				// Call completion handler
				completionHandler(wrappers, nil)
				
			}
			
		}
		
		// Go through each item
		for ilw in wrappers {
			
			switch ilw.type {
			case .PlayExperienceContentImage:

				// Load image data
				self.loadPlayExperienceContentImageData(for: ilw, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
				
			case .PlayExperienceThumbnailImage:

				// Load image data
				self.loadPlayExperienceThumbnailImageData(for: ilw, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
				
			case .PlayExperienceStepContentImage:

				// Load image data
				self.loadPlayExperienceStepContentImageData(for: ilw, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
				
			case .PlayExperienceStepThumbnailImage:

				// Load image data
				self.loadPlayExperienceStepThumbnailImageData(for: ilw, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
				
			case .PlayExperienceStepExerciseContentImage:

				// Load image data
				self.loadPlayExperienceStepExerciseContentImageData(for: ilw, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
				
			}
			
		}
		
	}

	fileprivate func loadPlayExperienceContentImageData(for imageLoadWrapper: ImageLoadWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get PlayExperienceWrapper
		let wrapper: PlayExperienceWrapper = imageLoadWrapper.container as! PlayExperienceWrapper
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				// Set in wrapper
				wrapper.set(key: imageLoadWrapper.fileName!, imageData: imageData)
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayExperienceContentImageData(fileName: imageLoadWrapper.fileName!, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayExperienceContentImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		let isCachedYN:		Bool = false
		
		// Load application image
		let image: 			UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}

	fileprivate func loadPlayExperienceThumbnailImageData(for imageLoadWrapper: ImageLoadWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get PlayExperienceWrapper
		let wrapper: PlayExperienceWrapper = imageLoadWrapper.container as! PlayExperienceWrapper
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				// Set in wrapper
				wrapper.thumbnailImageData = imageData

			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayExperienceThumbnailImageData(fileName: imageLoadWrapper.fileName!, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayExperienceThumbnailImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		let isCachedYN:		Bool = false
		
		// Load application image
		let image: 			UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}


// MARK: - Extension PlayExperienceSteps

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayExperienceStepModelAdministrator() -> PlayExperienceStepModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayExperienceStepModelAdministrator!
		
	}

	public func loadPlayExperienceStepFromDataSource(for playExperienceStepID: String, oncomplete completionHandler:@escaping ([PlayExperienceStepWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayExperienceStepWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayExperienceStepsToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayExperienceStepModelAdministrator().select(byID: playExperienceStepID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}
	
	public func loadedPlayExperienceStepsToWrappers() -> [PlayExperienceStepWrapper] {
		
		// Get the PlayExperienceStepWrappers
		let result: [PlayExperienceStepWrapper] = self.getPlayExperienceStepModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func loadPlayExperienceStepImages(for wrapper: PlayExperienceStepWrapper, urlRoot: String, oncomplete completionHandler:@escaping (PlayExperienceStepWrapper, Error?) -> Void) {
		
		// Get ImageLoadWrappers
		let imageLoadWrappers:	[ImageLoadWrapper] = self.getPlayExperienceStepImageLoadWrappers(for: wrapper)
		
		guard (imageLoadWrappers.count > 0) else {
			
			// Call completion handler
			completionHandler(wrapper, nil)
			
			return
			
		}
		
		// Create completion handler
		let loadPlayExperienceImagesCompletionHandler: (([ImageLoadWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(wrapper, error)
			
		}
		
		// Load images
		self.loadPlayExperienceImages(wrappers: imageLoadWrappers, urlRoot: urlRoot, oncomplete: loadPlayExperienceImagesCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods

	fileprivate func getPlayExperienceStepImageLoadWrappers(for wrapper: PlayExperienceStepWrapper)	-> [ImageLoadWrapper] {
		
		var result:					[ImageLoadWrapper] = [ImageLoadWrapper]()
		
		// Get ThumbnailImageName
		let thumbnailImageName: 	String? = wrapper.playExperienceStepContentData!.get(key: "\(PlayExperienceStepContentDataKeys.ThumbnailImageName)")
		
		if (thumbnailImageName != nil) {
			
			// Create ImageLoadWrapper
			let ilw: 				ImageLoadWrapper = ImageLoadWrapper()
			ilw.container 			= wrapper
			ilw.fileName 			= thumbnailImageName
			ilw.type 				= .PlayExperienceStepThumbnailImage
			
			// Add to list
			result.append(ilw)
			
		}
		
		var imageIndex: 			Int = 1
		var imageName: 				String? = nil

		// Go through each ImageName in PlayExperienceStepContentData
		repeat {
			
			// Get imageName
			imageName 				= wrapper.playExperienceStepContentData!.get(key: "\(PlayExperienceStepContentDataKeys.ImageName)_\(imageIndex)")
			
			if (imageName != nil) {
				
				// Create ImageLoadWrapper
				let ilw: 			ImageLoadWrapper = ImageLoadWrapper()
				ilw.container 		= wrapper
				ilw.fileName 		= imageName
				ilw.type 			= .PlayExperienceStepContentImage
				
				// Add to list
				result.append(ilw)
				
			}
			
			imageIndex += 1
			
		} while (imageName != nil);
		
		// Go through each item in playExperienceStepExercises
		for pesew in wrapper.playExperienceStepExercises().values {
			
			// Get ImageLoadWrappers
			let ilw: 				[ImageLoadWrapper] = self.getPlayExperienceStepExerciseImageLoadWrappers(for: pesew)
			
			result.append(contentsOf: ilw)
			
		}
		
		return result
		
	}
	
	fileprivate func loadPlayExperienceStepContentImageData(for imageLoadWrapper: ImageLoadWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get PlayExperienceStepWrapper
		let wrapper: PlayExperienceStepWrapper = imageLoadWrapper.container as! PlayExperienceStepWrapper
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				// Set in wrapper
				wrapper.set(key: imageLoadWrapper.fileName!, imageData: imageData)
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayExperienceStepContentImageData(fileName: imageLoadWrapper.fileName!, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}

	fileprivate func loadPlayExperienceStepContentImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		let isCachedYN:		Bool = false
		
		// Load application image
		let image: 			UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}

	fileprivate func loadPlayExperienceStepThumbnailImageData(for imageLoadWrapper: ImageLoadWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get PlayExperienceStepWrapper
		let wrapper: PlayExperienceStepWrapper = imageLoadWrapper.container as! PlayExperienceStepWrapper
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				// Set in wrapper
				wrapper.thumbnailImageData = imageData
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayExperienceStepThumbnailImageData(fileName: imageLoadWrapper.fileName!, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayExperienceStepThumbnailImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		let isCachedYN:		Bool = false
		
		// Load application image
		let image: 			UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayExperiencePlayExperienceStepLinks

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayExperiencePlayExperienceStepLinkModelAdministrator() -> PlayExperiencePlayExperienceStepLinkModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayExperiencePlayExperienceStepLinkModelAdministrator!
		
	}
	
}

// MARK: - Extension PlayExperienceStepExercises

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayExperienceStepExerciseModelAdministrator() -> PlayExperienceStepExerciseModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayExperienceStepExerciseModelAdministrator!
		
	}

	
	// MARK: - Private Methods
	
	fileprivate func getPlayExperienceStepExerciseImageLoadWrappers(for wrapper: PlayExperienceStepExerciseWrapper)	-> [ImageLoadWrapper] {
		
		var result:			[ImageLoadWrapper] = [ImageLoadWrapper]()

		// Go through each item
		for item in wrapper.modelItemAssetDataWrapper!.items {
			
			// Create ImageLoadWrapper
			let ilw: 		ImageLoadWrapper = ImageLoadWrapper()
			ilw.container 	= wrapper
			ilw.key			= item.key
			ilw.fileName 	= item.fileName!
			ilw.type 		= .PlayExperienceStepExerciseContentImage
			
			// Add to list
			result.append(ilw)
			
		}

		return result
		
	}
	
	fileprivate func loadPlayExperienceStepExerciseContentImageData(for imageLoadWrapper: ImageLoadWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get PlayExperienceStepExerciseWrapper
		let wrapper: 			PlayExperienceStepExerciseWrapper = imageLoadWrapper.container as! PlayExperienceStepExerciseWrapper
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				// Get ModelItemAssetDataItemWrapper
				let w: 			ModelItemAssetDataItemWrapper? = wrapper.modelItemAssetDataWrapper!.get(key: imageLoadWrapper.key!)
				
				// Set assetData
				w?.assetData 	= imageData

			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayExperienceStepExerciseContentImageData(fileName: imageLoadWrapper.fileName!, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayExperienceStepExerciseContentImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		let isCachedYN:		Bool = false
		
		// Load application image
		let image: 			UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData = ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayExperienceStepPlayExperienceStepExerciseLinks

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator() -> PlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator!
		
	}
	
}

// MARK: - Extension PlayChallenges

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayChallengeModelAdministrator() -> PlayChallengeModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayChallengeModelAdministrator!
		
	}

	public func savePlayChallenge(wrapper: PlayChallengeWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get ModelAdministrators
		let pcma: 		PlayChallengeModelAdministrator = self.getPlayChallengeModelAdministrator()
		let pcoma: 		PlayChallengeObjectiveModelAdministrator = self.getPlayChallengeObjectiveModelAdministrator()
		
		pcma.initialise()
		pcoma.initialise()
		
		guard (wrapper.playChallengeObjectives != nil) else {
			
			// Call completion handler
			completionHandler(NSError())
			
			return
			
		}
		
		// Create PlayChallenge model item
		let pc: 		PlayChallenge = pcma.collection!.getNewItem() as! PlayChallenge
		pc.clone(fromWrapper: wrapper)
		pc.status 		= wrapper.status
		pcma.collection!.addItem(item: pc)
		
		// Go through each item
		for pcow in wrapper.playChallengeObjectives!.values {
		
			// Create PlayChallengeObjective model item
			let pco: 		PlayChallengeObjective = pcoma.collection!.getNewItem() as! PlayChallengeObjective
			pco.status 		= wrapper.status	// Nb: Assume this is the same as PlayChallenge status
			pco.clone(fromWrapper: pcow)
			pcoma.collection!.addItem(item: pco)
			
		}
	
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				#if DEBUG
					
//					if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
//
//						// Save to cache
//						self.savePlayGamesToCache(relativeMemberID: RelativeMemberWrapper.current!.id)
//						self.savePlayGameDataToCache(relativeMemberID: RelativeMemberWrapper.current!.id)
//
//					}
					
				#endif
				
				// Update the wrapper
				wrapper.id 						= pc.id
				wrapper.status					= .unmodified
				
				// Go through each item
				for pcow in wrapper.playChallengeObjectives!.values {
					
					let previousID: 			String = pcow.id
					
					// Get PlayChallengeObjective
					let pco: 					PlayChallengeObjective? = pcoma.collection!.getItem(propertyKey: "PreviousID", value: previousID) as? PlayChallengeObjective
					
					if (pco != nil) {
						
						pcow.id 				= pco!.id
						pcow.playChallengeID 	= pc.id
						
						// Set in wrapper with new ID
						wrapper.remove(playChallengeObjectiveWrapper: previousID)
						wrapper.set(playChallengeObjectiveWrapper: pcow)
						
					}
					
				}
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Set insertRelationalItemsYN
		pcma.insertRelationalItemsYN = false
		
		pcma.save(oncomplete: saveCompletionHandler)
		
	}

	public func savePlayChallenges(wrappers: [PlayChallengeWrapper], oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		guard (wrappers.count > 0) else {
			
			// Call completion handler
			completionHandler(nil)
			
			return
			
		}
		
		var resultCount: Int = 0
		
		// Create completion handler
		let savePlayChallengeCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= wrappers.count) {
				
				// Call completion handler
				completionHandler(nil)
				
			}
			
		}
		
		// Go through each item
		for pcw in wrappers {
			
			// Save
			self.savePlayChallenge(wrapper: pcw, oncomplete: savePlayChallengeCompletionHandler)
			
		}
		
	}
	
	public func loadPlayChallengesFromDataSource(for playChallengeID: String, oncomplete completionHandler:@escaping ([PlayChallengeWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayChallengeWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayChallengesToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayChallengeModelAdministrator().select(byID: playChallengeID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)

	}
	
	public func loadPlayChallengesFromDataSource(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, isActiveYN: Bool, oncomplete completionHandler:@escaping ([PlayChallengeWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			var result: [PlayChallengeWrapper]? = nil
			
			if (data != nil && error == nil) {
				
				// Copy items to wrappers array
				result = self.loadedPlayChallengesToWrappers()
			}
			
			// Set state
			self.setStateAfterLoad()
			
			// Call completion handler
			completionHandler(result, error)
		}
		
		// Set state
		self.setStateBeforeLoad()
		
		// Load data
		self.getPlayChallengeModelAdministrator().select(byIsActiveYN: isActiveYN, relativeMemberID: relativeMemberWrapper.id, playGameID: playGameID, loadRelationalTablesYN: true, oncomplete: loadCompletionHandler)
		
	}
	
	public func loadedPlayChallengesToWrappers() -> [PlayChallengeWrapper] {
		
		// Get the PlayChallengeWrappers
		let result: [PlayChallengeWrapper] = self.getPlayChallengeModelAdministrator().toWrappers()
		
		return result
		
	}

	public func processLoadPlayChallengesRelationalDataImages(wrappers: [String:Any], urlRoot: String, oncomplete completionHandler:@escaping ([String:Any], Error?) -> Void) {
		
		// Get playChallengeTypeWrappers
		let playChallengeTypeWrappers: 				[PlayChallengeTypeWrapper]? = wrappers["PlayChallengeTypes"] as? [PlayChallengeTypeWrapper]
		
		// Get playChallengeObjectiveTypeWrappers
		let playChallengeObjectiveTypeWrappers: 	[PlayChallengeObjectiveTypeWrapper]? = wrappers["PlayChallengeObjectiveTypes"] as? [PlayChallengeObjectiveTypeWrapper]
		
		// Create completion handler
		let loadPlayChallengeObjectiveTypesImagesCompletionHandler: (([PlayChallengeObjectiveTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(wrappers, error)
			
		}
		
		// Create completion handler
		let loadPlayChallengeTypesImagesCompletionHandler: (([PlayChallengeTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			guard (error == nil) else {
				
				// Call completion handler
				completionHandler(wrappers, error)
				return
				
			}
			
			// Load images
			self.loadPlayChallengeObjectiveTypesImages(items: playChallengeObjectiveTypeWrappers!, urlRoot: urlRoot, oncomplete: loadPlayChallengeObjectiveTypesImagesCompletionHandler)
			
		}
		
		// Load images
		self.loadPlayChallengeTypesImages(items: playChallengeTypeWrappers!, urlRoot: urlRoot, oncomplete: loadPlayChallengeTypesImagesCompletionHandler)

	}
	
}

// MARK: - Extension PlayChallengeTypes

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayChallengeTypeModelAdministrator() -> PlayChallengeTypeModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayChallengeTypeModelAdministrator!
		
	}

	public func loadedPlayChallengeTypesToWrappers() -> [PlayChallengeTypeWrapper] {
		
		// Get the PlayChallengeTypeWrappers
		let result: [PlayChallengeTypeWrapper] = self.getPlayChallengeTypeModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func loadPlayChallengeTypesImages(items: [PlayChallengeTypeWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([PlayChallengeTypeWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var resultCount: Int = 0
		
		// Create completion handler
		let loadPlayChallengeTypeImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlayChallengeTypeImageData(for: item, urlRoot: urlRoot, oncomplete: loadPlayChallengeTypeImageDataCompletionHandler)
			
		}
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadPlayChallengeTypeImageData(for wrapper: PlayChallengeTypeWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get thumbnailImageName
		let thumbnailImageName: 	String = wrapper.playChallengeTypeContentData!.get(key: "\(PlayChallengeTypeContentDataKeys.ThumbnailImageName)") ?? ""
		
		guard (thumbnailImageName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				wrapper.thumbnailImageData = imageData
				
				if (!isCachedYN) {
					
					// Save to cache
					PlayGamesCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: thumbnailImageName)
				}
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayChallengeTypeImageData(fileName: thumbnailImageName, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayChallengeTypeImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		var isCachedYN: 	Bool = false
		
		// Load application image
		let image: 			UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData 		= ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData == nil) {
			
			// Load image from cache
			imageData 		= PlayGamesCacheManager.shared.loadImageFromCache(with: fileName)
			
			isCachedYN 		= (imageData != nil)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}

// MARK: - Extension PlayChallengeObjectives

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayChallengeObjectiveModelAdministrator() -> PlayChallengeObjectiveModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayChallengeObjectiveModelAdministrator!
		
	}
	
	public func loadedPlayChallengeObjectivesToWrappers() -> [PlayChallengeObjectiveWrapper] {
		
		// Get the PlayChallengeObjectiveWrappers
		let result: [PlayChallengeObjectiveWrapper] = self.getPlayChallengeObjectiveModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func savePlayChallengeObjective(wrapper: PlayChallengeObjectiveWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Get ModelAdministrator
		let pcoma: 					PlayChallengeObjectiveModelAdministrator = self.getPlayChallengeObjectiveModelAdministrator()
		
		pcoma.initialise()
		
		// Create PlayChallengeObjective model item
		let pco: 					PlayChallengeObjective = pcoma.collection!.getNewItem() as! PlayChallengeObjective
		pco.clone(fromWrapper: wrapper)
		pco.status 					= wrapper.status
		pcoma.collection!.addItem(item: pco)

		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {

				// Update the wrapper
				wrapper.id 			= pco.id
				wrapper.status		= .unmodified
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		pcoma.save(oncomplete: saveCompletionHandler)
		
	}
			
	public func savePlayChallengeObjectives(wrappers: [PlayChallengeObjectiveWrapper], oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		guard (wrappers.count > 0) else {
			
			// Call completion handler
			completionHandler(nil)
			
			return
			
		}
		
		var resultCount: Int = 0
		
		// Create completion handler
		let savePlayChallengeObjectiveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= wrappers.count) {
				
				// Call completion handler
				completionHandler(nil)
				
			}
			
		}
		
		// Go through each item
		for pcow in wrappers {
			
			// Save
			self.savePlayChallengeObjective(wrapper: pcow, oncomplete: savePlayChallengeObjectiveCompletionHandler)
			
		}
		
	}

}

// MARK: - Extension PlayChallengeObjectiveTypes

extension ControlManagerBase {
	
	// MARK: - Public Methods
	
	public func getPlayChallengeObjectiveTypeModelAdministrator() -> PlayChallengeObjectiveTypeModelAdministrator {
		
		return (self.modelManager! as! ModelManager).getPlayChallengeObjectiveTypeModelAdministrator!
		
	}
	
	public func loadedPlayChallengeObjectiveTypesToWrappers() -> [PlayChallengeObjectiveTypeWrapper] {
		
		// Get the PlayChallengeObjectiveTypeWrappers
		let result: [PlayChallengeObjectiveTypeWrapper] = self.getPlayChallengeObjectiveTypeModelAdministrator().toWrappers()
		
		return result
		
	}
	
	public func loadPlayChallengeObjectiveTypesImages(items: [PlayChallengeObjectiveTypeWrapper], urlRoot: String, oncomplete completionHandler:@escaping ([PlayChallengeObjectiveTypeWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var resultCount: Int = 0
		
		// Create completion handler
		let loadPlayChallengeObjectiveTypeImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			resultCount += 1
			
			if (resultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlayChallengeObjectiveTypeImageData(for: item, urlRoot: urlRoot, oncomplete: loadPlayChallengeObjectiveTypeImageDataCompletionHandler)
			
		}
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadPlayChallengeObjectiveTypeImageData(for wrapper: PlayChallengeObjectiveTypeWrapper, urlRoot: String, oncomplete completionHandler:@escaping (Data?, Error?) -> Void) {
		
		// Get thumbnailImageName
		let thumbnailImageName: 	String = wrapper.playChallengeObjectiveTypeContentData!.get(key: "\(PlayChallengeObjectiveTypeContentDataKeys.ThumbnailImageName)") ?? ""
		
		guard (thumbnailImageName.count > 0) else {
			
			// Call completion handler
			completionHandler(nil, nil)
			return
			
		}
		
		// Create completion handler
		let loadImageDataCompletionHandler: ((Bool, Data?) -> Void) =
		{
			(isCachedYN, imageData) -> Void in
			
			if (imageData != nil && UIImage(data: imageData!) != nil) {
				
				wrapper.thumbnailImageData = imageData
				
				if (!isCachedYN) {
					
					// Save to cache
					PlayGamesCacheManager.shared.saveImageToCache(imageData: imageData!, fileName: thumbnailImageName)
				}
				
			} else {
				// Error
			}
			
			// Call completion handler
			completionHandler(imageData, nil)
			
		}
		
		// Load image data
		self.loadPlayChallengeObjectiveTypeImageData(fileName: thumbnailImageName, urlRoot: urlRoot, oncomplete: loadImageDataCompletionHandler)
		
	}
	
	fileprivate func loadPlayChallengeObjectiveTypeImageData(fileName: String, urlRoot: String, oncomplete completionHandler:@escaping (Bool, Data?) -> Void) {
		
		var imageData: 		Data? = nil
		var isCachedYN: 	Bool = false
		
		// Load application image
		let image: 			UIImage? = UIImage(named: fileName)
		
		if (image != nil) {
			
			imageData 		= ImageHelper.toPNGData(image: image!)
			
		}
		
		if (imageData == nil) {
			
			// Load image from cache
			imageData 		= PlayGamesCacheManager.shared.loadImageFromCache(with: fileName)
			
			isCachedYN 		= (imageData != nil)
			
		}
		
		if (imageData != nil) {
			
			// Call completion handler
			completionHandler(isCachedYN, imageData)
			
		} else {
			
			// Check is connected
			if (self.checkIsConnected()) {
				
				// Load image from URL
				HTTPHelper.loadImageDataFromUrl(fileName: fileName, urlRoot: urlRoot, oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(isCachedYN, nil)
				
			}
			
		}
		
	}
	
}
