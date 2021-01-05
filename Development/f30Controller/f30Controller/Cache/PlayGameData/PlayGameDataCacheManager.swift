//
//  PlayGameDataCacheManager.swift
//  f30Controller
//
//  Created by David on 09/12/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import f30Model

/// Manages cacheing for PlayGameData model data
public class PlayGameDataCacheManager: CacheManagerBase {

	// MARK: - Private Static Properties
	
	fileprivate static var singleton:				PlayGameDataCacheManager?
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var relativeMemberID:	String? = ""

	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
		
		self.entityName = "PlayGameDataCache"
	}
	
	
	// MARK: - Public Class Computed Properties
	
	public class var shared: PlayGameDataCacheManager {
		get {
			
			if (PlayGameDataCacheManager.singleton == nil) {
				PlayGameDataCacheManager.singleton = PlayGameDataCacheManager()
			}
			
			return PlayGameDataCacheManager.singleton!
		}
	}
	
	
	// MARK: - Public Methods

	public func set(relativeMemberID: String) {

		self.relativeMemberID 	= relativeMemberID

		// Set predicate
		self.predicate 			= NSPredicate(format: "relativeMemberID == %@", argumentArray: [relativeMemberID])

	}
	
	public func select(byPlayGameID: String) -> [Any] {
		
		var result: [Any] = [Any]()
		
		guard (self.collection != nil) else { return result }
		
		var itemFoundIndex: Int = 0
		var isFoundYN:		Bool = false
		
		var item:			PlayGameData? = nil
		var itemData: 		Any? = nil
		
		// Go through each item until isFoundYN
		while (!isFoundYN && itemFoundIndex <= self.collection!.items!.count - 1) {
			
			item = (self.collection!.items![itemFoundIndex] as! PlayGameData)
			
			// Check item playGameID
			if (item!.playGameID == byPlayGameID) {
				
				isFoundYN = true
				
				// Get itemData
				itemData = item!.dataNode!
				
				// Append to data
				result.append(itemData!)
				
			} else {
				
				itemFoundIndex += 1
			}
			
		}
		
		return result
		
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseCacheData() {
		
		self.collection	= PlayGameDataCollection()
		
	}
	
	public override func setAttributes(cacheData: NSManagedObject) {
		
		// Set relativeMemberID
		cacheData.setValue(self.relativeMemberID, forKeyPath: "relativeMemberID")

	}
	
}
