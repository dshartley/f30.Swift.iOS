//
//  PlayResultWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core
import SFSerialization

/// A wrapper for a PlayResult model item
public class PlayResultWrapper {
	
	// MARK: - Private Static Stored Properties
	
	fileprivate var playGameWrappers: 					[PlayGameWrapper] = [PlayGameWrapper]()
	fileprivate var playGameDataWrappers: 				[PlayGameDataWrapper] = [PlayGameDataWrapper]()
	fileprivate var playAreaTileWrappers: 				[PlayAreaTileWrapper] = [PlayAreaTileWrapper]()
	fileprivate var playAreaTileDataWrappers: 			[PlayAreaTileDataWrapper] = [PlayAreaTileDataWrapper]()
	fileprivate var playExperienceStepResultWrappers: 	[PlayExperienceStepResultWrapper] = [PlayExperienceStepResultWrapper]()
	

	// MARK: - Public Stored Properties
	
	public var relativeMemberID:					String = ""
	public var id: 									String = ""
	public var playGamesJSON: 						String = ""
	public var playGameDataJSON: 					String = ""
	public var playAreaTilesJSON: 					String = ""
	public var playAreaTileDataJSON: 				String = ""
	public var playExperienceStepResultsJSON: 		String = ""
	
	
	// MARK: - Initializers
	
	public init() {
		
	}

	
	// MARK: - Public Methods

	public func dispose() {
		
	}
	
	public func clear() {
		
		self.playGameWrappers.removeAll()
		self.playGameDataWrappers.removeAll()
		self.playAreaTileWrappers.removeAll()
		self.playAreaTileDataWrappers.removeAll()
		self.playExperienceStepResultWrappers.removeAll()

		self.playGamesJSON 					= ""
		self.playGameDataJSON 				= ""
		self.playAreaTilesJSON 				= ""
		self.playAreaTileDataJSON 			= ""
		self.playExperienceStepResultsJSON 	= ""
	}
	
	public func generateJSON() {

		self.doPlayGameWrappersToJSON()
		self.doPlayGameDataWrappersToJSON()
		self.doPlayAreaTileWrappersToJSON()
		self.doPlayAreaTileDataWrappersToJSON()
		self.doPlayExperienceStepResultWrappersToJSON()
		
	}

	public func set(playGameWrapper: PlayGameWrapper) {
		
		self.playGameWrappers.append(playGameWrapper)
		
	}

	public func set(playGameDataWrapper: PlayGameDataWrapper) {
		
		self.playGameDataWrappers.append(playGameDataWrapper)
		
	}

	public func set(playAreaTileWrapper: PlayAreaTileWrapper) {
		
		self.playAreaTileWrappers.append(playAreaTileWrapper)
		
	}
	
	public func set(playAreaTileDataWrapper: PlayAreaTileDataWrapper) {
		
		self.playAreaTileDataWrappers.append(playAreaTileDataWrapper)
		
	}
	
	public func set(playExperienceStepResultWrapper: PlayExperienceStepResultWrapper) {
		
		self.playExperienceStepResultWrappers.append(playExperienceStepResultWrapper)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func doPlayGameWrappersToJSON() {
		
		// Create DataJSONWrapper for collection of items
		let jsonItems: 		DataJSONWrapper = DataJSONWrapper()
		jsonItems.ID 		= "PlayGames"
		
		// Convert playGameWrappers to JSON
		let collection: 	PlayGameCollection = PlayGameCollection()
		
		// Go through each item
		for pgw in self.playGameWrappers {
			
			// Create the model item from the wrapper
			let item: 		PlayGame = collection.addItem() as! PlayGame
			item.clone(fromWrapper: pgw)
			
			// Create DataJSONWrapper from item
			let jsonItem: 	DataJSONWrapper = item.copyToWrapper()
			
			jsonItems.Items.append(jsonItem)
			
		}
		
		self.playGamesJSON = JSONHelper.SerializeDataJSONWrapper(dataWrapper: jsonItems)!
		
	}
	
	fileprivate func doPlayGameDataWrappersToJSON() {
		
		// Create DataJSONWrapper for collection of items
		let jsonItems: 		DataJSONWrapper = DataJSONWrapper()
		jsonItems.ID 		= "PlayGameData"
		
		// Convert playGameDataWrappers to JSON
		let collection: 	PlayGameDataCollection = PlayGameDataCollection()
		
		// Go through each item
		for pgdw in self.playGameDataWrappers {
			
			// Create the model item from the wrapper
			let item: 		PlayGameData = collection.addItem() as! PlayGameData
			item.clone(fromWrapper: pgdw)
			
			// Create DataJSONWrapper from item
			let jsonItem: 	DataJSONWrapper = item.copyToWrapper()
			
			jsonItems.Items.append(jsonItem)
			
		}
		
		self.playGameDataJSON = JSONHelper.SerializeDataJSONWrapper(dataWrapper: jsonItems)!
		
	}
	
	fileprivate func doPlayAreaTileWrappersToJSON() {
		
		// Create DataJSONWrapper for collection of items
		let jsonItems: 		DataJSONWrapper = DataJSONWrapper()
		jsonItems.ID 		= "PlayAreaTiles"
		
		// Convert playAreaTileWrappers to JSON
		let collection: 	PlayAreaTileCollection = PlayAreaTileCollection()
		
		// Go through each item
		for patw in self.playAreaTileWrappers {
			
			// Create the model item from the wrapper
			let item: 		PlayAreaTile = collection.addItem() as! PlayAreaTile
			item.clone(fromWrapper: patw)
			
			// Create DataJSONWrapper from item
			let jsonItem: 	DataJSONWrapper = item.copyToWrapper()
			
			jsonItems.Items.append(jsonItem)
			
		}
		
		self.playAreaTilesJSON = JSONHelper.SerializeDataJSONWrapper(dataWrapper: jsonItems)!
		
	}
	
	fileprivate func doPlayAreaTileDataWrappersToJSON() {
		
		// Create DataJSONWrapper for collection of items
		let jsonItems: 		DataJSONWrapper = DataJSONWrapper()
		jsonItems.ID 		= "PlayAreaTileData"
		
		// Convert playAreaTileDataWrappers to JSON
		let collection: 	PlayAreaTileDataCollection = PlayAreaTileDataCollection()
		
		// Go through each item
		for patdw in self.playAreaTileDataWrappers {
			
			// Create the model item from the wrapper
			let item: 		PlayAreaTileData = collection.addItem() as! PlayAreaTileData
			item.clone(fromWrapper: patdw)
			
			// Create DataJSONWrapper from item
			let jsonItem: 	DataJSONWrapper = item.copyToWrapper()
			
			jsonItems.Items.append(jsonItem)
			
		}
		
		self.playAreaTileDataJSON = JSONHelper.SerializeDataJSONWrapper(dataWrapper: jsonItems)!
		
	}

	fileprivate func doPlayExperienceStepResultWrappersToJSON() {
		
		// Create DataJSONWrapper for collection of items
		let jsonItems: 		DataJSONWrapper = DataJSONWrapper()
		jsonItems.ID 		= "PlayExperienceStepResults"
		
		// Go through each item
		for pesrw in self.playExperienceStepResultWrappers {
			
			// Create DataJSONWrapper from item
			let jsonItem: 	DataJSONWrapper = pesrw.copyToWrapper()
			
			jsonItems.Items.append(jsonItem)
			
		}
		
		self.playExperienceStepResultsJSON = JSONHelper.SerializeDataJSONWrapper(dataWrapper: jsonItems)!
		
	}
	
}
