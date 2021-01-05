//
//  PlayAreaViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import CoreData
import SFCore
import SFController
import SFSocial
import SFGridScape
import SFModel
import f30View
import f30Model
import f30Core

/// Manages the PlayAreaView control layer
public class PlayAreaViewControlManager: ControlManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var imagesUrlRoot:										String? = nil
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:											ProtocolPlayAreaViewControlManagerDelegate?
	public var viewManager:												PlayAreaViewViewManager?
	public fileprivate(set) var relativeMemberWrapper: 					RelativeMemberWrapper? = nil
	public fileprivate(set) var playGameWrapper:						PlayGameWrapper? = nil
	public fileprivate(set) var playAreaID: 							String? = nil
	public fileprivate(set) var gridScapeContainerViewControlManager: 	GridScapeContainerViewControlManager?
	public fileprivate(set) var isMovingTokenYN:						Bool = false

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayAreaViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager = viewManager
	}

	
	// MARK: - Private Computed Properties
	

	// MARK: - Public Methods
	
	public func clear() {
	
		self.relativeMemberWrapper 	= nil
		self.playGameWrapper		= nil
		self.playAreaID 			= nil
		
		self.gridScapeContainerViewControlManager?.clear()
		
	}
	
	public func set(gridScapeContainerViewControlManager: GridScapeContainerViewControlManager) {
		
		self.gridScapeContainerViewControlManager = gridScapeContainerViewControlManager
		
		self.gridScapeContainerViewControlManager?.delegate = self
		
	}
	
	public func set(relativeMemberWrapper: RelativeMemberWrapper, playGameWrapper:						PlayGameWrapper, playAreaID: String) {
		
		self.relativeMemberWrapper 	= relativeMemberWrapper
		self.playGameWrapper 		= playGameWrapper
		self.playAreaID 			= playAreaID
		
	}
	
	public func setUrls(imagesUrlRoot: String) {
		
		self.imagesUrlRoot = imagesUrlRoot
		
	}

	
	// MARK: - Public Methods; PlayAreaCells

	public func loadPlayAreaCells(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, cellCoordRange: CellCoordRange, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 				[String:Any]? = nil
		
		self.relativeMemberWrapper 	= relativeMemberWrapper
		self.playAreaID 			= playAreaID
		
		// Create completion handler
		let loadPlayAreaCellsImagesCompletionHandler: (([PlayAreaCellWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayAreaCellsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Set token
				self.doSetTokenAfterLoadPlayAreaCells(cellCoordRange: cellCoordRange)
				
				// Get playAreaCellWrappers
				let playAreaCellWrappers: 	[PlayAreaCellWrapper]? = wrappers!["PlayAreaCells"] as? [PlayAreaCellWrapper]
				
				// Nb: We may not always want to do this, depending on performance. May be better to load image when the PlayAreaCellType is used
				
				// Load images
				self.loadPlayAreaCellsImages(items: playAreaCellWrappers!, urlRoot: self.imagesUrlRoot!, doLoadTilesImagesYN: true, oncomplete: loadPlayAreaCellsImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayAreaCellsFromDataSourceCompletionHandler: (([PlayAreaCellWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			self.gridScapeContainerViewControlManager!.isGridScapeInitialLoadedYN = true
			
			if (items != nil && error == nil) {
				
				// Process the loaded playAreaCellWrappers
				self.doAfterLoadPlayAreaCells(oncomplete: doAfterLoadPlayAreaCellsCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		#if DEBUG
			
			// Nb: We could load dummy data from the data source, but we want to load from the cache instead. The data will be saved to the cache. In the future we may want the ability to use the cache.
			
			// MIGRATING: (06/05/20)
			//			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")
			//				&& !ApplicationFlags.flag(key: "LoadPlayAreaCellsDummyDataYN")) {
			
			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")
				&& ApplicationFlags.flag(key: "LoadPlayAreaCellsDummyDataYN")) {
								
				// Create completion handler
				let loadFromCacheCompletionHandler: (([CellWrapperBase]?, Error?) -> Void) =
				{
					(items, error) -> Void in
					
					// Call completion handler
					loadPlayAreaCellsFromDataSourceCompletionHandler((items as! [PlayAreaCellWrapper]), error)
					
				}
				
				// Load from cache
				self.loadPlayAreaCellsFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, gridScapeContainerViewControlManager: self.gridScapeContainerViewControlManager!, oncomplete: loadFromCacheCompletionHandler)
				
				return
				
			}
			
		#endif
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayAreaCellsFromDataSource(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, oncomplete: loadPlayAreaCellsFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.playAreaViewControlManager(isNotConnected: nil)
			
		}
		
	}
	
	
	// MARK: - Public Methods; PlayAreaTokens

	public func set(isMovingTokenYN: Bool) {
	
		self.isMovingTokenYN = isMovingTokenYN
		
	}
	
	
	// MARK: - Public Methods; PlayMoves
	
	
	// MARK: - Public Methods; PlayExperiences
	
	public func doAfterPlayExperienceCompleted(wrapper: PlayExperienceWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Check playExperienceResult and playMove
		guard (wrapper.playExperienceResult != nil && wrapper.playMove != nil) else {
			
			// Call completion handler
			completionHandler(NSError())
			
			return
			
		}
		
		// Call completion handler
		completionHandler(nil)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods

	
	// MARK: - Private Methods; PlayAreaCells

	fileprivate func doAfterLoadPlayAreaCells(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 					[String:Any] = [String:Any]()
		
		// Get the PlayAreaCellWrappers
		let playAreaCellWrappers: 		[PlayAreaCellWrapper] = self.getPlayAreaCellModelAdministrator().toWrappers()
		result[self.getPlayAreaCellModelAdministrator().tableName] 		= playAreaCellWrappers

		// Get the PlayAreaTileWrappers
		let playAreaTileWrappers: 		[PlayAreaTileWrapper] = self.getPlayAreaTileModelAdministrator().toWrappers()
		result[self.getPlayAreaTileModelAdministrator().tableName] 		= playAreaTileWrappers
		
		// Get the PlayAreaTileDataWrappers
		let playAreaTileDataWrappers: 		[PlayAreaTileDataWrapper] = self.getPlayAreaTileDataModelAdministrator().toWrappers()
		result[self.getPlayAreaTileDataModelAdministrator().tableName] 	= playAreaTileDataWrappers

		// Get the PlayAreaCellTypeWrappers
		let playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper] = self.loadedPlayAreaCellTypesToWrappers(appendYN: true)
		result[self.getPlayAreaCellTypeModelAdministrator().tableName] 	= playAreaCellTypeWrappers

		// Get the PlayAreaTileTypeWrappers
		let playAreaTileTypeWrappers: 	[PlayAreaTileTypeWrapper] = self.loadedPlayAreaTileTypesToWrappers(appendYN: true)
		result[self.getPlayAreaTileTypeModelAdministrator().tableName] 	= playAreaTileTypeWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Set playAreaCellWrappers
		self.gridScapeContainerViewControlManager!.set(cellWrappers: playAreaCellWrappers)

		// Set playAreaTileWrappers
		self.gridScapeContainerViewControlManager!.set(tileWrappers: playAreaTileWrappers)
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	fileprivate func doSetTokenAfterLoadPlayAreaCells(cellCoordRange: CellCoordRange) {
		
		guard (PlayWrapper.current?.playAreaTokens != nil && PlayWrapper.current!.playAreaTokens!.count > 0) else { return }
		
		var playAreaTokenWrappers: [PlayAreaTokenWrapper] = [PlayAreaTokenWrapper]()
		
		// Go through each item
		for patw in PlayWrapper.current!.playAreaTokens!.values {
			
			// Check playAreaToken within cellCoordRange
			if (cellCoordRange.contains(cellCoord: CellCoord(column: patw.column, row: patw.row))) {
				
				playAreaTokenWrappers.append(patw)
				
			}
			
		}
		
		guard (playAreaTokenWrappers.count > 0) else { return }
		
		// Set playAreaTokenWrappers
		self.gridScapeContainerViewControlManager!.set(tokenWrappers: playAreaTokenWrappers)
		
	}
	

	// MARK: - Private Methods; PlayAreaTiles
	
}


// MARK: - Extension ProtocolGridScapeContainerViewControlManagerDelegate

extension PlayAreaViewControlManager: ProtocolGridScapeContainerViewControlManagerDelegate {

	// MARK: - Public Methods

	// MARK: - Public Methods; Cells
	
	public func createCellModelItem(for cellWrapper: CellWrapperBase) -> ProtocolGridScapeCell? {
		
		// Create PlayAreaCell
		let result: 				PlayAreaCell = self.getPlayAreaCellModelAdministrator().collection!.addItem() as! PlayAreaCell
		
		let pacw: 					PlayAreaCellWrapper? = cellWrapper as? PlayAreaCellWrapper
		
		guard (pacw != nil) else { return nil }
		
		// Set properties
		result.relativeMemberID 	= pacw!.relativeMemberID
		result.playGameID 			= pacw!.playGameID

		return result
		
	}
	
	public func getCellModelItem(for id: String) -> ProtocolGridScapeCell? {
		
		var result: ProtocolGridScapeCell? = self.getPlayAreaCellModelAdministrator().collection!.getItem(id: id) as? ProtocolGridScapeCell
		
		if (result == nil) {
			
			result = self.getPlayAreaCellModelAdministrator().collection!.getItem(id: id) as? ProtocolGridScapeCell
			
			// Set id
			result!.id = id
			
		}
		
		return result
		
	}
	
	public func removeCellModelItem(cell: ProtocolGridScapeCell) {
		
		// Get PlayAreaCell
		let cell = cell as! PlayAreaCell
		
		self.getPlayAreaCellModelAdministrator().collection!.removeItem(item: cell)
		
	}
	
	public func saveCell(cell: ProtocolGridScapeCell, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
				
				self.savePlayAreaCellsToCache(relativeMemberID: self.relativeMemberWrapper!.id, playGameID: self.playGameWrapper!.id, playAreaID: self.playAreaID!)
				
				// Call the completion handler
				completionHandler(nil)
				
				return
				
			}
			
		#endif
		
		let ma: 	PlayAreaCellModelAdministrator = self.getPlayAreaCellModelAdministrator()
		
		ma.initialise()
		
		// Get PlayAreaCell
		let cell = cell as! PlayAreaCell
		
		// Get status
		let s: 		ModelItemStatusTypes = cell.status
		
		// Create PlayAreaCell model item
		let pac: 	PlayAreaCell = ma.collection!.getNewItem() as! PlayAreaCell
		
		pac.clone(item: cell)
		
		ma.collection!.addItem(item: pac)
		
		// Set status
		pac.status 	= s
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			if (error == nil) {
				
				// TODO:
				// Update the ID in the wrapper
				
			}
			
			// Call the completion handler
			completionHandler(error)
			
		}
		
		// Save
		ma.save(oncomplete: saveCompletionHandler)
		
	}
	
	
	// MARK: - Public Methods; Tiles
	
	public func createTileModelItem(for tileWrapper: TileWrapperBase) -> ProtocolGridScapeTile? {
		
		// Create PlayAreaTile
		let result: 				PlayAreaTile = self.getPlayAreaTileModelAdministrator().collection!.addItem() as! PlayAreaTile
		
		let patw: 					PlayAreaTileWrapper? = tileWrapper as? PlayAreaTileWrapper
		
		guard (patw != nil) else { return nil }
		
		// Set properties
		result.relativeMemberID 	= patw!.relativeMemberID
		result.playGameID 			= patw!.playGameID
		
		return result
		
	}
	
	public func getTileModelItem(for id: String) -> ProtocolGridScapeTile? {
		
		var result: ProtocolGridScapeTile? = self.getPlayAreaTileModelAdministrator().collection!.getItem(id: id) as? ProtocolGridScapeTile
		
		if (result == nil) {
			
			result = self.getPlayAreaTileModelAdministrator().collection!.getItem(id: id) as? ProtocolGridScapeTile
			
			// Set id
			result!.id = id
			
		}
		
		return result
		
	}
	
	public func removeTileModelItem(tile: ProtocolGridScapeTile) {
		
		// Get PlayAreaTile
		let tile = tile as! PlayAreaTile
		
		self.getPlayAreaTileModelAdministrator().collection!.removeItem(item: tile)
		
	}
	
	public func saveTile(tile: ProtocolGridScapeTile, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
				
				self.savePlayAreaTilesToCache(relativeMemberID: self.relativeMemberWrapper!.id, playGameID: self.playGameWrapper!.id, playAreaID: self.playAreaID!)
				
				// Call the completion handler
				completionHandler(nil)
				
				return
				
			}
			
		#endif
		
		let ma: 	PlayAreaTileModelAdministrator = self.getPlayAreaTileModelAdministrator()
		
		ma.initialise()
		
		// Get PlayAreaTile
		let tile = tile as! PlayAreaTile
		
		// Get status
		let s: 		ModelItemStatusTypes = tile.status
		
		// Create PlayAreaTile model item
		let pat: 	PlayAreaTile = ma.collection!.getNewItem() as! PlayAreaTile
		
		pat.clone(item: tile)
		
		ma.collection!.addItem(item: pat)
		
		// Set status
		pat.status 	= s
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			if (error == nil) {
				
				// TODO:
				// Update the ID in the wrapper
				
			}
			
			// Call the completion handler
			completionHandler(error)
			
		}
		
		// Save
		ma.save(oncomplete: saveCompletionHandler)
		
	}

	
	// MARK: - Public Methods; Tokens
	
	public func createTokenModelItem(for tokenWrapper: TokenWrapperBase) -> ProtocolGridScapeToken? {
		
		// Create PlayAreaToken
		let result: 				PlayAreaToken = self.getPlayAreaTokenModelAdministrator().collection!.addItem() as! PlayAreaToken
		
		let patw: 					PlayAreaTokenWrapper? = tokenWrapper as? PlayAreaTokenWrapper
		
		guard (patw != nil) else { return nil }
		
		// Set properties
		result.relativeMemberID 	= patw!.relativeMemberID
		result.playGameID 			= patw!.playGameID
		
		return result
		
	}
	
	public func getTokenModelItem(for id: String) -> ProtocolGridScapeToken? {
		
		var result: ProtocolGridScapeToken? = self.getPlayAreaTokenModelAdministrator().collection!.getItem(id: id) as? ProtocolGridScapeToken
		
		if (result == nil) {
			
			result = self.getPlayAreaTokenModelAdministrator().collection!.getItem(id: id) as? ProtocolGridScapeToken
			
			// Set id
			result!.id = id
			
		}
		
		return result
		
	}
	
	public func removeTokenModelItem(token: ProtocolGridScapeToken) {
		
		// Get PlayAreaToken
		let token = token as! PlayAreaToken
		
		self.getPlayAreaTokenModelAdministrator().collection!.removeItem(item: token)
		
	}
	
	public func saveToken(token: ProtocolGridScapeToken, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
				
				self.savePlayAreaTokensToCache(relativeMemberID: self.relativeMemberWrapper!.id, playGameID: self.playGameWrapper!.id, playAreaID: self.playAreaID!)
				
				// Call the completion handler
				completionHandler(nil)
				
				return
				
			}
			
		#endif
		
		let ma: 	PlayAreaTokenModelAdministrator = self.getPlayAreaTokenModelAdministrator()
		
		ma.initialise()
		
		// Get PlayAreaToken
		let token = token as! PlayAreaToken
		
		// Get status
		let s: 		ModelItemStatusTypes = token.status
		
		// Create PlayAreaToken model item
		let pat: 	PlayAreaToken = ma.collection!.getNewItem() as! PlayAreaToken
		
		pat.clone(item: token)
		
		ma.collection!.addItem(item: pat)
		
		// Set status
		pat.status 	= s
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			if (error == nil) {
				
				// TODO:
				// Update the ID in the wrapper
				
			}
			
			// Call the completion handler
			completionHandler(error)
			
		}
		
		// Save
		ma.save(oncomplete: saveCompletionHandler)
		
	}

}

