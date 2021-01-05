//
//  PlayGamesViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFCore
import SFController
import SFSocial
import SFModel
import f30View
import f30Model
import f30Core

/// Manages the PlayGamesView control layer
public class PlayGamesViewControlManager: ControlManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var relativeMemberWrapper: 				RelativeMemberWrapper? = nil


	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayGamesViewControlManagerDelegate?
	public var viewManager:								PlayGamesViewViewManager?
	public fileprivate(set) var playGameWrappers:		PlayGameWrappers = PlayGameWrappers()
	public fileprivate(set) var playGameDataWrappers:	PlayGameDataWrappers = PlayGameDataWrappers()
	public var activePlayGameID: 						String? = nil
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayGamesViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager	= viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func clear() {

		self.playGameWrappers.clear()
		self.playGameDataWrappers.clear()
		
	}
	
	public func loadPlayGames(for relativeMemberWrapper: RelativeMemberWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		self.relativeMemberWrapper 	= relativeMemberWrapper
		
		#if DEBUG
			
			// Nb: We could load dummy data from the data source, but we want to load from the cache instead. The data will be saved to the cache. In the future we may want the ability to use the cache.
			
			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")) {
				
				// Create completion handler
				let loadFromCacheCompletionHandler: (([PlayGameWrapper]?, Error?) -> Void) =
				{
					(items, error) -> Void in
					
					if (items != nil && error == nil) {
						
						// Process the loaded playGameWrappers
						self.doAfterLoadPlayGames(oncomplete: completionHandler)
						
					}
					
				}
				
				// Load from cache
				self.loadFromCache(for: relativeMemberWrapper, oncomplete: loadFromCacheCompletionHandler)
				
				return
				
			}
			
		#endif
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Create completion handler
			let loadPlayGamesFromDataSourceCompletionHandler: (([PlayGameWrapper]?, Error?) -> Void) =
			{
				(items, error) -> Void in

				if (items != nil && error == nil) {
					
					// Process the loaded playGameWrappers
					self.doAfterLoadPlayGames(oncomplete: completionHandler)
					
				} else {
					
					// Call completion handler
					completionHandler(nil, error)
					
				}
				
			}
			
			// Load from data source
			self.loadPlayGamesFromDataSource(for: relativeMemberWrapper, loadLatestOnlyYN: false, oncomplete: loadPlayGamesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.playGamesViewControlManager(isNotConnected: nil)
			
		}
		
	}
	
	public func savePlayGame(wrapper: PlayGameWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get status
		let status: ModelItemStatusTypes = wrapper.status
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				if (status == .new) {
					
					// Process the added playGameWrapper
					self.doAfterAddPlayGame(playGameWrapper: wrapper)
					
				}
					
				// Call completion handler
				completionHandler(nil, error)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Save PlayGame
		self.savePlayGame(wrapper: wrapper, oncomplete: saveCompletionHandler)
		
	}
	
	public func getNextActivePlayGameWrapper() -> PlayGameWrapper? {
		
		guard (self.playGameWrappers.items.count > 0) else { return nil }
		
		var result: 	PlayGameWrapper? = nil
		var i: 			Int = 0
		
		// Go through each item
		repeat {
			
			// Get PlayGameWrapper
			let pgw: 	PlayGameWrapper = self.playGameWrappers.items[i]
			
			// Check activePlayGameID
			if (pgw.id != self.activePlayGameID) { result = pgw }
			
			i += 1
			
		} while (result == nil && i < self.playGameWrappers.items.count - 1);
		
		return result
		
	}
	
	public func deletePlayGame(wrapper: PlayGameWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
	
		// Create completion handler
		let deleteCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				// Process the deleted playGameWrapper
				self.doAfterDeletePlayGame(playGameWrapper: wrapper)
				
				// Call completion handler
				completionHandler(nil, error)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Delete PlayGame
		self.deletePlayGame(wrapper: wrapper, oncomplete: deleteCompletionHandler)
		
	}
	

	// MARK: - Override Methods
	
	
	// MARK: - Private Methods

	fileprivate func loadFromCache(for relativeMemberWrapper: RelativeMemberWrapper, oncomplete completionHandler:@escaping ([PlayGameWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadPlayGameDataCompletionHandler: (([PlayGameDataWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call the completion handler
			completionHandler([PlayGameWrapper](), error)
			
		}
		
		// Create completion handler
		let loadPlayGamesCompletionHandler: (([PlayGameWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (error == nil) {
				
				// Load from cache
				self.loadPlayGameDataFromCache(for: relativeMemberWrapper, oncomplete: loadPlayGameDataCompletionHandler)
				
			} else {
				
				// Call the completion handler
				completionHandler(nil, error)
				
			}
			
		}

		// Load from cache
		self.loadPlayGamesFromCache(for: relativeMemberWrapper, oncomplete: loadPlayGamesCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods; PlayGames
	
	fileprivate func doAfterLoadPlayGames(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 				[String:Any] = [String:Any]()
		
		// Get the PlayGamesWrappers
		let playGameWrappers: 		[PlayGameWrapper] = self.loadedPlayGamesToWrappers(appendYN: true)
		
		result[self.getPlayGameModelAdministrator().tableName] 		= playGameWrappers

		// Get the PlayGameDataWrappers
		let playGameDataWrappers: 	[PlayGameDataWrapper] = self.loadedPlayGameDataToWrappers(appendYN: true)
		
		result[self.getPlayGameDataModelAdministrator().tableName] 	= playGameDataWrappers
		
		self.playGameWrappers.clear()
		self.playGameDataWrappers.clear()
		
		// Set wrappers
		self.playGameWrappers.items.append(contentsOf: playGameWrappers)
		self.playGameDataWrappers.items.append(contentsOf: playGameDataWrappers)
		
		// Set playGameDataWrappers wrappers in playGameWrappers
		self.playGameWrappers.set(playGameDataWrappers: self.playGameDataWrappers)
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	fileprivate func doAfterAddPlayGame(playGameWrapper: PlayGameWrapper) {
		
		// Append to playGameWrappers
		self.playGameWrappers.items.append(playGameWrapper)
		
		// Append to playGameDataWrappers
		self.playGameDataWrappers.items.append(playGameWrapper.playGameData!)
		
	}

	fileprivate func doAfterDeletePlayGame(playGameWrapper: PlayGameWrapper) {
		
		// Remove from playGameWrappers
		self.playGameWrappers.remove(wrapper: playGameWrapper)
		
		// Remove from playGameDataWrappers
		self.playGameDataWrappers.remove(wrapper: playGameWrapper.playGameData!)
		
		// Delete from PlayWrapper
		PlayWrapper.current!.clear(playGame: playGameWrapper)
		
	}
	
	
	// MARK: - Private Methods; PlayGameData

		
}
