//
//  PlayDeckView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFGridScape
import f30Model
import f30View
import f30Controller

fileprivate enum PlayDeckViewModes {
	case Cell
	case Tile
}

/// A view class for a PlayDeckView
public class PlayDeckView: UIView, ProtocolPlayDeckView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:								PlayDeckViewControlManager?
	fileprivate var isNotConnectedAlertIsShownYN:				Bool = false
	fileprivate var playDeckDraggingState:						GridScapeDeckDraggingState? = nil
	fileprivate var playDeckViewMode: 							PlayDeckViewModes = .Cell
	fileprivate var playDeckCellView:							ProtocolGridCellView? = nil
	fileprivate var playDeckCellViewLongPressGestureRecognizer: UILongPressGestureRecognizer? = nil
	fileprivate var playDeckCellViewTapGestureRecognizer: 		UITapGestureRecognizer? = nil
	fileprivate var tileDeckCellView:							ProtocolGridCellView? = nil
	fileprivate var tileDeckCellViewLongPressGestureRecognizer: UILongPressGestureRecognizer? = nil
	fileprivate var tileDeckCellViewTapGestureRecognizer: 		UITapGestureRecognizer? = nil
	fileprivate var gridScapeManager:							GridScapeManager? = nil
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:									ProtocolPlayDeckViewDelegate?

	@IBOutlet weak var contentView:								UIView!
	@IBOutlet weak var deckContainerView: 						UIView!
	@IBOutlet weak var deckCellContainerView: 					UIView!
	@IBOutlet weak var deckTileContainerView: 					UIView!
	@IBOutlet weak var deckCellRotateRightImageView: 			UIImageView!
	@IBOutlet weak var deckCellSwapImageView: 					UIImageView!
	@IBOutlet weak var deckTileSwapImageView: 					UIImageView!
	
	
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

	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	
		// Notify the delegate
		self.delegate?.playDeckView(touchesBegan: self)
		
	}

	public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {

		// Nb: If self is returned, then touchesBegan is called
		
		// checkHitTest on sub views
		return self.checkHitTest(point: point, withEvent: event)
		
	}
	
	
	// MARK: - Public Methods
	
	public func checkHitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		// Check gestures enabled
		if (!self.isUserInteractionEnabled || self.isHidden || self.alpha == 0) {
			
			return nil
			
		}
		
		// Check gestures enabled
		if (!self.contentView.isUserInteractionEnabled || self.contentView.isHidden || self.contentView.alpha == 0) {
			
			return nil
			
		}

		// Check point inside
		if (!self.contentView.point(inside: point, with: event)) {
			
			return nil
			
		}
		
		// Nb: Check whether to handle the event in subviews

		var result: UIView? = nil
		
		if (result != nil) { return result }

		// Check deckCellRotateRightImageView
		result = self.doCheckHitTest(deckCellRotateRightImageView: point, withEvent: event)
		
		if (result != nil) { return result }

		// Check deckCellSwapImageView
		result = self.doCheckHitTest(deckCellSwapImageView: point, withEvent: event)
		
		if (result != nil) { return result }
		
		// Check deckTileSwapImageView
		result = self.doCheckHitTest(deckTileSwapImageView: point, withEvent: event)
		
		if (result != nil) { return result }

		// Check playDeckCellView
		result = self.doCheckHitTest(playDeckCellView: point, withEvent: event)
		
		if (result != nil) { return result }

		// Check tileDeckCellView
		result = self.doCheckHitTest(tileDeckCellView: point, withEvent: event)
		
		if (result != nil) { return result }
		
		// Check deckContainerView
		result = self.doCheckHitTest(deckContainerView: point, withEvent: event)
		
		if (result != nil) { return result }
		
		return nil
		
	}

	public func viewDidAppear() {
		
		self.setupDeckContainerView()
		self.setGridScapeManager()
		
	}
	
	public func clearView() {
		
		self.doClearCellDeck()
		self.doClearTileDeck()
		
	}

	public func present(playAreaGridCellView: ProtocolPlayAreaGridCellView) {
		
		guard (self.gridScapeManager != nil) else { return }
		
		self.doClearCellDeck()
		
		self.setPlayDeckViewMode(mode: .Cell)
		
		self.addCellViewToCellDeck(playDeckCellView: playAreaGridCellView as! ProtocolGridCellView)
	
	}

	public func present(playAreaGridTileView: ProtocolPlayAreaGridTileView) {
		
		guard (self.gridScapeManager != nil) else { return }
		
		self.doClearTileDeck()
		
		self.setPlayDeckViewMode(mode: .Tile)
		
		self.addTileViewToTileDeck(playDeckTileView: playAreaGridTileView as! ProtocolGridTileView)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayDeckViewControlManager()
		
		self.controlManager!.delegate 	= self
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		//ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: PlayDeckViewViewAccessStrategy = PlayDeckViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayDeckViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayDeckView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
		self.setPlayDeckViewMode(mode: .Cell)
		
	}
	
	fileprivate func setupDeckContainerView() {
		
		self.deckContainerView.layer.cornerRadius = 5
		
		UIViewHelper.setShadow(view: self.deckContainerView)
		
	}
	
	fileprivate func presentIsNotConnectedAlert() {
		
		guard (!self.isNotConnectedAlertIsShownYN) else { return }
		
		self.isNotConnectedAlertIsShownYN = true
		
		// Create completion handler
		let completionHandler: ((UIAlertAction?) -> Void) =
		{
			[unowned self] (action) -> Void in
			
			self.isNotConnectedAlertIsShownYN = false
			
		}
		
		let alertTitle: 	String = NSLocalizedString("AlertTitleNotConnected", comment: "")
		let alertMessage: 	String = NSLocalizedString("AlertMessageNotConnected", comment: "")
		
		UIAlertControllerHelper.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: completionHandler)
		
	}

	fileprivate func presentOperationFailedAlert() {
		
		let alertTitle: 	String = NSLocalizedString("AlertTitleOperationFailed", comment: "")
		let alertMessage: 	String = NSLocalizedString("AlertMessageOperationFailed", comment: "")
		
		UIAlertControllerHelper.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: nil)
		
	}
	
	fileprivate func handleCellDeckCellViewDraggingStarted(fromIndicated: CGPoint) {
		
		guard (self.gridScapeManager != nil) else { return }
		
		// Check playDeckDraggingState
		guard (self.playDeckDraggingState == nil || (self.playDeckDraggingState != nil && !self.playDeckDraggingState!.isDraggingYN)) else { return }
		
		self.playDeckDraggingState = GridScapeDeckDraggingState()
		let ds: GridScapeDeckDraggingState = self.playDeckDraggingState!
		
		guard (self.playDeckCellView != nil) else { return }
		
		// Set originCellView
		ds.set(originCellView: self.playDeckCellView!)
		
		ds.type				= .Cell
		ds.fromIndicated 	= fromIndicated
		
	}
	
	fileprivate func handleTileDeckCellViewDraggingStarted(fromIndicated: CGPoint) {
		
		guard (self.gridScapeManager != nil) else { return }
		
		// Check playDeckDraggingState
		guard (self.playDeckDraggingState == nil || (self.playDeckDraggingState != nil && !self.playDeckDraggingState!.isDraggingYN)) else { return }
		
		self.playDeckDraggingState = GridScapeDeckDraggingState()
		let ds: GridScapeDeckDraggingState = self.playDeckDraggingState!
		
		guard (self.tileDeckCellView != nil) else { return }
		
		// Set originCellView
		ds.set(originCellView: self.tileDeckCellView!)
		
		ds.type				= .Tile
		ds.fromIndicated 	= fromIndicated
		
	}
	
	fileprivate func handleDeckCellViewDraggingContinued(currentIndicated: CGPoint) {
		
		guard (self.gridScapeManager != nil) else { return }
		
		// Check playDeckDraggingState
		guard (self.playDeckDraggingState != nil && self.playDeckDraggingState!.isDraggingYN) else { return }
		
		let ds: 							GridScapeDeckDraggingState = self.playDeckDraggingState!
		
		guard (ds.originCellView != nil && ds.fromIndicated != nil) else { return }
		guard (ds.type == .Cell || (ds.type == .Tile && ds.originCellView!.tileViews.count > 0)) else { return }
		
		// Create transform
		let t: 								CGAffineTransform = CGAffineTransform(translationX: currentIndicated.x - ds.fromIndicated!.x, y: currentIndicated.y - ds.fromIndicated!.y)
		
		// Set transform
		ds.originView!.transform 			= t
		
		// Get current point middle of dragging cellview
		let currentDraggingPoint: 			CGPoint = CGPoint(x: ds.originView!.frame.midX, y: ds.originView!.frame.midY)
		
		// Convert to point inside deckContainerView
		//let currentDraggingPointInDeckContainerView		= self.deckCellContainerView!.convert(currentDraggingPoint, to: self.deckContainerView)
		
		// Convert originView to frame inside contentView
		let originViewFrameInContentView: 	CGRect = self.contentView.convert(ds.originView!.frame, from: ds.originView!.superview!)

		// Check current point is inside gridScapeDeckView
		//let insideDeckYN: 					Bool = self.deckContainerView.frame.contains(currentDraggingPointInDeckContainerView)
		let insideDeckYN: 					Bool = originViewFrameInContentView.intersects(self.deckContainerView.frame)
		if (insideDeckYN != ds.insideDeckYN || ds.isInitialYN) {
			print((insideDeckYN) ? "In deck!" : "Not in deck!")
		}
		ds.insideDeckYN 					= insideDeckYN
		ds.isInitialYN 						= false
		
		guard (!ds.insideDeckYN) else { return }
		
		// Convert to point inside gridScapeView
		ds.currentIndicatedInGridScapeView	= self.deckCellContainerView.convert(currentDraggingPoint, to: self.gridScapeManager!.gridScapeView!)
		
		// Get cellCoord for current point
		let cc: 							CellCoord = self.gridScapeManager!.get(cellCoord: ds.currentIndicatedInGridScapeView!)
		
		guard (ds.currentCellCoord == nil || (ds.currentCellCoord != nil && !ds.currentCellCoord!.equals(cellCoord: cc))) else { return }
		
		ds.currentCellCoord 				= cc
		
		if (ds.type == .Cell) {
			
			// Set canDropYN cellView
			ds.canDropYN 					= self.gridScapeManager!.canDrop(cellView: ds.originCellView!, at: cc)
			
		} else if (ds.type == .Tile) {
			
			// Set canDropYN tileView
			ds.canDropYN 					= self.gridScapeManager!.canDrop(tileView: ds.originCellView!.tileViews.values.first!, at: cc)
			
		}
		
	}
	
	fileprivate func handleDeckCellViewDraggingStopped() {
		
		guard (self.gridScapeManager != nil) else { return }
		
		// Check playDeckDraggingState
		guard (self.playDeckDraggingState != nil && self.playDeckDraggingState!.isDraggingYN) else { return }
		
		let ds: GridScapeDeckDraggingState = self.playDeckDraggingState!
		
		guard (ds.originCellView != nil && ds.currentIndicatedInGridScapeView != nil
			&& !ds.insideDeckYN && ds.canDropYN && (ds.type == .Cell || (ds.type == .Tile && ds.originCellView!.tileViews.count > 0))) else {
			
			// Reposition in deck
			if (ds.originView != nil) {
				
				ds.originView!.transform = CGAffineTransform(translationX: 0, y: 0)
				
			}
			
			ds.clear()
			self.playDeckDraggingState = nil
			
			return
				
		}
		
		if (ds.type == .Cell) {
			
			// Create completion handler
			let didDropCellViewCompletionHandler: ((ProtocolGridCellView?, Error?) -> Void) =
			{
				(cellView, error) -> Void in
				
				ds.clear()
				self.playDeckDraggingState = nil
				
				// Notify the delegate
				self.delegate!.playDeckView(sender: self, didDrop: cellView!)
				
			}
			
			// Drop cellView
			self.gridScapeManager!.didDrop(cellView: ds.originCellView!, at: ds.currentIndicatedInGridScapeView!, oncomplete: didDropCellViewCompletionHandler)
			
		} else if (ds.type == .Tile) {
			
			// Create completion handler
			let didDropTileViewCompletionHandler: ((ProtocolGridTileView?, Error?) -> Void) =
			{
				(tileView, error) -> Void in
				
				ds.clear()
				self.playDeckDraggingState = nil
				
				// Notify the delegate
				self.delegate!.playDeckView(sender: self, didDrop: tileView!)
				
			}
			
			ds.originView!.removeFromSuperview()
			
			// Drop cellView
			self.gridScapeManager!.didDrop(tileView: ds.originCellView!.tileViews.values.first!, at: ds.currentIndicatedInGridScapeView!, oncomplete: didDropTileViewCompletionHandler)
			
		}
		
	}
	
	fileprivate func addCellViewToCellDeck(playDeckCellView: ProtocolGridCellView) {
		
		guard (self.gridScapeManager != nil) else { return }
		
		self.playDeckCellView 	= playDeckCellView
		
		let v: 					UIView = playDeckCellView as! UIView
		
		// Set gridCellProperties
		let gcp: 				GridCellProperties = playDeckCellView.gridCellProperties!
		
		gcp.cellHeight 			= self.gridScapeManager!.gridProperties.cellHeight
		gcp.cellWidth 			= self.gridScapeManager!.gridProperties.cellWidth
		gcp.backgroundColor 	= UIColor.red
		gcp.borderColor			= UIColor.black
		gcp.borderWidth			= 1
		
		self.playDeckCellView!.set(canTapYN: false)		// Nb: This must be disabled so that we can handle tap gestures here on the cellView
		
		// Present playDeckCellView
		playDeckCellView.present()
		
		// Set playDeckCellViewLongPressGestureRecognizer
		self.playDeckCellViewLongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(playDeckCellViewLongPressed(_:)))
		v.addGestureRecognizer(self.playDeckCellViewLongPressGestureRecognizer!)

		// Set playDeckCellViewTapGestureRecognizer
		self.playDeckCellViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(playDeckCellViewTapped(_:)))
		v.addGestureRecognizer(self.playDeckCellViewTapGestureRecognizer!)
		
		self.deckCellContainerView.addSubview(v)
		
		// Set layout constraints
		v.trailingAnchor.constraint(equalTo: self.deckCellContainerView.trailingAnchor, constant: 0).isActive = true
		v.topAnchor.constraint(equalTo: self.deckCellContainerView.topAnchor, constant: 0).isActive = true
		
		v.translatesAutoresizingMaskIntoConstraints = false
		
		self.layoutIfNeeded()
		
	}
	
	fileprivate func addTileViewToTileDeck(playDeckTileView: ProtocolGridTileView) {
		
		guard (self.gridScapeManager != nil) else { return }
		
		// Get tileDeckCellView
		self.tileDeckCellView 	= self.createTileDeckCellView()
		
		self.tileDeckCellView!.set(delegate: self)
		
		let v: 					UIView = self.tileDeckCellView as! UIView
		
		// Set gridCellProperties
		let gcp: 				GridCellProperties = self.tileDeckCellView!.gridCellProperties!
		
		gcp.cellHeight 			= self.gridScapeManager!.gridProperties.cellHeight
		gcp.cellWidth 			= self.gridScapeManager!.gridProperties.cellWidth
		
		self.tileDeckCellView!.set(canTapYN: false)		// Nb: This must be disabled so that we can handle tap gestures here on the cellView
		
		// Present tileDeckCellView
		self.tileDeckCellView!.present()
		
		// Set tileDeckCellViewLongPressGestureRecognizer
		self.tileDeckCellViewLongPressGestureRecognizer = UILongPressGestureRecognizer(target: self, action: #selector(tileDeckCellViewLongPressed(_:)))
		v.addGestureRecognizer(self.tileDeckCellViewLongPressGestureRecognizer!)
		
		// Set tileDeckCellViewTapGestureRecognizer
		self.tileDeckCellViewTapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(tileDeckCellViewTapped(_:)))
		v.addGestureRecognizer(self.tileDeckCellViewTapGestureRecognizer!)
		
		playDeckTileView.set(canTapYN: false)			// Nb: This must be disabled so that we can handle tap gestures here on the tileView
		
		// Present playDeckTileView
		self.tileDeckCellView!.present(tileView: playDeckTileView)
		
		self.deckTileContainerView.addSubview(v)
		
		// Set layout constraints
		v.trailingAnchor.constraint(equalTo: self.deckTileContainerView.trailingAnchor, constant: 0).isActive = true
		v.topAnchor.constraint(equalTo: self.deckTileContainerView.topAnchor, constant: 0).isActive = true
		
		v.translatesAutoresizingMaskIntoConstraints = false
		
		self.layoutIfNeeded()
		
	}
	
	fileprivate func setGridScapeManager() {
		
		guard (self.delegate != nil) else { return }
		
		self.gridScapeManager = self.delegate!.playDeckView(toGridScapeManager: self)
		
	}
	
	fileprivate func setPlayDeckViewMode(mode: PlayDeckViewModes) {
		
		self.playDeckViewMode 						= mode
		
		self.deckCellContainerView.alpha 			= (mode == .Cell) ? 1 : 0
		self.deckCellRotateRightImageView.alpha 	= (mode == .Cell) ? 1 : 0
		self.deckTileContainerView.alpha 			= (mode == .Tile) ? 1 : 0
		
	}
	
	fileprivate func doClearCellDeck() {
		
		self.playDeckDraggingState 	= nil
		
		// Check playDeckCellView
		if (self.playDeckCellView != nil) {
			
			// Remove playDeckCellView
			(self.playDeckCellView as! UIView).removeFromSuperview()
			self.playDeckCellView 	= nil
			
		}
		
	}

	fileprivate func doClearTileDeck() {
		
		self.playDeckDraggingState 	= nil
		
		// Check tileDeckCellView
		if (self.tileDeckCellView != nil) {
			
			// Remove tileDeckCellView
			(self.tileDeckCellView as! UIView).removeFromSuperview()
			self.tileDeckCellView 	= nil
			
		}
		
	}
	
	fileprivate func createTileDeckCellView() -> ProtocolGridCellView {
		
		let result: 				GridCellViewBase = GridCellViewBase(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		// Create cellWrapper
		let cellWrapper: 			CellWrapperBase = CellWrapperBase()
		cellWrapper.column 			= 0
		cellWrapper.row 			= 0
		
		// Create gridCellProperties
		let gcp: 					GridCellProperties = GridCellProperties(cellCoord: CellCoord(column: 0, row: 0))
		
		gcp.canDragYN				= false
		gcp.canTapYN				= false
		gcp.canLongPressYN			= false
		gcp.backgroundColor			= UIColor.clear
		
		result.gridCellProperties 	= gcp
		
		return result
		
	}
	
	fileprivate func doCheckHitTest(deckCellRotateRightImageView point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		guard (self.playDeckViewMode == .Cell) else { return nil }
		
		// Convert to point inside deckCellRotateRightImageView
		let deckCellRotateRightImageViewPoint = self.contentView.convert(point, to: self.deckCellRotateRightImageView!)
		
		// Check point inside deckCellRotateRightImageView
		if (self.deckCellRotateRightImageView!.point(inside: deckCellRotateRightImageViewPoint, with: event)) {
			
			return self.deckCellRotateRightImageView
			
		}
		
		return nil
		
	}
	
	fileprivate func doCheckHitTest(deckCellSwapImageView point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		//guard (self.playDeckViewMode == .Cell) else { return nil }
		
		// Convert to point inside deckCellSwapImageView
		let deckCellSwapImageViewPoint = self.contentView.convert(point, to: self.deckCellSwapImageView!)
		
		// Check point inside deckCellSwapImageView
		if (self.deckCellSwapImageView!.point(inside: deckCellSwapImageViewPoint, with: event)) {
			
			return self.deckCellSwapImageView
			
		}
		
		return nil
		
	}
	
	fileprivate func doCheckHitTest(deckTileSwapImageView point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		//guard (self.playDeckViewMode == .Tile) else { return nil }
		
		// Convert to point inside deckTileSwapImageView
		let deckTileSwapImageViewPoint = self.contentView.convert(point, to: self.deckTileSwapImageView!)
		
		// Check point inside deckTileSwapImageView
		if (self.deckTileSwapImageView!.point(inside: deckTileSwapImageViewPoint, with: event)) {
			
			return self.deckTileSwapImageView
			
		}
		
		return nil
		
	}
	
	fileprivate func doCheckHitTest(deckContainerView point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		// Convert to point inside deckContainerView
		let deckContainerViewPoint = self.contentView.convert(point, to: self.deckContainerView!)
		
		// Check point inside deckContainerView
		if (self.deckContainerView!.point(inside: deckContainerViewPoint, with: event)) {
			
			return self.deckContainerView
			
		}
		
		return nil
		
	}

	fileprivate func doCheckHitTest(playDeckCellView point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		guard (self.playDeckViewMode == .Cell && self.playDeckCellView != nil) else { return nil }
		
		let v: UIView = self.playDeckCellView! as! UIView
		
		// Convert to point inside playDeckCellView
		let playDeckCellViewPoint = self.contentView.convert(point, to: v)
		
		// Check point inside playDeckCellView
		if (v.point(inside: playDeckCellViewPoint, with: event)) {
			
			return v
			
		}
		
		return nil
		
	}
	
	fileprivate func doCheckHitTest(tileDeckCellView point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		guard (self.playDeckViewMode == .Tile && self.tileDeckCellView != nil) else { return nil }
		
		let v: UIView = self.tileDeckCellView! as! UIView
		
		// Convert to point inside tileDeckCellView
		let tileDeckCellViewPoint = self.contentView.convert(point, to: v)
		
		// Check point inside tileDeckCellView
		if (v.point(inside: tileDeckCellViewPoint, with: event)) {
			
			return v
			
		}
		
		return nil
		
	}
	
	
	// MARK: - playDeckCellView LongPressGestureRecognizer Methods
	
	@IBAction func playDeckCellViewLongPressed(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playDeckView(touchesBegan: self)
		
		let sender = sender as! UILongPressGestureRecognizer
		
		if (sender.state == .began) {
			
			// Dragging started
			self.handleCellDeckCellViewDraggingStarted(fromIndicated: sender.location(in: self.contentView))
			
		} else if (sender.state == .changed) {
			
			// Dragging continued
			self.handleDeckCellViewDraggingContinued(currentIndicated: sender.location(in: self.contentView))
			
		} else if (sender.state == .ended) {
			
			// Dragging stopped
			self.handleDeckCellViewDraggingStopped()
			
		}
		
	}

	
	// MARK: - playDeckCellView LongPressGestureRecognizer Methods
	
	@IBAction func playDeckCellViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playDeckView(touchesBegan: self)
		
	}
	
	
	// MARK: - tileDeckCellView LongPressGestureRecognizer Methods
	
	@IBAction func tileDeckCellViewLongPressed(_ sender: Any) {

		// Notify the delegate
		self.delegate?.playDeckView(touchesBegan: self)
		
		let sender = sender as! UILongPressGestureRecognizer
		
		if (sender.state == .began) {
			
			// Dragging started
			self.handleTileDeckCellViewDraggingStarted(fromIndicated: sender.location(in: self.contentView))
			
		} else if (sender.state == .changed) {
			
			// Dragging continued
			self.handleDeckCellViewDraggingContinued(currentIndicated: sender.location(in: self.contentView))
			
		} else if (sender.state == .ended) {
			
			// Dragging stopped
			self.handleDeckCellViewDraggingStopped()
			
		}
		
	}
	
	
	// MARK: - tileDeckCellView LongPressGestureRecognizer Methods
	
	@IBAction func tileDeckCellViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playDeckView(touchesBegan: self)
		
	}
	
	
	// MARK: - rotateRightImageView TapGestureRecogniser Methods
	
	@IBAction func rotateRightImageViewTapped(_ sender: Any) {
		
		guard (self.playDeckCellView != nil) else { return }
		
		// Rotate the cell
		self.playDeckCellView!.rotateRight()
		
	}
	
	
	// MARK: - swapCellImageView TapGestureRecogniser Methods
	
	@IBAction func swapCellImageViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate!.playDeckView(swapCellButtonTapped: self)
		
	}
	
	
	// MARK: - swapTileImageView TapGestureRecogniser Methods
	
	@IBAction func swapTileImageViewTapped(_ sender: Any) {

		// Notify the delegate
		self.delegate!.playDeckView(swapTileButtonTapped: self)
		
	}
	
}

