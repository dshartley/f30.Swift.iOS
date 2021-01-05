//
//  PlayAreaTilesCacheManager.swift
//  f30Controller
//
//  Created by David on 09/12/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import f30Model

/// Manages cacheing for PlayAreaTiles model data
public class PlayAreaTilesCacheManager: CacheManagerBase {

	// MARK: - Private Static Properties
	
	fileprivate static var singleton:				PlayAreaTilesCacheManager?
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var relativeMemberID:	String? = ""
	public fileprivate(set) var playGameID:			String? = ""
	public fileprivate(set) var playAreaID:			String? = ""
	
	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
		
		self.entityName = "PlayAreaTiles"
	}
	
	
	// MARK: - Public Class Computed Properties
	
	public class var shared: PlayAreaTilesCacheManager {
		get {
			
			if (PlayAreaTilesCacheManager.singleton == nil) {
				PlayAreaTilesCacheManager.singleton = PlayAreaTilesCacheManager()
			}
			
			return PlayAreaTilesCacheManager.singleton!
		}
	}
	
	
	// MARK: - Public Methods
	
	public func set(relativeMemberID: String, playGameID: String, playAreaID: String) {
		
		self.relativeMemberID 	= relativeMemberID
		self.playGameID			= playGameID
		self.playAreaID 		= playAreaID
		
		// Set predicate
		self.predicate 			= NSPredicate(format: "relativeMemberID == %@ AND playGameID == %@ AND playAreaID == %@", argumentArray: [relativeMemberID, playGameID, playAreaID])
		
	}
	
	public func select(byIsSpecialYN: Bool) -> [Any] {
		
		var result: 	[Any] = [Any]()
		
		guard (self.collection != nil) else { return result }
		
		// Go through each item
		for item in self.collection!.items! {
			
			let item = item as! PlayAreaTile
			
			if (item.status != .deleted && item.status != .obsolete) {
				
				
				// Get itemData
				let itemData: Any = item.dataNode! as Any
				
				// Append to data
				result.append(itemData)
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func initialiseCacheData() {
		
		self.collection	= PlayAreaTileCollection()
		
	}
	
	public override func setAttributes(cacheData: NSManagedObject) {
		
		// Set relativeMemberID
		cacheData.setValue(self.relativeMemberID, forKeyPath: "relativeMemberID")

		// Set playGameID
		cacheData.setValue(self.playGameID, forKeyPath: "playGameID")
		
		// Set playAreaID
		cacheData.setValue(self.playAreaID, forKeyPath: "playAreaID")
		
	}
	
}
