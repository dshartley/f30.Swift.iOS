//
//  PlayGamesCacheManager.swift
//  f30Controller
//
//  Created by David on 09/12/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import f30Model

/// Manages cacheing for PlayGames model data
public class PlayGamesCacheManager: CacheManagerBase {

	// MARK: - Private Static Properties
	
	fileprivate static var singleton:				PlayGamesCacheManager?
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var relativeMemberID:	String? = ""
	
	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
		
		self.entityName = "PlayGames"
	}
	
	
	// MARK: - Public Class Computed Properties
	
	public class var shared: PlayGamesCacheManager {
		get {
			
			if (PlayGamesCacheManager.singleton == nil) {
				PlayGamesCacheManager.singleton = PlayGamesCacheManager()
			}
			
			return PlayGamesCacheManager.singleton!
		}
	}
	
	
	// MARK: - Public Methods
	
	public func set(relativeMemberID: String) {
		
		self.relativeMemberID 	= relativeMemberID

		// Set predicate
		self.predicate 			= NSPredicate(format: "relativeMemberID == %@", argumentArray: [relativeMemberID])
		
	}
	
	public func select(byID: String) -> [Any] {
		
		var result: [Any] = [Any]()
		
		guard (self.collection != nil) else { return result }
		
		var itemFoundIndex: Int		= 0
		var isFoundYN:		Bool	= false
		
		var item:			PlayGame?	= nil
		var itemData: 		Any? = nil
		
		// Go through each item until isFoundYN
		while (!isFoundYN && itemFoundIndex <= self.collection!.items!.count - 1) {
			
			item = (self.collection!.items![itemFoundIndex] as! PlayGame)
			
			// Check item id
			if (item!.id == byID) {
				
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
	
	public func select(byRelativeMemberID: String, loadLatestOnlyYN: Bool) -> [Any] {
		
		var result: [Any] = [Any]()
		
		guard (self.collection != nil) else { return result }
		
//		var itemFoundIndex: Int		= 0
//		var isFoundYN:		Bool	= false
//
		var item:			PlayGame?	= nil
		var itemData: 		Any? = nil
		
		// Get first item
		item = self.collection!.items!.first as? PlayGame
		
		guard (item != nil) else {
			
			return result
			
		}
		
		// Get itemData
		itemData = item!.dataNode!
		
		// Append to data
		result.append(itemData!)

		// TODO: Get by latest
//		// Go through each item until isFoundYN
//		while (!isFoundYN && itemFoundIndex <= self.collection!.items!.count - 1) {
//
//			item = (self.collection!.items![itemFoundIndex] as! PlayGame)
//
//			// Check item id
//			if (item!.lastActiveDate > activeDate) {
//
//				isFoundYN = true
//
//				// Get itemData
//				itemData = item!.dataNode!
//
//				// Append to data
//				result.append(itemData!)
//
//			} else {
//
//				itemFoundIndex += 1
//			}
//
//		}
		
		return result
		
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseCacheData() {
		
		self.collection	= PlayGameCollection()
		
	}
	
	public override func setAttributes(cacheData: NSManagedObject) {
		
		// Set relativeMemberID
		cacheData.setValue(self.relativeMemberID, forKeyPath: "relativeMemberID")
		
	}
	
}
