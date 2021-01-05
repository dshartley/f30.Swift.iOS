//
//  UserProfileModelAdministrator.swift
//  f30Model
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Manages UserProfile data
public class UserProfileModelAdministrator: ModelAdministratorBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(modelAccessStrategy:			ProtocolModelAccessStrategy,
	                     modelAdministratorProvider:	ProtocolModelAdministratorProvider,
						 storageDateFormatter:			DateFormatter) {
		super.init(modelAccessStrategy: modelAccessStrategy,
				   modelAdministratorProvider: modelAdministratorProvider,
				   storageDateFormatter: storageDateFormatter)
	}

	
	// MARK: - Public Methods
	
	public func select(byUserPropertiesID userPropertiesID: String, applicationID: String, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
		self.setupCollection()
		
		// Create completion handler
		let selectCompletionHandler: (([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) =
		{
			(data, collection, error) -> Void in
			
			self.doAfterLoad()
			
			// Call the completion handler
			completionHandler(self.collection!.dataDocument, error)
		}
		
		// Load the data
		(self.modelAccessStrategy as! ProtocolUserProfileModelAccessStrategy).select(byUserPropertiesID: userPropertiesID, applicationID: applicationID, collection: self.collection!, oncomplete: selectCompletionHandler)
	}

	public func select(byEmail email: String, applicationID: String, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
		self.setupCollection()
		
		// Create completion handler
		let selectCompletionHandler: (([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) =
		{
			(data, collection, error) -> Void in
			
			self.doAfterLoad()
			
			// Call the completion handler
			completionHandler(self.collection!.dataDocument, error)
		}
		
		// Load the data
		(self.modelAccessStrategy as! ProtocolUserProfileModelAccessStrategy).select(byEmail: email, applicationID: applicationID, collection: self.collection!, oncomplete: selectCompletionHandler)
	}
	
	public func saveAvatarImage(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		guard (self.collection != nil) else {
			
			// Call completion handler
			completionHandler(NSError())
			return
			
		}
		
		// Go through each item
		for item in self.collection!.items! {
			
			let item = item as! UserProfile
			
			var counter: 		Int = self.collection!.items!.count
			var latestError: 	Error? = nil
			
			// Create completion handler
			let loadCompletionHandler: ((Error?) -> Void) =
			{
				(error) -> Void in
				
				// Set latestError if error
				if (error != nil) { latestError = error }
				
				// Set counter
				counter -= 1
				
				// Check last item loaded
				if (counter <= 0) {
					
					// Call completion handler
					completionHandler(latestError)
					
				}
			}
			
			// Check avatarImageFileName and avatarImageData is set
			if (!item.avatarImageFileName.isEmpty
				&& item.avatarImageData != nil) {
				
				// Save the avatar image
				(self.modelAccessStrategy as! ProtocolUserProfileModelAccessStrategy).saveAvatarImage(item: item, oncomplete: loadCompletionHandler)
				
			}

		}

	}
	
	public func loadAvatarImage(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		guard (self.collection != nil) else {
			
			// Call completion handler
			completionHandler(NSError())
			return
			
		}
		
		// Go through each item
		for item in self.collection!.items! {
			
			let item = item as! UserProfile
			
			var counter: 		Int = self.collection!.items!.count
			var latestError: 	Error? = nil
			
			// Create completion handler
			let loadCompletionHandler: ((Error?) -> Void) =
			{
				(error) -> Void in
				
				// Set latestError if error
				if (error != nil) { latestError = error }
				
				// Set counter
				counter -= 1
				
				// Check last item loaded
				if (counter <= 0) {
					
					// Call completion handler
					completionHandler(latestError)
					
				}
			}
			
			// Check avatarImageFileName is set
			if (!item.avatarImageFileName.isEmpty) {
				
				// Load the avatar image
				(self.modelAccessStrategy as! ProtocolUserProfileModelAccessStrategy).loadAvatarImage(item: item, oncomplete: loadCompletionHandler)
				
			}

		}
		
	}
	
	public func removeAvatarImage(oncomplete completionHandler: ((Error?) -> Void)?) {
		
		guard (self.collection != nil) else {
			
			// Call completion handler
			completionHandler?(NSError())
			return
			
		}
		
		// Go through each item
		for item in self.collection!.items! {
			
			let item = item as! UserProfile
			
			// Create completion handler
			let removeCompletionHandler: ((Error?) -> Void)? =
			{
				(error) -> Void in
			}
			
			// Check avatarImageFileName is set
			if (!item.avatarImageFileName.isEmpty) {
				
				// Remove the avatar image
				(self.modelAccessStrategy as! ProtocolUserProfileModelAccessStrategy).removeAvatarImage(item: item, oncomplete: removeCompletionHandler)
				
			}
			
		}
		
		// Call completion handler
		completionHandler?(nil)
	}
	
	public func toWrappers() -> [UserProfileWrapper] {
		
		var result:             [UserProfileWrapper] = [UserProfileWrapper]()
		
		if let collection = self.collection {
			
			let collection:     UserProfileCollection = collection as! UserProfileCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: UserProfileWrapper = (item as! UserProfile).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return UserProfileCollection(modelAdministrator: self,
									 storageDateFormatter: self.storageDateFormatter!)
	}
	
	public override func setupForeignKeys() {
		
		// No foreign keys
	}
	
	
	// MARK: - Private Methods
	
}
