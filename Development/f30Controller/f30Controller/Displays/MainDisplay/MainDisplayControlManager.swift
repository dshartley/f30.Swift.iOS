//
//  MainDisplayControlManager.swift
//  f30Controller
//
//  Created by David on 05/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFCore
import SFController
import SFSecurity
import SFNet
import SFSocial
import SFGridScape
import SFGraphics
import SFModel
import f30Model
import f30View
import f30Core

/// Manages the MainDisplay control layer
public class MainDisplayControlManager: ControlManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var imagesUrlRoot:					String? = nil
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:						ProtocolMainDisplayControlManagerDelegate?
	public var viewManager:							MainDisplayViewManager?
	public fileprivate(set) var playGameWrapper:	PlayGameWrapper? = nil

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
		
		UserProfileWrapper.delegate 	= self
	}
	
	public init(modelManager: ModelManager, viewManager: MainDisplayViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager 				= viewManager
		
		UserProfileWrapper.delegate 	= self
		
	}
	
	
	// MARK: - Public Methods

	public func clear() {
		
		self.doClearPlayGame()
		
		PlayWrapper.current?.clear()
		
		self.clearModelAdministrators()
		self.clearCacheManagers()
		
	}
	
	public func checkIsSignedIn() {
		
		// Check isSignedInYN
		let isSignedInYN: Bool = self.isSignedInYN()

		if (!isSignedInYN) {
		
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotSignedIn: nil)
			return
			
		}
	
		// Check current user profile wrapper
		if (UserProfileWrapper.current == nil && UserProfileWrapper.errorCode != .none) {
			
			self.onUserProfileWrapperLoadFailed(error: nil, code: UserProfileWrapper.errorCode)
			return
			
		}

		
	}
	
	public func setButtons() {
		
		self.viewManager!.setButtons(isSignedInYN: true)
		
	}
	
	public func displayUserInfo() {
		
		var message = ""
		
		if let userProperties = AuthenticationManager.shared.currentUserProperties {
			
			message += "[currentUserProperties:"
			
			if (userProperties.displayName != nil) {
				message += "[displayname: \(userProperties.displayName!)]"
			}
			
			if (userProperties.email != nil) {
				message += "[email: \(userProperties.email!)]"
			}
			
			if (userProperties.id != nil) {
				message += "[id: \(userProperties.id!)]"
			}
			
			message += "]"
		}
		
		if (UserProfileWrapper.current != nil) {
			
			message += "[currentUserProfile:"
			
			message += "[id: \(UserProfileWrapper.current!.id)]"
			
			message += "]"
		}
		
		if (RelativeMemberWrapper.current != nil) {
			
			message += "[currentRelativeMember:"
			
			message += "[id: \(RelativeMemberWrapper.current!.id)]"
			
			message += "]"
		}
		
		self.viewManager!.displayUserInfo(message: message)
	}
	
	public func displayAvatar() {
		
		var avatarImageData: Data? = nil
		
		// Get image from avatarImageData if set
		if (UserProfileWrapper.current != nil) {
			
			avatarImageData = UserProfileWrapper.current?.avatarImageData
		}
		
		if (avatarImageData == nil) {
			
			// Get image from photoData
			if let photoData = AuthenticationManager.shared.currentUserProperties?.photoData {
				
				avatarImageData = photoData

			}
			
		}
		
		if (avatarImageData != nil) {
			
			// Create image
			let image: UIImage = UIImage(data: avatarImageData!)!
			
			// Display image
			self.viewManager!.displayAvatar(image: image)
			
		}

	}
	
	public func setUrls(imagesUrlRoot: String) {
		
		self.imagesUrlRoot = imagesUrlRoot
		
	}
	
	
	// MARK: - Public Methods; PlaySubsets
	
	public func loadPlaySubsets(for relativeMemberWrapper: RelativeMemberWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 				[String:Any]? = nil
		
		// Create completion handler
		let loadPlaySubsetImagesCompletionHandler: (([PlaySubsetWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlaySubsetsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playSubsetWrappers
				let playSubsetWrappers: 	[PlaySubsetWrapper]? = wrappers!["PlaySubsets"] as? [PlaySubsetWrapper]
				
				// Load images
				self.loadPlaySubsetImages(items: playSubsetWrappers!, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlaySubsetImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlaySubsetsFromDataSourceCompletionHandler: (([PlaySubsetWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playSubsetWrappers
				self.doAfterLoadPlaySubsets(oncomplete: doAfterLoadPlaySubsetsCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlaySubsetsFromDataSource(for: relativeMemberWrapper, oncomplete: loadPlaySubsetsFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: NSError())
			
		}
		
	}
	
	
	// MARK: - Public Methods; PlayGames
	
	public func clearPlayGame() {
		
		// Clear PlayGame
		self.doClearPlayGame()
		
		// Clear display
		
		self.getPlayGameModelAdministrator().initialise()
		self.getPlayGameDataModelAdministrator().initialise()
		self.getPlayAreaCellTypeModelAdministrator().initialise()
		self.getPlayAreaCellModelAdministrator().initialise()
		self.getPlayAreaTileTypeModelAdministrator().initialise()
		self.getPlayAreaTileModelAdministrator().initialise()
		self.getPlayAreaTokenModelAdministrator().initialise()
		
	}
	
	public func loadPlayGame(for playGameID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			// Nb: We could load dummy data from the data source, but we want to load from the cache instead. The data will be saved to the cache. In the future we may want the ability to use the cache.
			
			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")
				&& !ApplicationFlags.flag(key: "LoadPlayGamesDummyDataYN")) {
				
				// Create completion handler
				let loadFromCacheCompletionHandler: (([String:Any]?, Error?) -> Void) =
				{
					(wrappers, error) -> Void in
					
					// Call completion handler
					completionHandler(wrappers, error)
					
				}
				
				// Load from cache
				self.loadPlayGamesFromCache(for: RelativeMemberWrapper.current!, playGameID: playGameID, oncomplete: loadFromCacheCompletionHandler)

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
			self.loadPlayGamesFromDataSource(for: playGameID, oncomplete: loadPlayGamesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	public func loadLatestPlayGame(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			// Nb: We could load dummy data from the data source, but we want to load from the cache instead. The data will be saved to the cache. In the future we may want the ability to use the cache.
			
			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")) {
				
				// Create completion handler
				let loadFromCacheCompletionHandler: (([String:Any]?, Error?) -> Void) =
				{
					(wrappers, error) -> Void in
					
					// Call completion handler
					completionHandler(wrappers, error)
					
				}
				
				let loadLatestOnlyYN: Bool = true
				
				// Load from cache
				self.loadPlayGamesFromCache(for: RelativeMemberWrapper.current!, loadLatestOnlyYN: loadLatestOnlyYN, oncomplete: loadFromCacheCompletionHandler)
				
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
			
			// DEBUG:
			// Call completion handler
			//loadPlayGamesFromDataSourceCompletionHandler([PlayGameWrapper](), nil)
			
			// Load from data source
			self.loadPlayGamesFromDataSource(for: RelativeMemberWrapper.current!, loadLatestOnlyYN: true, oncomplete: loadPlayGamesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}

	public func processLoadedPlayGame(wrappers: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let state: CheckLoadedPlayGameRelationalDataWrapper = CheckLoadedPlayGameRelationalDataWrapper()
		
		// Check relational data
		self.checkLoadedPlayGameRelationalData(wrappers: wrappers, state: state, oncomplete: completionHandler)
		
	}

	public func addPlayGame(for relativeMemberWrapper: RelativeMemberWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create PlayGameWrapper
		let pgw: PlayGameWrapper = self.createPlayGameWrapper(relativeMemberWrapper: relativeMemberWrapper)
		
		// TODO:
		// Set default playSubsetID
		let psw: PlaySubsetWrapper = PlayWrapper.current!.playSubsets!.values.first!
		pgw.playSubsetID = psw.id
		
		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	// [unowned self]
			
			if (error == nil) {
				
				// Process the loaded playGameWrappers
				self.doAfterLoadPlayGames(oncomplete: completionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Save PlayGame
		self.savePlayGame(wrapper: pgw, oncomplete: saveCompletionHandler)
		
	}
	
	public func set(playGameWrapper: PlayGameWrapper) {
		
		guard (self.playGameWrapper == nil || self.playGameWrapper!.id != playGameWrapper.id) else { return }
		
		// Nb: Not sure we want to do this here because it clears the PlayAreaCellTypes
		// Clear PlayGame
		//self.doClearPlayGame()
		
		self.playGameWrapper = playGameWrapper
		
	}
	
	
	// MARK: - Public Methods; PlayAreaTokens
	
	public func loadPlayAreaTokens(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 				[String:Any]? = nil

		// Create completion handler
		let loadPlayAreaTokenImagesCompletionHandler: (([PlayAreaTokenWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayAreaTokensCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers

				// Get playAreaTokenWrappers
				let playAreaTokenWrappers: 	[PlayAreaTokenWrapper]? = wrappers!["PlayAreaTokens"] as? [PlayAreaTokenWrapper]
				
				// Load images
				self.loadPlayAreaTokenImages(items: playAreaTokenWrappers!, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayAreaTokenImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayAreaTokensFromDataSourceCompletionHandler: (([PlayAreaTokenWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playAreaCellWrappers
				self.doAfterLoadPlayAreaTokens(oncomplete: doAfterLoadPlayAreaTokensCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		#if DEBUG
			
			// Nb: We could load dummy data from the data source, but we want to load from the cache instead. The data will be saved to the cache. In the future we may want the ability to use the cache.
			
			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")) {
				
				// Create completion handler
				let loadFromCacheCompletionHandler: (([PlayAreaTokenWrapper]?, Error?) -> Void) =
				{
					(items, error) -> Void in
					
					// Call completion handler
					loadPlayAreaTokensFromDataSourceCompletionHandler(items, error)
					
				}
				
				// Load from cache
				self.loadPlayAreaTokensFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, oncomplete: loadFromCacheCompletionHandler)
				
				return
				
			}
			
		#endif
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayAreaTokensFromDataSource(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, oncomplete: loadPlayAreaTokensFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: NSError())
			
		}
		
	}
	
	public func addToken(for playGameWrapper: PlayGameWrapper, oncomplete completionHandler:@escaping (PlayAreaTokenWrapper?, Error?) -> Void) {
		
		var patw: 					PlayAreaTokenWrapper? = nil
		
		// Create completion handler
		let savePlayAreaTokenCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			guard (error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Call completion handler
			completionHandler(patw, nil)
			
		}
		
		// Create playAreaTokenWrapper
		patw 						= self.createPlayAreaTokenWrapper(for: playGameWrapper)

		// Set cellCoord to [0,0]
		patw!.column 				= 0
		patw!.row 					= 0
		patw!.imageName 			= "Token1"
		patw!.imageData 			= ImageHelper.toPNGData(image: #imageLiteral(resourceName: "Token1"))
		
		var result: 				[String:Any] = [String:Any]()
		
		// Get the PlayAreaTokenWrappers
		var playAreaTokenWrappers: 	[PlayAreaTokenWrapper] = [PlayAreaTokenWrapper]()
		playAreaTokenWrappers.append(patw!)
		
		result[self.getPlayAreaTokenModelAdministrator().tableName] = playAreaTokenWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Save PlayAreaToken
		self.savePlayAreaToken(wrapper: patw!, oncomplete: savePlayAreaTokenCompletionHandler)
		
	}

	
	// MARK: - Public Methods; PlayAreaCellTypes
	
	public func loadPlayAreaCellTypes(for playSubsetID: String, relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let loadPlayAreaCellTypesImagesCompletionHandler: (([PlayAreaCellTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
	
			// Call completion handler
			completionHandler(result, error)

		}
		
		// Create completion handler
		let doAfterLoadPlayAreaCellTypesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playAreaCellTypeWrappers
				let playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper]? = wrappers!["PlayAreaCellTypes"] as? [PlayAreaCellTypeWrapper]
				
				// Nb: We may not always want to do this, depending on performance. May be better to load image when the PlayAreaCellType is used
				
				// Load images
				self.loadPlayAreaCellTypesImages(items: playAreaCellTypeWrappers!, oncomplete: loadPlayAreaCellTypesImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayAreaCellTypesFromDataSourceCompletionHandler: (([PlayAreaCellTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playAreaCellTypesWrappers
				self.doAfterLoadPlayAreaCellTypes(oncomplete: doAfterLoadPlayAreaCellTypesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayAreaCellTypesFromDataSource(for: playSubsetID, relativeMemberWrapper: relativeMemberWrapper, playGameID: playGameID, oncomplete: loadPlayAreaCellTypesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}

	public func getRandomPlayAreaCellTypeWrapper(oncomplete completionHandler:@escaping (PlayAreaCellTypeWrapper?, Error?) -> Void) {
		
		self.getRandomPlayAreaCellTypeWrapper(urlRoot: self.imagesUrlRoot!, oncomplete: completionHandler)
	}
	
	
	// MARK: - Public Methods; PlayAreaCells
	
	public func loadPlayAreaCells(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, isSpecialYN: Bool, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 				[String:Any]? = nil

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
			
			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")) {
				
				// Create completion handler
				let loadFromCacheCompletionHandler: (([CellWrapperBase]?, Error?) -> Void) =
				{
					(items, error) -> Void in
					
					// Call completion handler
					loadPlayAreaCellsFromDataSourceCompletionHandler((items as! [PlayAreaCellWrapper]), error)
					
				}
				
				// Load from cache
				self.doLoadPlayAreaCellsFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, isSpecialYN: isSpecialYN, oncomplete: loadFromCacheCompletionHandler)
				
				return
				
			}
			
		#endif
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayAreaCellsFromDataSource(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, isSpecialYN: isSpecialYN, oncomplete: loadPlayAreaCellsFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: NSError())
			
		}
		
	}
	
	public func addStartCell(for playGameWrapper: PlayGameWrapper, oncomplete completionHandler:@escaping (PlayAreaCellWrapper?, Error?) -> Void) {
		
		var pacw: 						PlayAreaCellWrapper? = nil
		
		// Create completion handler
		let savePlayAreaCellCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			guard (error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}

			// Call completion handler
			completionHandler(pacw, nil)
			
		}
		
		// Get playAreaCellTypeWrapper 'StartCell'
		let pactw: 						PlayAreaCellTypeWrapper? = PlayWrapper.current!.get(byName: "\(PlayAreaCellTypeNames.StartCell)")
		
		guard (pactw != nil) else {
			
			// Call completion handler
			completionHandler(nil, NSError())
			
			return
			
		}
		
		// Create playAreaCellWrapper
		pacw 							= self.createPlayAreaCellWrapper(for: playGameWrapper)
		pacw!.set(cellTypeWrapper: pactw!)
		
		// Set 'StartCell' cellCoord to [0,0]
		pacw!.column 					= 0
		pacw!.row 						= 0
		
		var result: 					[String:Any] = [String:Any]()
		
		// Get the PlayAreaCellWrappers
		var playAreaCellWrappers: 		[PlayAreaCellWrapper] = [PlayAreaCellWrapper]()
		playAreaCellWrappers.append(pacw!)
		
		result[self.getPlayAreaCellModelAdministrator().tableName] = playAreaCellWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Save PlayAreaCell
		self.savePlayAreaCell(wrapper: pacw!, oncomplete: savePlayAreaCellCompletionHandler)
		
	}
	
	
	// MARK: - Public Methods; PlayAreaTileTypes

	public func loadPlayAreaTileTypes(for playSubsetID: String, relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let loadPlayAreaTileTypesImagesCompletionHandler: (([PlayAreaTileTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayAreaTileTypesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playAreaTileTypeWrappers
				let playAreaTileTypeWrappers: 	[PlayAreaTileTypeWrapper]? = wrappers!["PlayAreaTileTypes"] as? [PlayAreaTileTypeWrapper]
				
				// Nb: We may not always want to do this, depending on performance. May be better to load image when the PlayAreaTileType is used
				
				// Load images
				self.loadPlayAreaTileTypesImages(items: playAreaTileTypeWrappers!, oncomplete: loadPlayAreaTileTypesImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayAreaTileTypesFromDataSourceCompletionHandler: (([PlayAreaTileTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playAreaTileTypesWrappers
				self.doAfterLoadPlayAreaTileTypes(oncomplete: doAfterLoadPlayAreaTileTypesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayAreaTileTypesFromDataSource(for: playSubsetID, relativeMemberWrapper: relativeMemberWrapper, playGameID: playGameID, oncomplete: loadPlayAreaTileTypesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	public func getRandomPlayAreaTileTypeWrapper(oncomplete completionHandler:@escaping (PlayAreaTileTypeWrapper?, Error?) -> Void) {
		
		self.getRandomPlayAreaTileTypeWrapper(urlRoot: self.imagesUrlRoot!, oncomplete: completionHandler)
	}
	
	
	// MARK: - Public Methods; PlayAreaPaths
	
	public func displayPlayAreaPathAbilitiesForToken() {
		
		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: 				PlayAreaTokenWrapper? = PlayWrapper.current!.playAreaTokens!.values.first
		
		guard (playAreaTokenWrapper != nil) else { return }
		
		// Create completion handler
		let getPlayAreaCellWrapperCompletionHandler: ((CellWrapperBase?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			guard (wrapper != nil) else { return }
			
			let playAreaCellWrapper: 			PlayAreaCellWrapper = wrapper as! PlayAreaCellWrapper
			
			// Get playAreaPathAbilityWrappers
			let playAreaPathAbilityWrappers: 	[PlayAreaPathAbilityWrapper] = PlayAreaPathAbilitiesManager.getPlayAreaPathAbilities(for: playAreaTokenWrapper!, at: playAreaCellWrapper)
			
			// DEBUG:
			// Add some dummy abilityWrappers
			//playAreaPathAbilityWrappers.append(PlayAreaPathAbilityWrapper(playAreaPathAbilityType: PlayAreaPathAbilityTypeBase(type: .ByBus)))
			//playAreaPathAbilityWrappers.append(PlayAreaPathAbilityWrapper(playAreaPathAbilityType: PlayAreaPathAbilityTypeBase(type: .ByTram)))
			//playAreaPathAbilityWrappers.append(PlayAreaPathAbilityWrapper(playAreaPathAbilityType: PlayAreaPathAbilityTypeBase(type: .ByBike)))
			//playAreaPathAbilityWrappers.append(PlayAreaPathAbilityWrapper(playAreaPathAbilityType: PlayAreaPathAbilityTypeBase(type: .ByScooter)))
			
			// Set in playAreaTokenWrapper
			playAreaTokenWrapper!.set(playAreaPathAbilityWrappers: playAreaPathAbilityWrappers)
			
			// Go through each item
			for papaw in playAreaPathAbilityWrappers {
				
				if (papaw.canStartYN) {
					
					// Display button
					self.viewManager!.set(playAreaPathAbilityWrapper: papaw, visibleYN: true)
					
				}

			}
			
		}
		
		// Get playAreaCellWrapper
		self.getPlayAreaCellWrapper(for: playAreaTokenWrapper!, relativeMemberWrapper: RelativeMemberWrapper.current!, playGameID: playAreaTokenWrapper!.playGameID, playAreaID: "1", oncomplete: getPlayAreaCellWrapperCompletionHandler)
		
	}
	
	public func buildPlayAreaPath(for playAreaTokenWrapper: PlayAreaTokenWrapper, to toCellCoord: CellCoord, by playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any] = [String:Any]()
		
		// Create completion handler
		let loadPlayMovesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(result, error)
				
				return
				
			}
			
			// Merge to result
			result.merge(wrappers!) { (_, new) in new }
			
			// Call completion handler
			completionHandler(result, error)

		}
		
		// Create completion handler
		let doAfterLoadPlayMovesForPlayAreaPathCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaPathsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in

			guard (wrappers != nil && error == nil) else {
			
				// Call completion handler
				completionHandler(wrappers, error)
				
				return
				
			}
			
			// Check valid paths
			// Select path (ie. shortest)
			
			// Get playAreaPathWrappers
			let playAreaPathWrappers: 		[PlayAreaPathWrapper]? = wrappers!["PlayAreaPaths"] as? [PlayAreaPathWrapper]
			
			guard (playAreaPathWrappers != nil && playAreaPathWrappers!.count > 0) else {
				
				// Call completion handler
				completionHandler(nil, NSError())
				
				return
				
			}
			
			let papw: 						PlayAreaPathWrapper = playAreaPathWrappers!.first!
			
			// Set playAreaPathAbilityType
			papw.playAreaPathAbilityType 	= playAreaPathAbilityWrapper.playAreaPathAbilityType.type
			
			// Merge to result
			result.merge(wrappers!) { (_, new) in new }
			
			// Get playMoveWrappers
			let playMoveWrappers: 			[PlayMoveWrapper]? = wrappers!["PlayMoves"] as? [PlayMoveWrapper]
			
			if (playMoveWrappers == nil) {
				
				// Load playMoves
				self.loadPlayMoves(for: playAreaTokenWrapper, playAreaPathWrapper: papw, oncomplete: loadPlayMovesCompletionHandler)
				
			} else {
				
				// Process the loaded playMoveWrappers for playAreaPathWrapper
				self.doAfterLoadPlayMoves(for: papw, wrappers: result, oncomplete: doAfterLoadPlayMovesForPlayAreaPathCompletionHandler)
				
			}

		}
		
		// Load playAreaPaths
		self.loadPlayAreaPaths(for: playAreaTokenWrapper, to: toCellCoord, by: playAreaPathAbilityWrapper, oncomplete: loadPlayAreaPathsCompletionHandler)
		
	}
	
	public func loadPlayAreaPaths(for playAreaTokenWrapper: PlayAreaTokenWrapper, to toCellCoord: CellCoord, by playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get fromCellCoord
		let fromCellCoord: 					CellCoord = CellCoord(column: playAreaTokenWrapper.column, row: playAreaTokenWrapper.row)

		// Create completion handler
		let loadPlayAreaPathsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call completion handler
			completionHandler(wrappers, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaPathsFromLoadedPlayAreaCellsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in

			guard (error == nil) else {
			
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			var playAreaPathWrappers: 		[PlayAreaPathWrapper]? = nil
			
			if (wrappers != nil) {
				
				// Get playAreaPathWrappers
				playAreaPathWrappers 		= wrappers!["PlayAreaPaths"] as? [PlayAreaPathWrapper]
				
			}
			
			if (playAreaPathWrappers != nil && playAreaPathWrappers!.count > 0) {
				
				// Call completion handler
				completionHandler(wrappers, nil)
				
			} else {
				
				// Load PlayAreaPaths
				self.loadPlayAreaPaths(from: fromCellCoord, to: toCellCoord, by: playAreaPathAbilityWrapper, playGameID: playAreaTokenWrapper.playGameID, oncomplete: loadPlayAreaPathsCompletionHandler)
				
			}
			
		}
		
		// Load PlayAreaPaths from loaded PlayAreaCells
		self.loadPlayAreaPathsFromLoadedPlayAreaCells(from: fromCellCoord, to: toCellCoord, by: playAreaPathAbilityWrapper, oncomplete: loadPlayAreaPathsFromLoadedPlayAreaCellsCompletionHandler)
		
	}
	
	public func loadPlayAreaPaths(from fromCellCoord: CellCoord, to toCellCoord: CellCoord, by playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, playGameID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let loadPlayAreaPathsImagesCompletionHandler: (([PlayAreaPathWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayAreaPathsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playAreaPathWrappers
				let playAreaPathWrappers: 	[PlayAreaPathWrapper]? = wrappers!["PlayAreaPaths"] as? [PlayAreaPathWrapper]
				
				// Load images
				self.loadPlayAreaPathsImages(items: playAreaPathWrappers!, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayAreaPathsImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayAreaPathsFromDataSourceCompletionHandler: (([PlayAreaPathWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playAreaPathWrappers
				self.doAfterLoadPlayAreaPaths(oncomplete: doAfterLoadPlayAreaPathsCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayAreaPathsFromDataSource(from: fromCellCoord, to: toCellCoord, playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, playGameID: playGameID, oncomplete: loadPlayAreaPathsFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	public func checkIsValidPlayAreaPaths(playAreaPathWrappers: [PlayAreaPathWrapper], for playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {
		
		// TODO:
		
		// Go through each item
		//playAreaPathAbilityWrapper.isValidPath(playAreaPathWrapper: papw)
		
	}
	
	public func displayPlayAreaPath(playAreaPathWrapper: PlayAreaPathWrapper) {
		
		// Set isDisplayedYN
		playAreaPathWrapper.isDisplayedYN = true
		
		self.viewManager!.setPlayAreaPath(playAreaPathWrapper: playAreaPathWrapper, visibleYN: true)
	
	}
	
	public func hidePlayAreaPath() {
		
		// Get displayed playAreaPathWrapper
		let playAreaPathWrappers: 	[String:PlayAreaPathWrapper]? = PlayWrapper.current!.get(byIsDisplayedYN: true)
		
		guard (playAreaPathWrappers != nil && playAreaPathWrappers!.count > 0) else { return }
		
		let papw: 					PlayAreaPathWrapper = playAreaPathWrappers!.values.first!
		
		// Set isDisplayedYN
		papw.isDisplayedYN			= false
		
		self.viewManager!.setPlayAreaPath(playAreaPathWrapper: playAreaPathWrappers!.values.first!, visibleYN: false)
		
	}

	public func doAfterMoved(playAreaTokenWrapper: PlayAreaTokenWrapper, alongPath playAreaPathWrapper: PlayAreaPathWrapper) {
		
		// Set playAreaPathAbility
		self.setPlayAreaPathAbility(for: playAreaTokenWrapper, playAreaPathAbilityType: playAreaPathWrapper.playAreaPathAbilityType, isEngagedYN: false, isGoingYN: false)
		
		// Hide playAreaPath
		self.hidePlayAreaPath()
		
	}
	
	
	// MARK: - Public Methods; PlayAreaPathAbilities
	
	public func disengagePlayAreaPathAbilities() {
		
		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: 	PlayAreaTokenWrapper? = PlayWrapper.current!.playAreaTokens?.values.first
		
		guard (playAreaTokenWrapper != nil) else { return }
		
		// Get ByFoot PlayAreaPathAbilityWrapper
		let byFootPlayAreaPathAbilityWrapper: 		PlayAreaPathAbilityWrapper? = playAreaTokenWrapper!.playAreaPathAbilityWrappers.get(by: .ByFoot)

		if (byFootPlayAreaPathAbilityWrapper != nil && byFootPlayAreaPathAbilityWrapper!.isEngagedYN) {
			
			self.setPlayAreaPathAbility(for: playAreaTokenWrapper!, playAreaPathAbilityType: .ByFoot, isEngagedYN: false, isGoingYN: false)

		}
		
		PlayWrapper.current!.clearPlayAreaPaths()
		
	}
	
	public func setPlayAreaPathAbility(for playAreaTokenWrapper: PlayAreaTokenWrapper, playAreaPathAbilityType: PlayAreaPathAbilityTypes, isEngagedYN: Bool, isGoingYN: Bool) {

		// Get PlayAreaPathAbilityWrapper
		let playAreaPathAbilityWrapper:				PlayAreaPathAbilityWrapper? = playAreaTokenWrapper.playAreaPathAbilityWrappers.get(by: playAreaPathAbilityType)
		
		guard (playAreaPathAbilityWrapper != nil) else { return }

		// Set isEngagedYN
		playAreaPathAbilityWrapper!.isEngagedYN 	= isEngagedYN
		
		// Set isGoingYN
		playAreaPathAbilityWrapper!.isGoingYN 		= isGoingYN
		
		// Display playAreaPathAbility
		self.viewManager!.display(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper!, for: playAreaTokenWrapper)
		
	}
		
	public func getEngagedPlayAreaPathAbilityWrapper(for playAreaTokenWrapper: PlayAreaTokenWrapper) -> PlayAreaPathAbilityWrapper? {
		
		var result: PlayAreaPathAbilityWrapper? = nil
		
		// Go through each item
		for papaw in playAreaTokenWrapper.playAreaPathAbilityWrappers.items {
			
			if (papaw.isEngagedYN) {
			
				result = papaw
				
				continue
				
			}
			
		}
		
		return result
		
	}
	
	
	// MARK: - Public Methods; PlayMoves
	
	public func loadPlayMoves(for playAreaTileWrapper: PlayAreaTileWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {

		var result: [String:Any]? = nil
		
		// Create completion handler
		let loadPlayMovesImagesCompletionHandler: (([PlayMoveWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayMovesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playMoveWrappers
				let playMoveWrappers: 	[PlayMoveWrapper]? = wrappers!["PlayMoves"] as? [PlayMoveWrapper]
				
				// Set PlayReferenceData
				self.doSetPlayMovesPlayReferenceData(playMoveWrappers: playMoveWrappers!, for: playAreaTileWrapper)
				
				// Load images
				self.loadPlayMovesImages(items: playMoveWrappers!, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayMovesImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayMovesFromDataSourceCompletionHandler: (([PlayMoveWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playMoveWrappers
				self.doAfterLoadPlayMoves(oncomplete: doAfterLoadPlayMovesCompletionHandler)

			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayMovesFromDataSource(for: playAreaTileWrapper, oncomplete: loadPlayMovesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}

	public func loadPlayMoves(for playAreaTokenWrapper: PlayAreaTokenWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let loadPlayMovesImagesCompletionHandler: (([PlayMoveWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayMovesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playMoveWrappers
				let playMoveWrappers: 	[PlayMoveWrapper]? = wrappers!["PlayMoves"] as? [PlayMoveWrapper]
				
				// Load images
				self.loadPlayMovesImages(items: playMoveWrappers!, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayMovesImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayMovesFromDataSourceCompletionHandler: (([PlayMoveWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playMoveWrappers
				self.doAfterLoadPlayMoves(oncomplete: doAfterLoadPlayMovesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayMovesFromDataSource(for: playAreaTokenWrapper, oncomplete: loadPlayMovesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}

	public func loadPlayMoves(for playAreaTokenWrapper: PlayAreaTokenWrapper, playAreaPathWrapper: PlayAreaPathWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let doAfterLoadPlayMovesForPlayAreaPathCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let loadPlayMovesImagesCompletionHandler: (([PlayMoveWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			guard (error == nil) else {
			
				// Call completion handler
				completionHandler(result, error)
				
				return
				
			}

			// Process the loaded playMoveWrappers for playAreaPathWrapper
			self.doAfterLoadPlayMoves(for: playAreaPathWrapper, wrappers: result!, oncomplete: doAfterLoadPlayMovesForPlayAreaPathCompletionHandler)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayMovesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playMoveWrappers
				let playMoveWrappers: 	[PlayMoveWrapper]? = wrappers!["PlayMoves"] as? [PlayMoveWrapper]
				
				// Load images
				self.loadPlayMovesImages(items: playMoveWrappers!, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayMovesImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayMovesFromDataSourceCompletionHandler: (([PlayMoveWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playMoveWrappers
				self.doAfterLoadPlayMoves(oncomplete: doAfterLoadPlayMovesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayMovesFromDataSource(for: playAreaTokenWrapper, playAreaPathWrapper: playAreaPathWrapper, oncomplete: loadPlayMovesFromDataSourceCompletionHandler)

		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	
	// MARK: - Public Methods; PlayChallenges
	
	public func loadPlayChallenge(for playChallengeID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let processLoadPlayChallengesRelationalDataImagesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in

			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayChallengesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Load images
				self.processLoadPlayChallengesRelationalDataImages(wrappers: result!, urlRoot: self.imagesUrlRoot!, oncomplete: processLoadPlayChallengesRelationalDataImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayChallengesFromDataSourceCompletionHandler: (([PlayChallengeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playChallengeWrappers
				self.doAfterLoadPlayChallenges(oncomplete: doAfterLoadPlayChallengesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayChallengesFromDataSource(for: playChallengeID, oncomplete: loadPlayChallengesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	public func loadPlayChallenges(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, isActiveYN: Bool, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let processLoadPlayChallengesRelationalDataImagesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayChallengesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Load images
				self.processLoadPlayChallengesRelationalDataImages(wrappers: result!, urlRoot: self.imagesUrlRoot!, oncomplete: processLoadPlayChallengesRelationalDataImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayChallengesFromDataSourceCompletionHandler: (([PlayChallengeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playChallengeWrappers
				self.doAfterLoadPlayChallenges(oncomplete: doAfterLoadPlayChallengesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayChallengesFromDataSource(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, isActiveYN: isActiveYN, oncomplete: loadPlayChallengesFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	public func displayPlayActiveChallenge() {
	
		// Get active playChallengeWrappers
		let playChallengeWrappers: [String:PlayChallengeWrapper] = PlayWrapper.current!.get(byIsActiveYN: true)
		
		if (playChallengeWrappers.count > 0) {
			
			// Display playChallengeWrapper
			self.viewManager!.displayPlayActiveChallenge(playChallengeWrapper: playChallengeWrappers.values.first!)
			
			// Notify the delegate
			self.delegate!.mainDisplayControlManager(playActiveChallengeLoaded: playChallengeWrappers.values.first!, sender: self)
			
		} else {

			// Notify the delegate
			self.delegate!.mainDisplayControlManager(playActiveChallengeLoaded: nil, sender: self)
			
		}
		
	}
	
	public func setPlayActiveChallenge(playChallengeWrapper: PlayChallengeWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Check active PlayChallenge
		let playChallengeWrappers: 			[String:PlayChallengeWrapper] = PlayWrapper.current!.get(byIsActiveYN: true)
		
		// Get activePlayChallengeWrapper
		let activePlayChallengeWrapper: 	PlayChallengeWrapper? = playChallengeWrappers.values.first

		// Create completion handler
		let doAbortActivePlayChallengeCompletionHandler: ((Error?) -> Void) =
		{
			[unowned self] (error) -> Void in
			
			guard (error == nil) else {
				
				// Call the completion handler
				completionHandler(error)
				
				return
				
			}
			
			// Set active PlayChallenge
			self.doSetActivePlayChallenge(playChallengeWrapper: playChallengeWrapper, oncomplete: completionHandler)
			
		}
		
		// Create completion handler
		let shouldAbortPlayActiveChallengeCompletionHandler: ((Bool, Error?) -> Void) =
		{
			[unowned self] (result, error) -> Void in

			guard (error == nil) else {
			
				// Call the completion handler
				completionHandler(error)
				
				return
				
			}
			
			if (result) {
				
				// Abort active PlayChallenge
				self.doAbortActivePlayChallenge(playChallengeWrapper: activePlayChallengeWrapper!, oncomplete: doAbortActivePlayChallengeCompletionHandler)
				
			}
			
		}
		
		if (activePlayChallengeWrapper != nil) {
			
			// Notify the delegate
			self.delegate!.mainDisplayControlManager(shouldAbortPlayActiveChallenge: activePlayChallengeWrapper!, oncomplete: shouldAbortPlayActiveChallengeCompletionHandler)
			
		} else {
			
			// Set active PlayChallenge
			self.doSetActivePlayChallenge(playChallengeWrapper: playChallengeWrapper, oncomplete: completionHandler)
			
		}
		
	}
	
	public func clearPlayChallenges(byIsActiveYN isActiveYN: Bool) {
	
		PlayWrapper.current!.clear(playChallengesByIsActiveYN: isActiveYN)
		
	}

	public func checkPlayChallengesCompleted() -> [PlayChallengeWrapper]? {
		
		var result: 			[PlayChallengeWrapper] = [PlayChallengeWrapper]()
		
		// Get active playChallenges
		let playChallenges: 	[String: PlayChallengeWrapper] = PlayWrapper.current!.get(byIsActiveYN: true)
		
		guard (playChallenges.count > 0) else { return nil }
		
		let pcw: 				PlayChallengeWrapper = playChallenges.values.first!
		
		guard (pcw.playChallengeObjectives != nil) else { return nil }
		
		var isCompleteYN: 		Bool = true
		
		// Go through each playChallengeObjective
		for pcow in pcw.playChallengeObjectives!.values {
			
			// Check isAchievedYN
			if (!pcow.isAchievedYN) {
				
				isCompleteYN 	= false
				
			}
			
		}
		
		// Check isCompleteYN
		if (isCompleteYN) {
			
			pcw.isCompleteYN 	= true
			pcw.status 			= ModelItemStatusTypes.modified
			
			// Add it to the collection
			result.append(pcw)
			
		}
		
		return result
		
	}
	
	public func checkPlayChallengeObjectivesCompleted(by playExperienceWrapper: PlayExperienceWrapper) -> [PlayChallengeObjectiveWrapper]? {
		
		var result: 				[PlayChallengeObjectiveWrapper] = [PlayChallengeObjectiveWrapper]()
		
		// Check playChallengeObjectiveDefinitionDataWrapper in playExperienceWrapper
		guard (playExperienceWrapper.playChallengeObjectiveDefinitionDataWrapper != nil) else { return nil }
		
		// Get active playChallenges
		let playChallenges: 		[String: PlayChallengeWrapper] = PlayWrapper.current!.get(byIsActiveYN: true)
		
		guard (playChallenges.count > 0) else { return nil }
		
		let pcw: 					PlayChallengeWrapper = playChallenges.values.first!
		
		guard (pcw.playChallengeObjectives != nil) else { return nil }
		
		// Go through each playChallengeObjective
		for pcow in pcw.playChallengeObjectives!.values {
			
			guard (!pcow.isAchievedYN) else { continue }
			
			// Check is achieved
			let isAchievedYN: 		Bool = pcow.checkIsAchieved(with: playExperienceWrapper.playChallengeObjectiveDefinitionDataWrapper!)
			
			if (isAchievedYN) {
				
				pcow.isAchievedYN 	= true
				pcow.status 		= ModelItemStatusTypes.modified
				
				// Add it to the collection
				result.append(pcow)
				
			}
			
		}
		
		return result
		
	}
	
	public func checkPlayChallengeObjectivesCompleted(by playExperienceStepWrapper: PlayExperienceStepWrapper) -> [PlayChallengeObjectiveWrapper]? {
		
		var result: 			[PlayChallengeObjectiveWrapper] = [PlayChallengeObjectiveWrapper]()
		
		// Check playChallengeObjectiveDefinitionDataWrapper in playExperienceStepWrapper
		guard (playExperienceStepWrapper.playChallengeObjectiveDefinitionDataWrapper != nil) else { return nil }
		
		// Get active playChallenges
		let playChallenges: 	[String: PlayChallengeWrapper] = PlayWrapper.current!.get(byIsActiveYN: true)
		
		guard (playChallenges.count > 0) else { return nil }
		
		let pcw: 				PlayChallengeWrapper = playChallenges.values.first!
		
		guard (pcw.playChallengeObjectives != nil) else { return nil }
		
		// Go through each playChallengeObjective
		for pcow in pcw.playChallengeObjectives!.values {
			
			guard (!pcow.isAchievedYN) else { continue }
			
			// Check is achieved
			let isAchievedYN: 	Bool = pcow.checkIsAchieved(with: playExperienceStepWrapper.playChallengeObjectiveDefinitionDataWrapper!)
			
			if (isAchievedYN) {
			
				pcow.isAchievedYN = true
				
				// Add it to the collection
				result.append(pcow)

			}
			
		}

		return result
		
	}

	public func doAfterPlayChallengesCompleted(playChallengeWrappers: [PlayChallengeWrapper], oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let savePlayResultCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Create completion handler
		let savePlayChallengesCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			guard (error == nil) else {
				
				// Call completion handler
				completionHandler(error)
				
				return
				
			}
			
			self.getPlayResultModelAdministrator().initialise()
			
			// Set playGame result
			self.doSetPlayResultPlayGame(fromPlayChallenges: playChallengeWrappers)
			
			// Save playResult
			self.savePlayResult(for: self.playGameWrapper!, oncomplete: savePlayResultCompletionHandler)
			
		}
		
		// Create completion handler
		let doRemovePlayActiveChallengeCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			guard (error == nil) else {
				
				// Call completion handler
				completionHandler(error)
				
				return
				
			}
			
			// Save playChallenges
			self.savePlayChallenges(wrappers: playChallengeWrappers, oncomplete: savePlayChallengesCompletionHandler)
			
		}
		
		// Remove active playChallenge
		self.doRemovePlayActiveChallenge(playChallengeWrapper: playChallengeWrappers.first!, doSaveYN: false, oncomplete: doRemovePlayActiveChallengeCompletionHandler)

	}
	
	public func doAfterPlayChallengeObjectivesCompleted(playChallengeObjectiveWrappers: [PlayChallengeObjectiveWrapper], oncomplete completionHandler:@escaping (Error?) -> Void) {
	
		// Create completion handler
		let savePlayResultCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Create completion handler
		let savePlayChallengeObjectivesCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			guard (error == nil) else {
				
				// Call completion handler
				completionHandler(error)
				
				return
				
			}
			
			self.getPlayResultModelAdministrator().initialise()
			
			// Set playGame result
			self.doSetPlayResultPlayGame(fromPlayChallengeObjectives: playChallengeObjectiveWrappers)
			
			// Save playResult
			self.savePlayResult(for: self.playGameWrapper!, oncomplete: savePlayResultCompletionHandler)
			
		}
		
		// Save playChallengeObjectives
		self.savePlayChallengeObjectives(wrappers: playChallengeObjectiveWrappers, oncomplete: savePlayChallengeObjectivesCompletionHandler)
		
	}
	
	
	// MARK: - Public Methods; PlayExperiences
	
	public func loadPlayExperience(forPlayMove playMoveWrapper: PlayMoveWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let loadPlayExperiencesImagesCompletionHandler: ((PlayExperienceWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayExperienceCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get playExperienceWrappers
				let playExperienceWrappers: 	[PlayExperienceWrapper]? = wrappers!["PlayExperiences"] as? [PlayExperienceWrapper]
				
				// Check playExperienceWrappers
				guard (playExperienceWrappers != nil && playExperienceWrappers!.count > 0) else {
					
					// Call completion handler
					completionHandler(result, error)
					return
					
				}
				
				// Load images
				self.loadPlayExperienceImages(for: playExperienceWrappers!.first!, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayExperiencesImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayExperienceFromDataSourceCompletionHandler: (([PlayExperienceWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playExperienceWrappers
				self.doAfterLoadPlayExperience(oncomplete: doAfterLoadPlayExperienceCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
	
			// Load from data source
			self.loadPlayExperienceFromDataSource(for: playMoveWrapper, oncomplete: loadPlayExperienceFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	public func displayPlayExperience(wrapper: PlayExperienceWrapper, delegate: ProtocolPlayExperienceViewDelegate) {
		
		DispatchQueue.main.async {
			
			// Create PlayExperienceView
			let playExperienceView: ProtocolPlayExperienceView = self.doCreatePlayExperienceView(wrapper: wrapper, delegate: delegate)
			
			// Present PlayExperienceView
			self.viewManager!.present(playExperienceView: playExperienceView)

		}
		
	}
	
	public func displayPlayExperienceStep(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, delegate: ProtocolPlayExperienceStepViewDelegate) {

		DispatchQueue.main.async {
			
			// Create PlayExperienceStepView
			let playExperienceStepView: ProtocolPlayExperienceStepView = self.doCreatePlayExperienceStepView(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper, delegate: delegate)

			// Present PlayExperienceStepView
			self.viewManager!.present(playExperienceStepView: playExperienceStepView)

		}
		
	}
	
	public func doAfterPlayExperienceCompleted(wrapper: PlayExperienceWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Check PlayExperienceResult
		guard (wrapper.playExperienceResult != nil) else {
			
			// Call completion handler
			completionHandler(NSError())
			
			return
			
		}
		
		self.getPlayResultModelAdministrator().initialise()
		
		self.doSetPlayResultPlayGame(fromResult: wrapper)
		self.doSetPlayResultPlayAreaTile(fromResult: wrapper)
		self.doSetPlayResultPlayExperienceSteps(fromResult: wrapper)
		
		// Get playResult
		if let prw = PlayWrapper.current?.playResult {
			
			prw.relativeMemberID 	= RelativeMemberWrapper.current!.id
			
			// Generate the JSON data to be saved
			prw.generateJSON()
			
			// Create PlayResult model item
			let item: 				PlayResult = self.createPlayResultModelItem()
			
			item.clone(fromWrapper: prw)
			
		}

		// Create completion handler
		let saveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			if (error == nil) {
				
				// Clear playResult
				PlayWrapper.current?.playResult.clear()
				
			}
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDataToCacheYN")) {
				
				// Save to cache
				self.savePlayAreaTileDataToCache(relativeMemberID: self.playGameWrapper!.playGameData!.relativeMemberID, playGameID: self.playGameWrapper!.id, playAreaID: "1")
				
				// Call completion handler
				saveCompletionHandler(nil)
				
				return
				
			}
			
			if (ApplicationFlags.flag(key: "SavePlayResultDummyDataYN")) {
				
				self.doDummySaveResult(oncomplete: saveCompletionHandler)
				return
				
			}
			
		#endif
		
		// Save data
		self.getPlayResultModelAdministrator().save(oncomplete: saveCompletionHandler)
		
	}
	
	
	// MARK: - Public Methods; PlayExperienceSteps
	
	public func loadPlayExperienceStep(for playExperienceStepID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any]? = nil
		
		// Create completion handler
		let loadPlayExperienceStepImagesCompletionHandler: ((PlayExperienceStepWrapper?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			// Call completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let doAfterLoadPlayExperienceStepCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil && error == nil) {
				
				result = wrappers
				
				// Get PlayExperienceStepWrapper
				let wrapper: PlayExperienceStepWrapper = PlayWrapper.current!.playExperienceSteps![playExperienceStepID]!
				
				// Load images
				self.loadPlayExperienceStepImages(for: wrapper, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayExperienceStepImagesCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
		}
		
		// Create completion handler
		let loadPlayExperienceStepFromDataSourceCompletionHandler: (([PlayExperienceStepWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (items != nil && error == nil) {
				
				// Process the loaded playExperienceStepWrappers
				self.doAfterLoadPlayExperienceStep(oncomplete: doAfterLoadPlayExperienceStepCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Load from data source
			self.loadPlayExperienceStepFromDataSource(for: playExperienceStepID, oncomplete: loadPlayExperienceStepFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	
	// MARK: - Override Methods
	
	public override func onSignOutSuccessful(userProperties: UserProperties) {
		
		self.unloadUserProfile()
		self.unloadRelativeMember()
		
		// Notify the delegates
		delegate?.mainDisplayControlManager(signOutSuccessful: userProperties)

	}
	
	public override func onSignOutFailed(userProperties: 	UserProperties?,
	                                     error: 			Error?,
	                                     code: 				AuthenticationErrorCodes?) {
		
		self.unloadUserProfile()
		self.unloadRelativeMember()
		
		// Notify the delegates
		delegate?.mainDisplayControlManager(signOutFailed: userProperties)
		
	}
	
	public override func onUserPropertiesPhotoLoaded(userProperties: UserProperties) {
		
		let image: UIImage = UIImage(data: userProperties.photoData!)!
		
		DispatchQueue.main.async {
			
			self.viewManager!.displayAvatar(image: image)
			
		}
		
	}

	public override func onSocialManager(item: RelativeMemberWrapper, loadedAvatarImage sender: SocialManager) {
		
		// Notify the delegate
		self.delegate?.mainDisplayControlManager(item: item, loadedAvatarImage: self)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func displayError(_ error: Error?) {
		
		let message: String = "An error occurred: \(error.debugDescription)"
		
		self.viewManager!.displayUserInfo(message: message)
	}
	
	fileprivate func onUserProfileWrapperLoadSuccessful(userProfileWrapper: UserProfileWrapper) {
		
		// Notify the delegate
		self.delegate?.mainDisplayControlManager(userProfileWrapperLoadSuccessful: userProfileWrapper)
		
		DispatchQueue.main.async {
			
			self.displayUserInfo()
			self.displayAvatar()
		}
		
	}

	fileprivate func onUserProfileWrapperLoadFailed(error: Error?, code: UserProfileWrapperErrorCodes) {
		
		// Notify the delegate
		self.delegate?.mainDisplayControlManager(userProfileWrapperLoadFailed: error, code: code)
		
	}

	fileprivate func doCreatePlayExperienceView(wrapper: PlayExperienceWrapper, delegate: ProtocolPlayExperienceViewDelegate) -> ProtocolPlayExperienceView {
		
		// Notify the delegate
		return self.delegate!.mainDisplayControlManager(createPlayExperienceViewFor: wrapper, delegate: delegate)
		
	}
	
	fileprivate func doCreatePlayExperienceStepView(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, delegate: ProtocolPlayExperienceStepViewDelegate) -> ProtocolPlayExperienceStepView {
		
		// Notify the delegate
		return self.delegate!.mainDisplayControlManager(createPlayExperienceStepViewFor: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper, delegate: delegate)

	}

	
	// MARK: - Private Methods; PlayResult
	
	fileprivate func doSetPlayResultPlayGame(fromResult playExperienceWrapper: PlayExperienceWrapper) {
		
		// Get PlayGameWrapper
		let pgw: 	PlayGameWrapper? = PlayWrapper.current?.playGames![self.playGameWrapper!.id]
		
		guard (pgw != nil) else { return }
		guard (pgw!.playGameData != nil) else { return }
		
		let w: 		PlayGameDataOnCompleteDataWrapper? = pgw!.playGameData!.playGameDataOnCompleteData!

		// Append points
		w!.appendPoints(from: playExperienceWrapper.playExperienceResult!.playExperienceOnCompleteData!)

		// Serialize onCompleteData
		pgw!.playGameData!.serializeOnCompleteData()
		
		// Set in playResult
		PlayWrapper.current?.playResult.set(playGameWrapper: pgw!)
		PlayWrapper.current?.playResult.set(playGameDataWrapper: pgw!.playGameData!)
		
	}
	
	fileprivate func doSetPlayResultPlayGame(fromPlayChallenges playChallengeWrappers: [PlayChallengeWrapper]) {
		
		// Get PlayGameWrapper
		let pgw: 	PlayGameWrapper? = PlayWrapper.current?.playGames![self.playGameWrapper!.id]
		
		guard (pgw != nil) else { return }
		guard (pgw!.playGameData != nil) else { return }
		
		let w: 		PlayGameDataOnCompleteDataWrapper? = pgw!.playGameData!.playGameDataOnCompleteData!
		
		// Go through each item
		for pcw in playChallengeWrappers {
			
			w!.numberOfFeathers += pcw.playChallengeTypeWrapper!.playChallengeTypeOnCompleteData!.numberOfFeathers
			w!.numberOfPoints 	+= pcw.playChallengeTypeWrapper!.playChallengeTypeOnCompleteData!.numberOfPoints
			
		}
		
		// Serialize onCompleteData
		pgw!.playGameData!.serializeOnCompleteData()

		// Set in playResult
		PlayWrapper.current?.playResult.set(playGameWrapper: pgw!)
		PlayWrapper.current?.playResult.set(playGameDataWrapper: pgw!.playGameData!)
		
	}
	
	fileprivate func doSetPlayResultPlayGame(fromPlayChallengeObjectives playChallengeObjectiveWrappers: [PlayChallengeObjectiveWrapper]) {
		
		// Get PlayGameWrapper
		let pgw: 	PlayGameWrapper? = PlayWrapper.current?.playGames![self.playGameWrapper!.id]
		
		guard (pgw != nil) else { return }
		guard (pgw!.playGameData != nil) else { return }
		
		let w: 		PlayGameDataOnCompleteDataWrapper? = pgw!.playGameData!.playGameDataOnCompleteData!
		
		// Go through each item
		for pcow in playChallengeObjectiveWrappers {
			
			w!.numberOfFeathers += pcow.playChallengeObjectiveTypeWrapper!.playChallengeObjectiveTypeOnCompleteData!.numberOfFeathers
			w!.numberOfPoints 	+= pcow.playChallengeObjectiveTypeWrapper!.playChallengeObjectiveTypeOnCompleteData!.numberOfPoints
			
		}
		
		// Serialize onCompleteData
		pgw!.playGameData!.serializeOnCompleteData()
		
		// Set in playResult
		PlayWrapper.current?.playResult.set(playGameWrapper: pgw!)
		PlayWrapper.current?.playResult.set(playGameDataWrapper: pgw!.playGameData!)
		
	}
	
	fileprivate func doSetPlayResultPlayAreaTile(fromResult playExperienceWrapper: PlayExperienceWrapper) {
		
		guard (playExperienceWrapper.playMove!.playReferenceType == .PlayAreaTile) else { return }
		
		//let patw: PlayAreaTileWrapper? = PlayWrapper.current?.playAreaTiles?[playExperienceWrapper.playMove!.playReferenceID]
		
		// DEBUG:
		let patw: 		PlayAreaTileWrapper? = PlayWrapper.current?.playAreaTiles?.first?.value
		
		guard (patw != nil) else { return }
		guard (patw!.playAreaTileData != nil) else { return }
		
		let w: 			PlayAreaTileDataOnCompleteDataWrapper? = patw!.playAreaTileData!.playAreaTileDataOnCompleteData!
		
		// Append points
		w!.appendPoints(from: playExperienceWrapper.playExperienceResult!.playExperienceOnCompleteData!)

		// Serialize onCompleteData
		patw!.playAreaTileData!.serializeOnCompleteData()
		
		// Get PlayAreaTileData
		let patd: 		PlayAreaTileData? = self.getPlayAreaTileDataModelAdministrator().collection?.getItem(id: patw!.playAreaTileData!.id) as? PlayAreaTileData
		
		// Update PlayAreaTileData
		if (patd != nil) {
			
			patd!.clone(fromWrapper: patw!.playAreaTileData!)
			
		}
		
		// Set in playResult
		PlayWrapper.current?.playResult.set(playAreaTileWrapper: patw!)
		PlayWrapper.current!.playResult.set(playAreaTileDataWrapper: patw!.playAreaTileData!)
		
	}
	
	fileprivate func doSetPlayResultPlayExperienceSteps(fromResult playExperienceWrapper: PlayExperienceWrapper) {
		
		// Go through each item
		for pesw in playExperienceWrapper.playExperienceSteps().values {
			
			// Set in playResult
			PlayWrapper.current?.playResult.set(playExperienceStepResultWrapper: pesw.playExperienceStepResult!)
			
		}
		
		// Clear PlayExperienceSteps
		//playExperienceWrapper.clearPlayExperienceSteps()
		
	}
	
	
	// MARK: - Private Methods; PlaySubsets
	
	fileprivate func doAfterLoadPlaySubsets(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 				[String:Any] = [String:Any]()
		
		// Get the PlaySubsetWrappers
		let playSubsetWrappers:		[PlaySubsetWrapper] = self.getPlaySubsetModelAdministrator().toWrappers()
		result[self.getPlaySubsetModelAdministrator().tableName] = playSubsetWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	
	// MARK: - Private Methods; PlayGames
	
	fileprivate func doClearPlayGame() {
	
		if (self.playGameWrapper != nil) {
			
			// Clear PlayWrapper playGame
			PlayWrapper.current?.clear(playGame: self.playGameWrapper!)
			
		}

		self.playGameWrapper = nil
		
	}
	
	fileprivate func loadPlayGamesFromCache(for relativeMemberWrapper: RelativeMemberWrapper, loadLatestOnlyYN: Bool, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create completion handler
		let loadPlayGameDataFromCacheCompletionHandler: (([PlayGameDataWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			guard (items != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Process the loaded playGameWrappers
			self.doAfterLoadPlayGames(oncomplete: completionHandler)
			
		}
		
		// Create completion handler
		let loadPlayGamesFromCacheCompletionHandler: (([PlayGameWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			guard (items != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			guard (items!.count > 0) else {
				
				// Process the loaded playGameWrappers
				self.doAfterLoadPlayGames(oncomplete: completionHandler)
				
				return
				
			}
			
			// Get playGameID
			let playGameID: String = items!.first!.id
			
			// Load PlayGameData from cache
			self.loadPlayGameDataFromCache(for: relativeMemberWrapper, playGameID: playGameID, oncomplete: loadPlayGameDataFromCacheCompletionHandler)
		}
		
		// Load PlayGames from cache
		self.loadPlayGamesFromCache(for: relativeMemberWrapper, loadLatestOnlyYN: loadLatestOnlyYN, oncomplete: loadPlayGamesFromCacheCompletionHandler)
		
	}
	
	fileprivate func loadPlayGamesFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create completion handler
		let loadPlayGameDataFromCacheCompletionHandler: (([PlayGameDataWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			guard (items != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Process the loaded playGameWrappers
			self.doAfterLoadPlayGames(oncomplete: completionHandler)
			
		}
		
		// Create completion handler
		let loadPlayGamesFromCacheCompletionHandler: (([PlayGameWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			guard (items != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			guard (items!.count > 0) else {
				
				// Process the loaded playGameWrappers
				self.doAfterLoadPlayGames(oncomplete: completionHandler)
				
				return
				
			}
			
			// Load PlayGameData from cache
			self.loadPlayGameDataFromCache(for: relativeMemberWrapper, playGameID: playGameID, oncomplete: loadPlayGameDataFromCacheCompletionHandler)
			
		}
		
		// Load PlayGames from cache
		self.loadPlayGamesFromCache(for: relativeMemberWrapper, playGameID: playGameID, oncomplete: loadPlayGamesFromCacheCompletionHandler)
		
	}
	
	fileprivate func doAfterLoadPlayGames(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 					[String:Any] = [String:Any]()
		
		// Get the PlayGamesWrappers
		let playGameWrappers: 			[PlayGameWrapper] = self.loadedPlayGamesToWrappers(appendYN: true)
		
		result[self.getPlayGameModelAdministrator().tableName] 			= playGameWrappers
		
		// Get the PlayGameDataWrappers
		let playGameDataWrappers: 		[PlayGameDataWrapper] = self.loadedPlayGameDataToWrappers(appendYN: true)
		
		result[self.getPlayGameDataModelAdministrator().tableName] 		= playGameDataWrappers
		
		// Get the PlayAreaTokenWrappers
		let playAreaTokenWrappers: 		[PlayAreaTokenWrapper] = self.loadedPlayAreaTokensToWrappers()
		
		result[self.getPlayAreaTokenModelAdministrator().tableName] 	= playAreaTokenWrappers
		
		// Get the PlayAreaCellTypeWrappers
		let playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper] = self.loadedPlayAreaCellTypesToWrappers(appendYN: true)
		
		result[self.getPlayAreaCellTypeModelAdministrator().tableName] 	= playAreaCellTypeWrappers

		// Get the PlayAreaCellWrappers
		let playAreaCellWrappers: 		[PlayAreaCellWrapper] = self.loadedPlayAreaCellsToWrappers()
		
		result[self.getPlayAreaCellModelAdministrator().tableName] 		= playAreaCellWrappers
		
		// Get the PlayAreaTileTypeWrappers
		let playAreaTileTypeWrappers: 	[PlayAreaTileTypeWrapper] = self.loadedPlayAreaTileTypesToWrappers(appendYN: true)
		
		result[self.getPlayAreaTileTypeModelAdministrator().tableName] 	= playAreaTileTypeWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	fileprivate func checkLoadedPlayGameRelationalData(wrappers: [String:Any], state: CheckLoadedPlayGameRelationalDataWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let _wrappers: 			[String:Any] = wrappers

		// Create completion handler
		let doCheckLoadedPlayGameRelationalDataCompletionHandler: (([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void) =
		{
			(wrappers, state, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(wrappers, error)
				
				return
				
			}
			
			// Check relational data
			self.checkLoadedPlayGameRelationalData(wrappers: wrappers!, state: state, oncomplete: completionHandler)
			
		}
		
		// Create completion handler
		let doCheckLoadedPlayGameRelationalDataOnFinishedCompletionHandler: (([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void) =
		{
			(wrappers, state, error) -> Void in
			
			// Call completion handler
			completionHandler(wrappers, error)
			
		}
		
		// Check relational data
		self.DO_NOT_DELETE_YET_doCheckLoadedPlayGameRelationalData(	wrappers: _wrappers,
													 state: state,
													 oncomplete: doCheckLoadedPlayGameRelationalDataCompletionHandler,
													 onfinished: doCheckLoadedPlayGameRelationalDataOnFinishedCompletionHandler)
		
	}
	
	
	
	// DO NOT DELETE YET //
	fileprivate func DO_NOT_DELETE_YET_doCheckLoadedPlayGameRelationalData(wrappers: [String:Any], state: CheckLoadedPlayGameRelationalDataWrapper, oncomplete completionHandler:@escaping ([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void, onfinished onFinishedCompletionHandler:@escaping ([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void) {
		
		var _wrappers: 			[String:Any] = wrappers
		
		// Get playGameWrappers
		let _playGameWrappers: 	[PlayGameWrapper]? = _wrappers["PlayGames"] as? [PlayGameWrapper]
		
		guard (_playGameWrappers != nil && _playGameWrappers!.count > 0) else {
			
			// Call completion handler
			completionHandler(_wrappers, state, NSError())
			
			return
			
		}
		
		// Get playAreaCellTypeWrappers
		let _playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper]? = _wrappers["PlayAreaCellTypes"] as? [PlayAreaCellTypeWrapper]
		
		// Get playAreaTileTypeWrappers
		let _playAreaTileTypeWrappers: 	[PlayAreaTileTypeWrapper]? = _wrappers["PlayAreaTileTypes"] as? [PlayAreaTileTypeWrapper]
		
		// Get playAreaCellWrappers
		var _playAreaCellWrappers: 		[PlayAreaCellWrapper]? = _wrappers["PlayAreaCells"] as? [PlayAreaCellWrapper]

		// Get playAreaTokenWrappers
		var _playAreaTokenWrappers: 	[PlayAreaTokenWrapper]? = _wrappers["PlayAreaTokens"] as? [PlayAreaTokenWrapper]

		// Get playChallengeWrappers
		let _playChallengeWrappers: 	[PlayChallengeWrapper]? = _wrappers["PlayChallenges"] as? [PlayChallengeWrapper]
		
		// Create completion handler
		let loadPlayChallengesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Get playChallengeWrappers
			let playChallengeWrappers: 	[PlayChallengeWrapper]? = wrappers!["PlayChallenges"] as? [PlayChallengeWrapper]
			
			_wrappers["PlayChallenges"] = playChallengeWrappers
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Create completion handler
		let addTokenCompletionHandler: ((PlayAreaTokenWrapper?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			if (wrapper != nil) {
				
				_playAreaTokenWrappers!.append(wrapper!)
				_wrappers["PlayAreaTokens"] = _playAreaTokenWrappers
				
			}
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaTokensImagesCompletionHandler: (([PlayAreaTokenWrapper]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaTokensCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Get playAreaTokenWrappers
			let playAreaTokenWrappers: 	[PlayAreaTokenWrapper]? = wrappers!["PlayAreaTokens"] as? [PlayAreaTokenWrapper]
			
			// Check playAreaTokenWrappers
			if (playAreaTokenWrappers == nil || playAreaTokenWrappers!.count == 0) {
				
				// Add playAreaToken
				self.addToken(for: _playGameWrappers!.first!, oncomplete: addTokenCompletionHandler)
				
			} else {
				
				_wrappers["PlayAreaTokens"] = playAreaTokenWrappers
				
				// Call completion handler
				completionHandler(_wrappers, state, error)
				
			}
			
		}
		
		// Create completion handler
		let addStartCellCompletionHandler: ((PlayAreaCellWrapper?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			if (wrapper != nil) {
				
				_playAreaCellWrappers!.append(wrapper!)
				_wrappers["PlayAreaCells"] = _playAreaCellWrappers
				
			}
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaCellsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Get playAreaCellWrappers
			let playAreaCellWrappers: 	[PlayAreaCellWrapper]? = wrappers!["PlayAreaCells"] as? [PlayAreaCellWrapper]
			
			// Check playAreaCellWrappers
			if (playAreaCellWrappers == nil || playAreaCellWrappers!.count == 0) {
				
				// Add playAreaCell 'StartCell'
				self.addStartCell(for: _playGameWrappers!.first!, oncomplete: addStartCellCompletionHandler)
				
			} else {
				
				_wrappers["PlayAreaCells"] = playAreaCellWrappers
				
				// Call completion handler
				completionHandler(_wrappers, state, error)
				
			}
			
		}
		
		// Create completion handler
		let loadPlayAreaCellTypesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil) {
				
				// Get playAreaCellTypeWrappers
				let playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper]? = wrappers!["PlayAreaCellTypes"] as? [PlayAreaCellTypeWrapper]
				
				_wrappers["PlayAreaCellTypes"] = playAreaCellTypeWrappers
				
			}
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaTileTypesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			state.didLoadPlayAreaTileTypesYN = true
			
			if (wrappers != nil) {
				
				// Get playAreaTileTypeWrappers
				let playAreaTileTypeWrappers: 	[PlayAreaTileTypeWrapper]? = wrappers!["PlayAreaTileTypes"] as? [PlayAreaTileTypeWrapper]
				
				_wrappers["PlayAreaTileTypes"] = playAreaTileTypeWrappers
				
			}
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Check playAreaCellTypeWrappers
		if (_playAreaCellTypeWrappers == nil || _playAreaCellTypeWrappers!.count == 0) {
			
			// Load PlayAreaCellTypes
			self.loadPlayAreaCellTypes(for: _playGameWrappers!.first!.playSubsetID, relativeMemberWrapper: RelativeMemberWrapper.current!, playGameID: _playGameWrappers!.first!.id, oncomplete: loadPlayAreaCellTypesCompletionHandler)
			
		// Check playAreaTileTypeWrappers
		}else if (!state.didLoadPlayAreaTileTypesYN) {
			
			// Load PlayAreaTileTypes
			self.loadPlayAreaTileTypes(for: _playGameWrappers!.first!.playSubsetID, relativeMemberWrapper: RelativeMemberWrapper.current!, playGameID: _playGameWrappers!.first!.id, oncomplete: loadPlayAreaTileTypesCompletionHandler)
			
		// Check playAreaCellWrappers
		} else if (_playAreaCellWrappers == nil || _playAreaCellWrappers!.count == 0) {
			
			// Load PlayAreaCells where isSpecialYN true
			self.loadPlayAreaCells(for: RelativeMemberWrapper.current!, playGameID: _playGameWrappers!.first!.id, playAreaID: "1", isSpecialYN: true, oncomplete: loadPlayAreaCellsCompletionHandler)
			
		// Check playAreaTokenWrappers
		} else if (_playAreaTokenWrappers == nil || _playAreaTokenWrappers!.count == 0) {
			
			// Load PlayAreaTokens
			self.loadPlayAreaTokens(for: RelativeMemberWrapper.current!, playGameID: _playGameWrappers!.first!.id, playAreaID: "1", oncomplete: loadPlayAreaTokensCompletionHandler)

		// Check didCheckPlayAreaTokensImagesYN
		} else if (!state.didCheckPlayAreaTokensImagesYN) {
			
			let shouldLoadPlayAreaTokensImagesYN: Bool = self.doCheckLoadPlayAreaTokensImages(wrappers: _playAreaTokenWrappers!)
			
			state.didCheckPlayAreaTokensImagesYN = true
			
			if (shouldLoadPlayAreaTokensImagesYN) {
				
				// Load PlayAreaTokens images
				self.doLoadPlayAreaTokensImages(wrappers: _playAreaTokenWrappers!, oncomplete: loadPlayAreaTokensImagesCompletionHandler)
				
			} else {
			
				// Call completion handler
				completionHandler(_wrappers, state, nil)
				
			}
			
		// Check playChallengeWrappers
		} else if (_playChallengeWrappers == nil) {
			
			// Load PlayChallenges
			self.loadPlayChallenges(for: RelativeMemberWrapper.current!, playGameID: _playGameWrappers!.first!.id, playAreaID: "1", isActiveYN: true, oncomplete: loadPlayChallengesCompletionHandler)
			
		} else {
			
			// Call completion handler
			onFinishedCompletionHandler(wrappers, state, nil)
			
		}
		
	}
	
	
	fileprivate func NEW_doCheckLoadedPlayGameRelationalData(wrappers: [String:Any], state: CheckLoadedPlayGameRelationalDataWrapper, oncomplete completionHandler:@escaping ([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void, onfinished onFinishedCompletionHandler:@escaping ([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void) {
		
		let _wrappers: 				[String:Any] = wrappers
		
		// Get playGameWrappers
		let _playGameWrappers: 		[PlayGameWrapper]? = _wrappers["PlayGames"] as? [PlayGameWrapper]
		
		guard (_playGameWrappers != nil && _playGameWrappers!.count > 0) else {
			
			// Call completion handler
			completionHandler(_wrappers, state, NSError())
			
			return
			
		}

		// Create completion handler
		let checkLoadedDataCompletionHandler: (([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void) =
		{
			(wrappers, state, error) -> Void in

			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		if (!state.playAreaCellTypesCheckedYN) {
			
			// Check PlayAreaCellTypes
			self.doCheckLoadedPlayAreaCellTypesData(wrappers: _wrappers, playGameWrapper: _playGameWrappers!.first!, state: state, oncomplete: checkLoadedDataCompletionHandler)
			
		} else if (!state.playAreaTileTypesCheckedYN) {
			
			// Check PlayAreaTileTypes
			self.doCheckLoadedPlayAreaTileTypesData(wrappers: _wrappers, playGameWrapper: _playGameWrappers!.first!, state: state, oncomplete: checkLoadedDataCompletionHandler)
			
		} else {
			
			// Call completion handler
			onFinishedCompletionHandler(wrappers, state, nil)
			
		}
		
	}
	
	fileprivate func doCheckLoadedPlayAreaCellTypesData(wrappers: [String:Any], playGameWrapper: PlayGameWrapper, state: CheckLoadedPlayGameRelationalDataWrapper, oncomplete completionHandler:@escaping ([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void) {
		
		var _wrappers: 									[String:Any] = wrappers
		
		// Get playAreaCellTypeWrappers
		let _playAreaCellTypeWrappers: 					[PlayAreaCellTypeWrapper]? = _wrappers["PlayAreaCellTypes"] as? [PlayAreaCellTypeWrapper]
		
		// Create completion handler
		let loadPlayAreaCellTypesImagesCompletionHandler: (([PlayAreaCellTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Set state
			state.playAreaCellTypesImagesLoadedYN 		= true
			state.playAreaCellTypesCheckedYN			= true
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaCellTypesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil) {
				
				// Get playAreaCellTypeWrappers
				let playAreaCellTypeWrappers: 			[PlayAreaCellTypeWrapper]? = wrappers!["PlayAreaCellTypes"] as? [PlayAreaCellTypeWrapper]
				
				_wrappers["PlayAreaCellTypes"] 			= playAreaCellTypeWrappers
				
				// Set state
				state.playAreaCellTypesDataLoadedYN 	= true
				state.playAreaCellTypesImagesLoadedYN 	= true
				
			}
			
			// Set state
			state.playAreaCellTypesCheckedYN			= true
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Check playAreaCellTypeWrappers
		if (_playAreaCellTypeWrappers == nil || _playAreaCellTypeWrappers!.count == 0) {
			
			// Nb: This method loads the PlayAreaCellType images
			
			// Load PlayAreaCellTypes
			self.loadPlayAreaCellTypes(for: playGameWrapper.playSubsetID, relativeMemberWrapper: RelativeMemberWrapper.current!, playGameID: playGameWrapper.id, oncomplete: loadPlayAreaCellTypesCompletionHandler)

		} else {
			
			// Set state
			state.playAreaCellTypesDataLoadedYN 		= true
		
			// Nb: When the PlayAreaCellTypes data is loaded as relational data when loading PlayGame the images are not loaded
			
			// Load images
			self.loadPlayAreaCellTypesImages(items: _playAreaCellTypeWrappers!, oncomplete: loadPlayAreaCellTypesImagesCompletionHandler)
			
		}
		
	}
	
	fileprivate func doCheckLoadedPlayAreaTileTypesData(wrappers: [String:Any], playGameWrapper: PlayGameWrapper, state: CheckLoadedPlayGameRelationalDataWrapper, oncomplete completionHandler:@escaping ([String:Any]?, CheckLoadedPlayGameRelationalDataWrapper, Error?) -> Void) {
		
		var _wrappers: 									[String:Any] = wrappers
		
		// Get playAreaTileTypeWrappers
		let _playAreaTileTypeWrappers: 					[PlayAreaTileTypeWrapper]? = _wrappers["PlayAreaTileTypes"] as? [PlayAreaTileTypeWrapper]
		
		// Create completion handler
		let loadPlayAreaTileTypesImagesCompletionHandler: (([PlayAreaTileTypeWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Set state
			state.playAreaTileTypesImagesLoadedYN 		= true
			state.playAreaTileTypesCheckedYN			= true
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// Create completion handler
		let loadPlayAreaTileTypesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			if (wrappers != nil) {
				
				// Get playAreaTileTypeWrappers
				let playAreaTileTypeWrappers: 			[PlayAreaTileTypeWrapper]? = wrappers!["PlayAreaTileTypes"] as? [PlayAreaTileTypeWrapper]
				
				_wrappers["PlayAreaTileTypes"] 			= playAreaTileTypeWrappers
				
				// Set state
				state.playAreaTileTypesDataLoadedYN 	= true
				state.playAreaTileTypesImagesLoadedYN 	= true
				
			}
			
			// Set state
			state.playAreaTileTypesCheckedYN			= true
			
			// Call completion handler
			completionHandler(_wrappers, state, error)
			
		}
		
		// TODO:
		// Not sure about this ... may want to load anyway
		// Check playAreaTileTypeWrappers
		if (_playAreaTileTypeWrappers == nil || _playAreaTileTypeWrappers!.count == 0) {
			
			// Nb: This method loads the PlayAreaTileType images
			
			// Load PlayAreaTileTypes
			self.loadPlayAreaTileTypes(for: playGameWrapper.playSubsetID, relativeMemberWrapper: RelativeMemberWrapper.current!, playGameID: playGameWrapper.id, oncomplete: loadPlayAreaTileTypesCompletionHandler)
			
		} else {
			
			// Set state
			state.playAreaTileTypesDataLoadedYN 		= true
			
			// Nb: When the PlayAreaTileTypes data is loaded as relational data when loading PlayGame the images are not loaded
			
			// Load images
			self.loadPlayAreaTileTypesImages(items: _playAreaTileTypeWrappers!, oncomplete: loadPlayAreaTileTypesImagesCompletionHandler)
			
		}
		
	}
	
	
	
	
	// MARK: - Private Methods; PlayAreaTokens
	
	fileprivate func doAfterLoadPlayAreaTokens(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 					[String:Any] = [String:Any]()
		
		// Get the PlayAreaTokenWrappers
		let playAreaTokenWrappers: 		[PlayAreaTokenWrapper] = self.getPlayAreaTokenModelAdministrator().toWrappers()
		result[self.getPlayAreaTokenModelAdministrator().tableName] 		= playAreaTokenWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	fileprivate func doCheckLoadPlayAreaTokensImages(wrappers: [PlayAreaTokenWrapper]) -> Bool {
		
		var result: Bool = true
		
		// Go through each item
		for wrapper in wrappers {
			
			if (wrapper.imageData == nil) { result = true }
			
		}
		
		return result
		
	}

	fileprivate func doLoadPlayAreaTokensImages(wrappers: [PlayAreaTokenWrapper], oncomplete completionHandler:@escaping ([PlayAreaTokenWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let loadPlayAreaTokenImagesCompletionHandler: (([PlayAreaTokenWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call completion handler
			completionHandler(items, error)
			
		}

		// Load images
		self.loadPlayAreaTokenImages(items: wrappers, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayAreaTokenImagesCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods; PlayAreaCells
	
	fileprivate func doLoadPlayAreaCellsFromCache(for relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, isSpecialYN: Bool, oncomplete completionHandler:@escaping ([CellWrapperBase]?, Error?) -> Void) {
		
		var result: [CellWrapperBase] = [CellWrapperBase]()
		
		// Create completion handler
		let loadTilesCompletionHandler: (([PlayAreaTileWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Call the completion handler
			completionHandler(result, error)
			
		}
		
		// Create completion handler
		let loadCellsCompletionHandler: (([PlayAreaCellWrapper], Error?) -> Void) =
		{
			(items, error) -> Void in
			
			if (error == nil) {
				
				// Nb: Remove any items that do not match isSpecialYN. We have to do this here because the PlayAreaCellType is a relational item of the PlayAreaCell, and we can't query this when loading from the cache so have to load all cache items.
				
				// Go through each item
				for pacw in items {
					
					// Get playAreaCellType
					let pactw: PlayAreaCellTypeWrapper? = PlayWrapper.current!.get(byID: pacw.cellTypeID)
					
					// Check isSpecialYN
					if (pactw != nil && pactw!.isSpecialYN == isSpecialYN) {
						
						result.append(pacw)
						
					}
					
				}
				
				// Load from cache
				self.loadPlayAreaTilesFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, oncomplete: loadTilesCompletionHandler)
				
			} else {
				
				// Call the completion handler
				completionHandler(nil, error)
				
			}
			
		}
		
		// Load from cache
		self.loadPlayAreaCellsFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, isSpecialYN: isSpecialYN, oncomplete: loadCellsCompletionHandler)
		
	}
	
	fileprivate func doAfterLoadPlayAreaCells(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 					[String:Any] = [String:Any]()
		
		// Get the PlayAreaCellWrappers
		let playAreaCellWrappers: 		[PlayAreaCellWrapper] = self.getPlayAreaCellModelAdministrator().toWrappers()
		result[self.getPlayAreaCellModelAdministrator().tableName] 		= playAreaCellWrappers
		
		// Get the PlayAreaCellTypeWrappers
		let playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper] = self.loadedPlayAreaCellTypesToWrappers(appendYN: true)
		
		result[self.getPlayAreaCellTypeModelAdministrator().tableName] 	= playAreaCellTypeWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	fileprivate func getPlayAreaCellWrapper(for playAreaTokenWrapper: PlayAreaTokenWrapper, relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping (CellWrapperBase?, Error?) -> Void) {
		
		// Get cellCoord
		let cellCoord: CellCoord = CellCoord(column: playAreaTokenWrapper.column, row: playAreaTokenWrapper.row)
		
		var cellWrapper: CellWrapperBase? = nil
		
		// Get cellWrapper from GridScapeManager
		cellWrapper = self.getPlayAreaCellWrapperFromGridScapeManager(for: cellCoord)
		
		if (cellWrapper != nil) {
			
			// Call completion handler
			completionHandler(cellWrapper, nil)
			
			return
			
		}
		
		// Create completion handler
		let getPlayAreaCellWrapperFromDataSourceCompletionHandler: ((CellWrapperBase?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			// Call completion handler
			completionHandler(wrapper, error)
			
		}
		
		#if DEBUG
			
			// Nb: We could load dummy data from the data source, but we want to load from the cache instead. The data will be saved to the cache. In the future we may want the ability to use the cache.
			
			// MIGRATING: (06/05/20)
//			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")
//				&& !ApplicationFlags.flag(key: "LoadPlayAreaCellsDummyDataYN")) {
			
			if (ApplicationFlags.flag(key: "LoadDataFromCacheYN")
				&& ApplicationFlags.flag(key: "LoadPlayAreaCellsDummyDataYN")) {
			
				// Create completion handler
				let getPlayAreaCellWrapperFromCacheCompletionHandler: ((CellWrapperBase?, Error?) -> Void) =
				{
					(wrapper, error) -> Void in
					
					// Call completion handler
					getPlayAreaCellWrapperFromDataSourceCompletionHandler(wrapper, error)
					
				}
				
				// Load from cache
				self.getPlayAreaCellWrapperFromCache(for: cellCoord, relativeMemberWrapper: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, oncomplete: getPlayAreaCellWrapperFromCacheCompletionHandler)
				
				return
				
			}
			
		#endif
		
		// Load from data source
		self.getPlayAreaCellWrapperFromDataSource(for: cellCoord, relativeMemberWrapper: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, oncomplete: getPlayAreaCellWrapperFromDataSourceCompletionHandler)
		
	}
	
	fileprivate func getPlayAreaCellWrapperFromGridScapeManager(for cellCoord: CellCoord) -> CellWrapperBase? {
		
		var result: 			CellWrapperBase? = nil
		
		// Get gridScapeManager
		let gridScapeManager: 	GridScapeManager? = self.delegate!.mainDisplayControlManager(gridScapeManager: self)
		
		guard (gridScapeManager != nil) else { return nil }
		
		// Get cellView
		let cellView: 			ProtocolGridCellView? = gridScapeManager!.get(cellView: cellCoord)
		
		guard (cellView != nil) else { return nil }
		
		result 					= cellView!.cellWrapper
		
		return result
		
	}
	
	fileprivate func getPlayAreaCellWrapperFromCache(for cellCoord: CellCoord, relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping (CellWrapperBase?, Error?) -> Void) {
		
		// Get gridScapeContainerViewControlManager
		let gridScapeContainerViewControlManager: GridScapeContainerViewControlManager? = self.delegate!.mainDisplayControlManager(gridScapeContainerViewControlManager: self)
		
		guard (gridScapeContainerViewControlManager != nil) else {
			
			// Call completion handler
			completionHandler(nil, NSError())
			
			return
			
		}
		
		// Get cellCoordRange
		let cellCoordRange: CellCoordRange = CellCoordRange(topLeft: cellCoord, bottomRight: cellCoord)
		
		// Create completion handler
		let loadPlayAreaCellsFromCacheCompletionHandler: (([CellWrapperBase]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			// Nb: The relative items have been set
			
			// Call completion handler
			completionHandler(items?.first, error)
			
		}
		
		// Load from cache
		self.loadPlayAreaCellsFromCache(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, gridScapeContainerViewControlManager: gridScapeContainerViewControlManager!, oncomplete: loadPlayAreaCellsFromCacheCompletionHandler)
		
	}
	
	fileprivate func getPlayAreaCellWrapperFromDataSource(for cellCoord: CellCoord, relativeMemberWrapper: RelativeMemberWrapper, playGameID: String, playAreaID: String, oncomplete completionHandler:@escaping (CellWrapperBase?, Error?) -> Void) {
		
		// Create completion handler
		let loadPlayAreaCellsFromDataSourceCompletionHandler: (([PlayAreaCellWrapper]?, Error?) -> Void) =
		{
			(items, error) -> Void in
			
			guard (items != nil && items!.count > 0 && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			// Get playAreaCellWrapper
			let playAreaCellWrapper: 	PlayAreaCellWrapper = items!.first!
			
			// Get playAreaCellTypeWrapper
			let pactw: 					PlayAreaCellTypeWrapper? = PlayWrapper.current!.get(byID: playAreaCellWrapper.cellTypeID)
			
			if (pactw != nil) {
				
				playAreaCellWrapper.set(cellTypeWrapper: pactw!)
				
			}
			
			// Get the PlayAreaTileWrappers
			let playAreaTileWrappers: 	[PlayAreaTileWrapper] = self.getPlayAreaTileModelAdministrator().toWrappers()
			
			// Nb: At the moment this is only allowing one tileWrapper in the cellWrapper. This will be changed to allow a collection of tileWrappers.
			
			// Go through each item
			for patw in playAreaTileWrappers {
				
				// Get playAreaTileTypeWrapper
				let pattw: 				PlayAreaTileTypeWrapper? = PlayWrapper.current!.get(byID: patw.tileTypeID)
				
				if (pattw != nil) {
					
					patw.set(tileTypeWrapper: pattw!)
					
				}
				
				playAreaCellWrapper.tileWrapper = patw
				
			}
			
			// Call completion handler
			completionHandler(playAreaCellWrapper, nil)
			
		}
		
		// Check is connected
		if (self.checkIsConnected()) {
			
			// Get cellCoordRange
			let cellCoordRange: CellCoordRange = CellCoordRange(topLeft: cellCoord, bottomRight: cellCoord)
			
			// Load from data source
			self.loadPlayAreaCellsFromDataSource(for: relativeMemberWrapper, playGameID: playGameID, playAreaID: playAreaID, cellCoordRange: cellCoordRange, oncomplete: loadPlayAreaCellsFromDataSourceCompletionHandler)
			
		} else {
			
			// Notify the delegate
			self.delegate?.mainDisplayControlManager(isNotConnected: nil)
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayAreaCellTypes
	
	fileprivate func loadPlayAreaCellTypesImages(items: [PlayAreaCellTypeWrapper], oncomplete completionHandler:@escaping ([PlayAreaCellTypeWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var loadPlayAreaCellTypeImageDataResultCount: Int = 0
		
		// Create completion handler
		let loadPlayAreaCellTypeImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			loadPlayAreaCellTypeImageDataResultCount += 1
			
			if (loadPlayAreaCellTypeImageDataResultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlayAreaCellTypeImageData(for: item, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayAreaCellTypeImageDataCompletionHandler)
			
		}
		
	}
	
	fileprivate func doAfterLoadPlayAreaCellTypes(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 					[String:Any] = [String:Any]()
		
		// Get the PlayAreaCellTypeWrappers
		let playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper] = self.loadedPlayAreaCellTypesToWrappers(appendYN: true)
		
		result[self.getPlayAreaCellTypeModelAdministrator().tableName] = playAreaCellTypeWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		self.getPlayAreaCellTypeModelAdministrator().initialise()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	

	// MARK: - Private Methods; PlayAreaTileTypes
	
	fileprivate func loadPlayAreaTileTypesImages(items: [PlayAreaTileTypeWrapper], oncomplete completionHandler:@escaping ([PlayAreaTileTypeWrapper], Error?) -> Void) {
		
		guard (items.count > 0) else {
			
			// Call completion handler
			completionHandler(items, nil)
			
			return
			
		}
		
		var loadPlayAreaTileTypeImageDataResultCount: Int = 0
		
		// Create completion handler
		let loadPlayAreaCellTypeImageDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in
			
			loadPlayAreaTileTypeImageDataResultCount += 1
			
			if (loadPlayAreaTileTypeImageDataResultCount >= items.count) {
				
				// Call completion handler
				completionHandler(items, nil)
				
			}
			
		}
		
		// Go through each item
		for item in items {
			
			// Load image data
			self.loadPlayAreaTileTypeImageData(for: item, urlRoot: self.imagesUrlRoot!, oncomplete: loadPlayAreaCellTypeImageDataCompletionHandler)
			
		}
		
	}
	
	fileprivate func doAfterLoadPlayAreaTileTypes(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 					[String:Any] = [String:Any]()
		
		// Get the PlayAreaTileTypeWrappers
		let playAreaTileTypeWrappers: 	[PlayAreaTileTypeWrapper] = self.loadedPlayAreaTileTypesToWrappers(appendYN: true)
		
		result[self.getPlayAreaTileTypeModelAdministrator().tableName] = playAreaTileTypeWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		self.getPlayAreaTileTypeModelAdministrator().initialise()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	
	// MARK: - Private Methods; PlayAreaPaths
	
	fileprivate func doAfterLoadPlayAreaPaths(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 							[String:Any] = [String:Any]()

		// Get playAreaPathWrappers
		let playAreaPathWrappers: 				[PlayAreaPathWrapper] = self.loadedPlayAreaPathsToWrappers()

		result[self.getPlayAreaPathModelAdministrator().tableName] = playAreaPathWrappers

		// Get playAreaPathPointWrappers
		let playAreaPathPointWrappers: 			[PlayAreaPathPointWrapper] = self.loadedPlayAreaPathPointsToWrappers()
		
		result[self.getPlayAreaPathPointModelAdministrator().tableName] = playAreaPathPointWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)

		self.getPlayAreaPathModelAdministrator().initialise()
		self.getPlayAreaPathPointModelAdministrator().initialise()

		// Call completion handler
		completionHandler(result, nil)
		
	}

	fileprivate func loadPlayAreaPathsFromLoadedPlayAreaCells(from fromCellCoord: CellCoord, to toCellCoord: CellCoord, by playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// TODO:
		
		// Call completion handler
		completionHandler(nil, nil)
		
	}
	
	
	// MARK: - Private Methods; PlayMoves
	
	fileprivate func doAfterLoadPlayMoves(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 							[String:Any] = [String:Any]()
		
		// Get playMoveWrappers
		let playMoveWrappers: 					[PlayMoveWrapper] = self.loadedPlayMovesToWrappers()
		
		result[self.getPlayMoveModelAdministrator().tableName] = playMoveWrappers
		
		// Get playChallengeWrappers
		let playChallengeWrappers: 				[PlayChallengeWrapper] = self.loadedPlayChallengesToWrappers()
		
		result[self.getPlayChallengeModelAdministrator().tableName] = playChallengeWrappers
		
		// Get playChallengeObjectiveWrappers
		let playChallengeObjectiveWrappers: 	[PlayChallengeObjectiveWrapper] = self.loadedPlayChallengeObjectivesToWrappers()
		
		result[self.getPlayChallengeObjectiveModelAdministrator().tableName] = playChallengeObjectiveWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		self.getPlayMoveModelAdministrator().initialise()
		self.getPlayChallengeModelAdministrator().initialise()
		self.getPlayChallengeObjectiveModelAdministrator().initialise()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	fileprivate func doAfterLoadPlayMoves(for playAreaPathWrapper: PlayAreaPathWrapper, wrappers: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get playMoveWrappers
		let playMoveWrappers: 	[PlayMoveWrapper]? = wrappers["PlayMoves"] as? [PlayMoveWrapper]
		
		guard (playMoveWrappers != nil) else {
			
			// Call completion handler
			completionHandler(wrappers, nil)
			
			return
			
		}
		
		// Go through each item
		for pmw in playMoveWrappers! {
			
			// Set playMoveWrapper
			playAreaPathWrapper.set(playMoveWrapper: pmw)
			
		}
		
		// Call completion handler
		completionHandler(wrappers, nil)
		
	}
	
	fileprivate func doSetPlayMovesPlayReferenceData(playMoveWrappers: [PlayMoveWrapper], for playAreaTileWrapper: PlayAreaTileWrapper) {
		
		// Go through each item
		for pmw in playMoveWrappers {
			
			// PlayAreaTile
			pmw.playReferenceType 			= .PlayAreaTile
			pmw.playReferenceID 			= playAreaTileWrapper.id
			
			// PlayAreaTileType
			pmw.playReferenceDataItemType 	= .PlayAreaTileType
			pmw.playReferenceDataItemID 	= playAreaTileWrapper.tileTypeID
			
			// Serialize PlayReferenceData
			pmw.serializePlayReferenceData();
		}
		
	}
	
	
	// MARK: - Private Methods; PlayChallenges
	
	fileprivate func doAfterLoadPlayChallenges(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: 								[String:Any] = [String:Any]()
		
		// Get playChallengeWrappers
		let playChallengeWrappers: 					[PlayChallengeWrapper] = self.loadedPlayChallengesToWrappers()
		
		result[self.getPlayChallengeModelAdministrator().tableName] = playChallengeWrappers
		
		// Get playChallengeTypeWrappers
		let playChallengeTypeWrappers: 				[PlayChallengeTypeWrapper] = self.loadedPlayChallengeTypesToWrappers()
		
		result[self.getPlayChallengeTypeModelAdministrator().tableName] = playChallengeTypeWrappers
		
		// Get playChallengeObjectiveWrappers
		let playChallengeObjectiveWrappers: 		[PlayChallengeObjectiveWrapper] = self.loadedPlayChallengeObjectivesToWrappers()
		
		result[self.getPlayChallengeObjectiveModelAdministrator().tableName] = playChallengeObjectiveWrappers
		
		// Get playChallengeObjectiveTypeWrappers
		let playChallengeObjectiveTypeWrappers: 	[PlayChallengeObjectiveTypeWrapper] = self.loadedPlayChallengeObjectiveTypesToWrappers()
		
		result[self.getPlayChallengeObjectiveTypeModelAdministrator().tableName] = playChallengeObjectiveTypeWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)

		self.getPlayChallengeModelAdministrator().initialise()
		self.getPlayChallengeTypeModelAdministrator().initialise()
		self.getPlayChallengeObjectiveModelAdministrator().initialise()
		self.getPlayChallengeObjectiveTypeModelAdministrator().initialise()
		
		// Call completion handler
		completionHandler(result, nil)
		
	}
	
	fileprivate func doSetActivePlayChallenge(playChallengeWrapper: PlayChallengeWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let loadPlayChallengesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Get playChallengeWrappers
			let playChallengeWrappers: 			[PlayChallengeWrapper]? = wrappers!["PlayChallenges"] as? [PlayChallengeWrapper]
			
			// Get activePlayChallengeWrapper
			let activePlayChallengeWrapper: 	PlayChallengeWrapper = playChallengeWrappers!.first!
			
			// Display PlayChallenge
			self.viewManager!.displayPlayActiveChallenge(playChallengeWrapper: activePlayChallengeWrapper)
			
			// Notify the delegate
			self.delegate!.mainDisplayControlManager(playActiveChallengeLoaded: activePlayChallengeWrapper, sender: self)

			// Call completion handler
			completionHandler(error)
			
		}
		
		// Create completion handler
		let savePlayChallengeCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			guard (error == nil) else {
				
				// Call the completion handler
				completionHandler(error)
				
				return
				
			}
			
			// Load data
			self.loadPlayChallenge(for: playChallengeWrapper.id, oncomplete: loadPlayChallengesCompletionHandler)
			
		}
		
		// Clear active PlayChallenge
		PlayWrapper.current!.clear(playChallengesByIsActiveYN: true)
		
		// Remove the PlayChallenge from the PlayWrapper. It will be added after it is saved.
		PlayWrapper.current!.playChallenges!.removeValue(forKey: playChallengeWrapper.id)
		
		// Set playChallengeWrapper properties
		playChallengeWrapper.id 			= "0"
		playChallengeWrapper.playGameID 	= self.playGameWrapper!.id
		playChallengeWrapper.isActiveYN		= true
		playChallengeWrapper.dateActive 	= Date()
		playChallengeWrapper.status 		= .new
		
		// Save PlayChallenge
		self.savePlayChallenge(wrapper: playChallengeWrapper, oncomplete: savePlayChallengeCompletionHandler)
		
	}

	fileprivate func doStartPlayChallenge(playChallengeWrapper: PlayChallengeWrapper, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		
	}

	
	fileprivate func doAbortActivePlayChallenge(playChallengeWrapper: PlayChallengeWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let savePlayChallengeCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in

			// Call the completion handler
			completionHandler(error)
			
		}
		
		// Clear active PlayChallenge
		PlayWrapper.current!.clear(playChallengesByIsActiveYN: true)
		
		// Remove the PlayChallenge from the PlayWrapper
		PlayWrapper.current!.playChallenges!.removeValue(forKey: playChallengeWrapper.id)
		
		// Set playChallengeWrapper properties
		playChallengeWrapper.isActiveYN		= false
		playChallengeWrapper.status 		= .modified
		
		// Save PlayChallenge
		self.savePlayChallenge(wrapper: playChallengeWrapper, oncomplete: savePlayChallengeCompletionHandler)
		
	}
	
	fileprivate func doRemovePlayActiveChallenge(playChallengeWrapper: PlayChallengeWrapper, doSaveYN: Bool, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let savePlayChallengeCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			guard (error == nil) else {
				
				// Call the completion handler
				completionHandler(error)
				
				return
				
			}

			// Clear PlayActiveChallenge display
			self.viewManager!.clearPlayActiveChallenge()
			
			// Notify the delegate
			self.delegate!.mainDisplayControlManager(playActiveChallengeLoaded: nil, sender: self)
			
			// Call the completion handler
			completionHandler(nil)
			
		}
		
		// Clear active PlayChallenge
		//PlayWrapper.current!.clear(playChallengesByIsActiveYN: true)
	
		// Remove the PlayChallenge from the PlayWrapper
		PlayWrapper.current!.playChallenges!.removeValue(forKey: playChallengeWrapper.id)
		
		// Set not active PlayChallenge
		playChallengeWrapper.isActiveYN		= false

		if (doSaveYN) {
			
			// Save PlayChallenge
			self.savePlayChallenge(wrapper: playChallengeWrapper, oncomplete: savePlayChallengeCompletionHandler)
			
		} else {
			
			// Call the completion handler
			savePlayChallengeCompletionHandler(nil)
			
		}

	}
	
	
	// MARK: - Private Methods; PlayExperiences
	
	fileprivate func doAfterLoadPlayExperience(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {

		var result: [String:Any] = [String:Any]()

		// Get the PlayExperienceWrappers
		let playExperienceWrappers: 										[PlayExperienceWrapper] = self.getPlayExperienceModelAdministrator().toWrappers()
		result[self.getPlayExperienceModelAdministrator().tableName] 		= playExperienceWrappers

		// Get the PlayExperienceStepWrappers
		let playExperienceStepWrappers: 									[PlayExperienceStepWrapper] = self.getPlayExperienceStepModelAdministrator().toWrappers()
		result[self.getPlayExperienceStepModelAdministrator().tableName] 	= playExperienceStepWrappers

		// Get the PlayExperiencePlayExperienceStepLinkWrappers
		let playExperiencePlayExperienceStepLinkWrappers: 									[PlayExperiencePlayExperienceStepLinkWrapper] = self.getPlayExperiencePlayExperienceStepLinkModelAdministrator().toWrappers()
		result[self.getPlayExperiencePlayExperienceStepLinkModelAdministrator().tableName] 	= playExperiencePlayExperienceStepLinkWrappers
		
		// Get the PlayExperienceStepExerciseWrappers
		let playExperienceStepExerciseWrappers: 									[PlayExperienceStepExerciseWrapper] = self.getPlayExperienceStepExerciseModelAdministrator().toWrappers()
		result[self.getPlayExperienceStepExerciseModelAdministrator().tableName] 	= playExperienceStepExerciseWrappers

		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)

		// Call completion handler
		completionHandler(result, nil)

	}

	
	// MARK: - Private Methods; PlayExperienceSteps
	
	fileprivate func doAfterLoadPlayExperienceStep(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var result: [String:Any] = [String:Any]()
		
		// Get the PlayExperienceStepWrappers
		let playExperienceStepWrappers: 									[PlayExperienceStepWrapper] = self.getPlayExperienceStepModelAdministrator().toWrappers()
		result[self.getPlayExperienceStepModelAdministrator().tableName] 	= playExperienceStepWrappers
		
		// Get the PlayExperienceStepExerciseWrappers
		let playExperienceStepExerciseWrappers: 									[PlayExperienceStepExerciseWrapper] = self.getPlayExperienceStepExerciseModelAdministrator().toWrappers()
		result[self.getPlayExperienceStepExerciseModelAdministrator().tableName] 	= playExperienceStepExerciseWrappers
		
		// Get the PlayExperienceStepPlayExperienceStepExerciseLinkWrappers
		let playExperienceStepPlayExperienceStepExerciseLinkWrappers: 									[PlayExperienceStepPlayExperienceStepExerciseLinkWrapper] = self.getPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator().toWrappers()
		result[self.getPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator().tableName] 	= playExperienceStepPlayExperienceStepExerciseLinkWrappers
		
		// Set in PlayWrapper
		PlayWrapper.current?.set(wrappers: result)
		
		// Call completion handler
		completionHandler(result, nil)
		
	}

}

// MARK: - Extension ProtocolUserProfileWrapperDelegate

extension MainDisplayControlManager: ProtocolUserProfileWrapperDelegate {
	
	// MARK: - Public Methods
	
	public func userProfileWrapper(loadSuccessful userProfileWrapper: UserProfileWrapper) {
		
		self.onUserProfileWrapperLoadSuccessful(userProfileWrapper: userProfileWrapper)
		
	}
	
	public func userProfileWrapper(loadFailed error: Error?, code: UserProfileWrapperErrorCodes) {
		
		self.onUserProfileWrapperLoadFailed(error: error, code: code)
	}
	
}

