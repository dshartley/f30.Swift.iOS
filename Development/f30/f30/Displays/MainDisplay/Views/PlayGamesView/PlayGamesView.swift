//
//  PlayGamesView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFCore
import SFGlobalization
import SFSocial
import f30Model
import f30View
import f30Controller

/// A view class for a PlayGamesView
public class PlayGamesView: UIView, ProtocolPlayGamesView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:					PlayGamesViewControlManager?
	fileprivate var hasViewAppearedYN:				Bool = false
	fileprivate var isInitialLoadCompleteYN:		Bool = false
	fileprivate let playGamesTableViewRowHeight:	CGFloat = 110
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:						ProtocolPlayGamesViewDelegate?
	
	@IBOutlet weak var contentView:					UIView!
	@IBOutlet weak var playGamesTableView: 			UITableView!
	
	
	// MARK: - Initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setupContentView()
		
		self.setup()
		self.setupView()
		
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setupContentView()
		
		self.setup()
		self.setupView()
		
	}
	
	
	// MARK: - Override Methods

	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
		self.hasViewAppearedYN = true
		
	}
	
	public func clearView() {
		
		self.isInitialLoadCompleteYN 	= false
		
		// Clear playGamesTableView
		self.playGamesTableView.alpha 	= 0
		self.playGamesTableView.reloadData()
		
	}
	
	public func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {

		self.layoutIfNeeded()
	}
	
	public func loadItems() {
		
		self.doLoadPlayGames()
		
	}
	
	public func doAfterEdit(wrapper: PlayGameWrapper) {
		
		// Get isPlayGameNewYN
		//let isPlayGameNewYN: Bool = (wrapper.status == .new)

		// Create completion handler
		let savePlayGameCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			DispatchQueue.main.async {
				
				// Refresh items view
				self.playGamesTableView.reloadData()

				self.layoutIfNeeded()
				
			}
			
			// TODO:
			// If added then set current game and hide view??
			
		}
		
		// Save data
		self.controlManager!.savePlayGame(wrapper: wrapper, oncomplete: savePlayGameCompletionHandler)
		
	}

	public func set(activePlayGameID: String?) {
	
		self.controlManager!.activePlayGameID = activePlayGameID
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayGamesViewControlManager()
		
		self.controlManager!.delegate 	= self
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		ModelFactory.setupPlayGameModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayGameDataModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: PlayGamesViewViewAccessStrategy = PlayGamesViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayGamesViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayGamesView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
		self.setupPlayGamesTableView()
		
	}

	fileprivate func setupPlayGamesTableView() {
		
		// Enable table row automatic height
		self.playGamesTableView.rowHeight 			= UITableViewAutomaticDimension
		self.playGamesTableView.estimatedRowHeight 	= 75
		
		self.playGamesTableView.delegate			= self
		self.playGamesTableView.dataSource			= self
		
		// Register custom TableViewCell using nib because the TableView is defined in a custom View and not in the Storyboard
		self.playGamesTableView.register(UINib(nibName: "PlayGamesTableViewCell", bundle: nil), forCellReuseIdentifier: "PlayGamesTableViewCell")
		
		self.playGamesTableView.alpha 				= 0
		
	}
	
	fileprivate func presentIsNotConnectedAlert() {
		
		// Notify the delegate
		self.delegate?.playGamesView(isNotConnected: nil)
		
	}
	
	fileprivate func presentOperationFailedAlert(error: Error?) {
		
		// Notify the delegate
		self.delegate?.playGamesView(operationFailed: error)
		
	}

	fileprivate func createPlayGamesTableViewCell(for item: PlayGameWrapper, at indexPath: IndexPath) -> PlayGamesTableViewCell {
		
		let cell: 					PlayGamesTableViewCell = self.playGamesTableView.dequeueReusableCell(withIdentifier: "PlayGamesTableViewCell", for: indexPath) as! PlayGamesTableViewCell
		
		cell.delegate 				= self
		
		// Get isActivePlayGameYN
		let isActivePlayGameYN: 	Bool = (item.id == self.controlManager!.activePlayGameID)
		
		// Get canDeleteYN
		let canDeleteYN: 			Bool = (self.controlManager!.playGameWrappers.items.count > 1)
		
		// Set the wrapper in the cell
		cell.set(wrapper: item, isActivePlayGameYN: isActivePlayGameYN, canDeleteYN: canDeleteYN)
		
		return cell
		
	}
	
	fileprivate func doOnPlayGamesLoaded(wrappers: [PlayGameWrapper]) {
		
		if (wrappers.count > 0) {
			
		} else {
			
			//self.hideActivityIndicatorView(animateYN: true)
			
			self.isInitialLoadCompleteYN = true
			
		}
		
		DispatchQueue.main.async {
			
			// Show playGamesTableView if there are items
			if (self.controlManager!.playGameWrappers.items.count > 0) {
				
				self.playGamesTableView.alpha = 1
				
			} else {
				
				self.playGamesTableView.alpha = 0
				
			}
			
		}
		
	}

	fileprivate func doLoadPlayGames() {

		// Create completion handler
		let loadPlayGamesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.isInitialLoadCompleteYN = true
				
				self.presentOperationFailedAlert(error: error)
				
				return
				
			}
			
			// Get playGameWrappers
			let playGameWrappers: [PlayGameWrapper]? = wrappers!["PlayGames"] as? [PlayGameWrapper]
			
			self.doOnPlayGamesLoaded(wrappers: playGameWrappers!)
			
			// Check number of items loaded
			guard (playGameWrappers!.count > 0) else {
				
				return
			}
			
			DispatchQueue.main.async {
				
				// Refresh items view
				self.playGamesTableView.reloadData()
				
				//self.hideActivityIndicatorView(animateYN: true)
				
				self.isInitialLoadCompleteYN = true

			}
			
		}
		
		// Load PlayGames
		self.controlManager!.loadPlayGames(for: RelativeMemberWrapper.current!, oncomplete: loadPlayGamesCompletionHandler)
		
	}
	
	
	// MARK: - addPlayGameButton Methods
	
	@IBAction func addPlayGameButtonTapped(_ sender: Any) {
		
		// Create PlayGameWrapper
		let wrapper: 	PlayGameWrapper = self.controlManager!.createPlayGameWrapper(relativeMemberWrapper: RelativeMemberWrapper.current!)
		
		wrapper.status 	= .new
		
		// Notify the delegate
		self.delegate!.playGamesView(presentPlayGameEditView: self, for: wrapper)
		
	}
	
}