// MARK: - Extension ProtocolPlayDeckViewControlManagerDelegate

extension PlayDeckView: ProtocolPlayDeckViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolGridCellViewDelegate

extension PlayDeckView: ProtocolGridCellViewDelegate {
	
	// MARK: - Public Methods
	
	public func gridCellView(propertyChanged wrapper: CellPropertyChangedWrapper, cellCoord: CellCoord, with cellView: ProtocolGridCellView?) {
		
	}
	
	public func gridCellView(touchesBegan cellView: ProtocolGridCellView) {
		
	}
	
	public func gridCellView(for gesture: UITapGestureRecognizer, tapped cellView: ProtocolGridCellView) {
		
	}
	
	public func gridCellView(getTileViewDelegate sender: ProtocolGridCellView) -> ProtocolGridTileViewDelegate? {
		
		return self
		
	}
	
	public func gridCellView(getTokenViewDelegate sender: ProtocolGridCellView) -> ProtocolGridTokenViewDelegate? {
		
		return nil
		
	}
	
}


// MARK: - Extension ProtocolGridTileViewDelegate

extension PlayDeckView: ProtocolGridTileViewDelegate {
	
	// MARK: - Public Methods
	
	public func gridTileView(propertyChanged wrapper: CellPropertyChangedWrapper, cellCoord: CellCoord, with tileView: ProtocolGridTileView?) {
		
	}
	
	public func gridTileView(touchesBegan tileView: ProtocolGridTileView) {
		
	}
	
	public func gridTileView(for gesture: UITapGestureRecognizer, tapped tileView: ProtocolGridTileView) {
		
	}
	
	public func gridTileView(setPosition tileView: ProtocolGridTileView) {
		
		// Get cellCoord
		let cellCoord: 			CellCoord? = tileView.gridTileProperties?.cellCoord
		
		guard (cellCoord != nil) else { return }
		
		// Get cellView
		let cellView: 			ProtocolGridCellView? = self.tileDeckCellView
		
		guard (cellView != nil) else { return }
		
		cellView!.setPosition(tileView: tileView)
		
	}
	
}

