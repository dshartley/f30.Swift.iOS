//
//  RelativeMembersCacheManager.swift
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

/// Manages cacheing for RelativeMembers model data
public class RelativeMembersCacheManager: CacheManagerBase {
	
	// MARK: - Private Static Properties
	
	fileprivate static var singleton:				RelativeMembersCacheManager?
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var userProfileID:		String? = ""

	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
		
		self.entityName = "RelativeMembers"
	}
	
	
	// MARK: - Public Class Computed Properties
	
	public class var shared: RelativeMembersCacheManager {
		get {
			
			if (RelativeMembersCacheManager.singleton == nil) {
				RelativeMembersCacheManager.singleton = RelativeMembersCacheManager()
			}
			
			return RelativeMembersCacheManager.singleton!
		}
	}
	
	
	// MARK: - Public Methods
	
	public func set(userProfileID: String) {
		
		self.userProfileID = userProfileID
		
		// Set predicate
		self.predicate = NSPredicate(format: "userProfileID == %@", argumentArray: [userProfileID])
		
	}
	
	public func mergeToCache(from item: RelativeMemberWrapper) {

		let collection: 		RelativeMemberCollection = RelativeMemberCollection()
		
		// Create a RelativeMember model item
		let relativeMember: 	RelativeMember = collection.getNewItem() as! RelativeMember
		
		// Copy from wrapper
		relativeMember.clone(fromWrapper: item)

		super.mergeToCache(from: relativeMember)

	}
	
	public func getWrapper() -> RelativeMemberWrapper? {
	
		// Copy item to wrapper
		var result: RelativeMemberWrapper? = nil
		
		if (self.collection != nil && self.collection!.items!.count > 0) {
			
			result = (self.collection!.items!.first as! RelativeMember).toWrapper()
			
		}
		
		return result
		
	}
	
	
	// MARK: - Override Methods
	
	public override func clear() {
		
		super.clear()
		
		self.userProfileID = nil
		
	}
	
	public override func initialiseCacheData() {
		
		self.collection	= RelativeMemberCollection()
		
	}
	
	public override func setAttributes(cacheData: NSManagedObject) {
		
		// Set userProfileID
		cacheData.setValue(self.userProfileID, forKeyPath: "userProfileID")
		
	}
	
}
