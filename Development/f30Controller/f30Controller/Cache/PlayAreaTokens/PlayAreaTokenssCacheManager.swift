//
//  PlayAreaTokensCacheManager.swift
//  f30Controller
//
//  Created by David on 09/12/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import SFController
import f30Model

/// Manages cacheing for PlayAreaTokens model data
public class PlayAreaTokensCacheManager: CacheManagerBase {

	// MARK: - Private Static Properties
	
	fileprivate static var singleton:				PlayAreaTokensCacheManager?
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var relativeMemberID:	String? = ""
	public fileprivate(set) var playGameID:			String? = ""
	public fileprivate(set) var playAreaID:			String? = ""
	
	
	// MARK: - Initializers
	
	fileprivate override init() {
		super.init()
		
		self.entityName = "PlayAreaTokens"
	}
	
	
	// MARK: - Public Class Computed Properties
	
	public class var shared: PlayAreaTokensCacheManager {
		get {
			
			if (PlayAreaTokensCacheManager.singleton == nil) {
				PlayAreaTokensCacheManager.singleton = PlayAreaTokensCacheManager()
			}
			
			return PlayAreaTokensCacheManager.singleton!
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
	
	
	// MARK: - Override Methods
	
	public override func initialiseCacheData() {
		
		self.collection	= PlayAreaTokenCollection()
		
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
