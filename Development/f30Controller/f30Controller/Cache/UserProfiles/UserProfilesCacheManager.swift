//
//  UserProfilesCacheManager.swift
//  f30Controller
//
//  Created by David on 16/03/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import SFSocial
import f30Core
import f30Model

/// Manages cacheing for UserProfiles model data
public class UserProfilesCacheManager: CacheManagerBase {
	
	// MARK: - Private Static Properties
	
	fileprivate static var singleton:				UserProfilesCacheManager?
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var userPropertiesID:	String? = nil
	
	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
		
		self.entityName = "UserProfiles"
	}
	
	
	// MARK: - Public Class Computed Properties
	
	public class var shared: UserProfilesCacheManager {
		get {
			
			if (UserProfilesCacheManager.singleton == nil) {
				UserProfilesCacheManager.singleton = UserProfilesCacheManager()
			}
			
			return UserProfilesCacheManager.singleton!
		}
	}
	
	
	// MARK: - Public Methods
	
	public func set(userPropertiesID: String) {
		
		self.userPropertiesID = userPropertiesID
		
		// Set predicate
		self.predicate = NSPredicate(format: "userPropertiesID == %@", argumentArray: [userPropertiesID])
		
	}
	
	
	// MARK: - Override Methods
	
	public override func clear() {
		
		super.clear()
		
		self.userPropertiesID = nil
		
	}
	
	public override func initialiseCacheData() {
		
		self.collection	= UserProfileCollection()
		
	}
	
	public override func setAttributes(cacheData: NSManagedObject) {
		
		// Set userProfileID
		cacheData.setValue(self.userPropertiesID, forKeyPath: "userPropertiesID")
		
	}
	
}

