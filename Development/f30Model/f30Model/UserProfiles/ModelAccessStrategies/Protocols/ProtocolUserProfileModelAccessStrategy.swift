//
//  ProtocolUserProfileModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFModel

/// Defines a class which provides a strategy for accessing the UserProfile model data
public protocol ProtocolUserProfileModelAccessStrategy {
	
	// MARK: - Methods
	
	func select(byUserPropertiesID userPropertiesID: String, applicationID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)

	func select(byEmail email: String, applicationID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
	func saveAvatarImage(item: UserProfile, oncomplete completionHandler:@escaping (Error?) -> Void)

	func loadAvatarImage(item: UserProfile, oncomplete completionHandler:@escaping (Error?) -> Void)
	
	func removeAvatarImage(item: UserProfile, oncomplete completionHandler: ((Error?) -> Void)?)
	
}