// MARK: - Extension ProtocolPlayGamesViewControlManagerDelegate

extension PlayGamesView: ProtocolPlayGamesViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
	public func playGamesViewControlManager(isNotConnected error: Error?) {
		
		self.presentIsNotConnectedAlert()

	}
	
}


// MARK: - Extension UITableViewDelegate, UITableViewDataSource

extension PlayGamesView : UITableViewDelegate, UITableViewDataSource {
	
	public func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
		
		return self.controlManager!.playGameWrappers.items.count
		
	}
	
	public func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
		
		// Get the item
		let playGameWrapper: PlayGameWrapper = self.controlManager!.playGameWrappers.items[indexPath.row]
		
		// Create the cell
		let cell = self.createPlayGamesTableViewCell(for: playGameWrapper, at: indexPath)
		
		return cell
		
	}
	
	public func numberOfSections(in tableView: UITableView) -> Int {
		
		return 1
	}
	
	public func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
		
		return self.playGamesTableViewRowHeight
	}
	
}


// MARK: - Extension ProtocolPlayGamesTableViewCellDelegate

extension PlayGamesView: ProtocolPlayGamesTableViewCellDelegate {
	
	// MARK: - Public Methods
	
	public func playGamesTableViewCell(cell: PlayGamesTableViewCell, itemTapped item: PlayGameWrapper) {
		
		// Notify the delegate
		self.delegate!.playGamesView(sender: self, playGameSelected: item)
		
	}

	public func playGamesTableViewCell(cell: PlayGamesTableViewCell, editButtonTapped item: PlayGameWrapper) {

		item.status = .modified
		
		// Notify the delegate
		self.delegate!.playGamesView(presentPlayGameEditView: self, for: item)
		
	}
	
	public func playGamesTableViewCell(cell: PlayGamesTableViewCell, deleteButtonTapped item: PlayGameWrapper) {
		
		var activePlayGameWrapper: 	PlayGameWrapper? = nil
		
		// Check activePlayGameID
		if (item.id == self.controlManager!.activePlayGameID) {
			
			// Get next active playGameWrapper
			activePlayGameWrapper 	= self.controlManager!.getNextActivePlayGameWrapper()
			
		} else {
			
			activePlayGameWrapper 	= self.controlManager!.playGameWrappers.get(by: self.controlManager!.activePlayGameID!)
			
		}
		
		guard (activePlayGameWrapper != nil) else { return }
		
		// Create completion handler
		let deletePlayGameCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (error == nil) else {

				self.presentOperationFailedAlert(error: error)
				
				return
				
			}
			
			DispatchQueue.main.async {
				
				// Set activePlayGameID
				self.set(activePlayGameID: activePlayGameWrapper!.id)
				
				// Refresh items view
				self.playGamesTableView.reloadData()

			}
			
			// Notify the delegate
			self.delegate!.playGamesView(sender: self, playGameDeleted: item, activePlayGame: activePlayGameWrapper!)
			
		}
		
		// Delete playGame
		self.controlManager!.deletePlayGame(wrapper: item, oncomplete: deletePlayGameCompletionHandler)
		
	}
	
}

