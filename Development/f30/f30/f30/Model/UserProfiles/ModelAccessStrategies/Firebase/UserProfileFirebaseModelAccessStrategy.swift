//
//  UserProfileFirebaseModelAccessStrategy.swift
//  f30
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSocial
import f30Model
import FirebaseDatabase
import FirebaseStorage

/// Specifies query parameter keys
fileprivate enum QueryParameterKeys : Int {
	case userpropertiesid
	case email
	case applicationid
}

/// A strategy for accessing the UserProfile model data using Firebase
public class UserProfileFirebaseModelAccessStrategy: FirebaseModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "userProfiles")

		self.databaseReference = Database.database().reference(withPath: self.tableName)
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(selectByUserPropertiesID userPropertiesID: String, applicationID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Call Firebase query
		self.databaseReference!
			.queryOrdered(byChild: "\(QueryParameterKeys.userpropertiesid)")
			.queryEqual(toValue: userPropertiesID)
			.observeSingleEvent(of: .value, with:
		{
			(snapshot) in
			
			self.databaseReference!.removeAllObservers()
			
			let d: 			[Any] = self.toData(from: snapshot, usingTemplate: collection)
			
			// Filter by applicationID
			let result: 	[Any] = self.filter(data: d, byApplicationID: applicationID)
			
			// Process the snapshot to data
			let data: [String:Any] = [self.tableName:result]
				
			// Call completion handler
			completionHandler(data, nil)
			
		}, withCancel:
		{
			(error) in
			
			// Call completion handler
			completionHandler(nil, error)
			
		})

	}

	fileprivate func runQuery(selectByEmail email: String, applicationID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Call Firebase query
		self.databaseReference!
			.queryOrdered(byChild: "\(QueryParameterKeys.email)")
			.queryEqual(toValue: email)
			.observeSingleEvent(of: .value, with:
			{
				(snapshot) in
				
				self.databaseReference!.removeAllObservers()
				
				let d: 			[Any] = self.toData(from: snapshot, usingTemplate: collection)
				
				// Filter by applicationID
				let result: 	[Any] = self.filter(data: d, byApplicationID: applicationID)
				
				// Process the snapshot to data
				let data: [String:Any] = [self.tableName:result]
				
				// Call completion handler
				completionHandler(data, nil)
				
		})
		
	}
	
	fileprivate func filter(data: [Any], byApplicationID applicationID: String) -> [Any] {
		
		var result: [Any] = [Any]()
		
		// Go through each item
		for item in data {
			
			if let item = item as? [String:Any] {
				
				// Get applicationID
				let itemApplicationID: String = item["\(QueryParameterKeys.applicationid)"] as? String ?? ""
				
				if (itemApplicationID == applicationID) {
					
					result.append(item)
				}
				
			}
			
		}
		
		return result
		
	}
	
}

// MARK: - Extension ProtocolUserProfileModelAccessStrategy

extension UserProfileFirebaseModelAccessStrategy: ProtocolUserProfileModelAccessStrategy {

	// MARK: - Public Methods

	public func select(byUserPropertiesID userPropertiesID: String, applicationID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {

		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)

		// Run the query
		self.runQuery(selectByUserPropertiesID: userPropertiesID, applicationID: applicationID, into: collection, oncomplete: runQueryCompletionHandler)
		
	}

	public func select(byEmail email: String, applicationID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(selectByEmail: email, applicationID: applicationID, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func saveAvatarImage(item: UserProfile, oncomplete completionHandler: @escaping (Error?) -> Void) {
		
		guard (!item.avatarImageFileName.isEmpty
				&& item.avatarImageData != nil) else {
			
			// Call completion handler
			completionHandler(NSError())
			
			return
		}
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
				
				// Call completion handler
				completionHandler(nil)
				
				return
				
			}
			
		#endif
		
		let fileName: 			String = item.avatarImageFileName
		
		// Create reference
		let storageReference 	= Storage.storage().reference().child(fileName)

		storageReference.putData(item.avatarImageData!, metadata: nil)
		{
			(metadata, error) in
			
			if (error == nil) {

				// Call the completion handler
				completionHandler(nil)
				
			} else {
		
				// Call the completion handler
				completionHandler(error)
				
			}

		}
		
	}
	
	public func loadAvatarImage(item: UserProfile, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		guard (!item.avatarImageFileName.isEmpty) else {
			
			// Call completion handler
			completionHandler(NSError())
			
			return
		}
		
		let fileName: 			String = item.avatarImageFileName
		
		// Create reference
		let storageReference 	= Storage.storage().reference().child(fileName)
		
		let maxSize: 			Int64 = 1 * 1024 * 1024 	// 1MB (1 * 1024 * 1024 bytes)
		
		storageReference.getData(maxSize: maxSize)
		{
			(data, error) in
			
			if (data != nil && error == nil) {
				
				item.avatarImageData = data
				
				// Call the completion handler
				completionHandler(nil)
				
			} else {
				
				// Call the completion handler
				completionHandler(error)
				
			}
		}
		
	}

	public func removeAvatarImage(item: UserProfile, oncomplete completionHandler: ((Error?) -> Void)?) {
		
		guard (!item.avatarImageFileName.isEmpty) else {
			
			// Call completion handler
			completionHandler?(NSError())
			
			return
		}
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
				
				// Call completion handler
				completionHandler?(nil)
				
				return
				
			}
			
		#endif
		
		let fileName: 			String = item.avatarImageFileName
		
		// Create reference
		let storageReference 	= Storage.storage().reference().child(fileName)
		
		storageReference.delete()
		{
			(error) in
			
			if (error == nil) {
				
				// Call the completion handler
				completionHandler?(nil)
				
			} else {
				
				// Call the completion handler
				completionHandler?(error)
				
			}
			
		}
		
	}
	
}

