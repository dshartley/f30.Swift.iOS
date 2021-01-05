//
//  PlayAreaView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFSocial
import SFSerialization
import SFGridScape
import SFCore
import f30Core
import f30Model
import f30View
import f30Controller

/// A view class for a PlayAreaView
public class PlayAreaView: UIView, ProtocolPlayAreaView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						PlayAreaViewControlManager?
	fileprivate var hasViewAppearedYN:					Bool = false
	fileprivate var isNotConnectedAlertIsShownYN:		Bool = false

	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayAreaViewDelegate?
	public fileprivate(set) var gridScapeManager:		GridScapeManager?
	
	@IBOutlet weak var contentView:						UIView!
	@IBOutlet weak var gridScapeView: 					GridScapeView!
	@IBOutlet weak var gridScapePlaceholderView: 		UIView!
	
	
	// DEBUG:
	
	@IBOutlet weak var debugViewLabelTopConstraint: 	NSLayoutConstraint!
	@IBOutlet weak var debugViewLabelLeadingConstraint: NSLayoutConstraint!

	
	// MARK: - Public Computed Properties
	
	public var gridScapeContainerViewControlManager: 	GridScapeContainerViewControlManager? {
		get {
			
			return self.controlManager!.gridScapeContainerViewControlManager
			
		}
	}
	
	
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
	
	// Comment; touchesBegan won't be invoked because a UIScrollView is used to frame the content. We implement a tap gesture recognizer on the UIScrollView to call endTyping.
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
	}
	

	// MARK: - Public Methods
	
	public func viewDidAppear() {
	
		self.hasViewAppearedYN 	= true
		
	}
	
	public func clearView() {

		self.controlManager!.clear()
		
		self.gridScapeManager!.clear()
		
	}
	
	public func set(relativeMemberWrapper: RelativeMemberWrapper, playGameWrapper: PlayGameWrapper, playAreaID: String, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let buildGridScapeViewCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		self.controlManager!.set(relativeMemberWrapper: relativeMemberWrapper, playGameWrapper: playGameWrapper, playAreaID: playAreaID)
		
		// Build gridScapeView
		self.buildGridScapeView(oncomplete: buildGridScapeViewCompletionHandler)
		
	}
	
	public func endMovingTokenView() {
	
		guard (self.controlManager!.isMovingTokenYN) else { return }
		
		self.controlManager!.set(isMovingTokenYN: false)
		
	}
	
	public func cancelTransientViews() {
		
		self.endMovingTokenView()
		
	}
	
	public func set(changedPlayAreaPathAbility wrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper) {
		
		// Get cellCoord
		let cellCoord: 	CellCoord = CellCoord(column: playAreaTokenWrapper.column, row: playAreaTokenWrapper.row)
		
		// Get tokenView
		let tokenView: 	ProtocolPlayAreaGridTokenView? = self.gridScapeManager?.get(tokenView: playAreaTokenWrapper.id, at: cellCoord) as? ProtocolPlayAreaGridTokenView
		
		guard (tokenView != nil) else { return }
		
		// Check properties
		if (wrapper.isEngagedYN && !wrapper.isGoingYN) {
			
			// Set IsEngaged
			tokenView!.setPlayAreaPathAbilityDisplay(type: .IsEngaged)
			
		} else if (wrapper.isGoingYN) {
			
			// Set IsGoing
			tokenView!.setPlayAreaPathAbilityDisplay(type: .IsGoing)
			
		} else {
			
			// Set None
			tokenView!.setPlayAreaPathAbilityDisplay(type: .None)
			
		}

	}

	public func setPlayAreaPath(playAreaPathWrapper: PlayAreaPathWrapper, visibleYN: Bool) {
	
		guard (playAreaPathWrapper.pathPoints != nil) else { return }
		
		// Go through each item
		for pappw in playAreaPathWrapper.pathPoints!.values {
			
			// Get cellCoord
			let cellCoord: 	CellCoord = CellCoord(column: pappw.column, row: pappw.row)
			
			// Get cellView
			let cellView: 	ProtocolGridCellView? = self.gridScapeManager!.get(cellView: cellCoord)
			
			guard (cellView != nil) else { return }
			
			if let cv = cellView as? ProtocolPlayAreaGridCellView {
				
				if (visibleYN) {
					
					// Present playAreaPathPointWrapper
					cv.present(playAreaPathPointWrapper: pappw as! PlayAreaPathPointWrapper)
					
				} else {
					
					// Hide playAreaPathPointWrapper
					cv.hide(playAreaPathPointWrapper: pappw as! PlayAreaPathPointWrapper)
					
				}
				
			}
			
		}

	}
	
	
	// MARK: - ProtocolPlayAreaView; Public Methods
	
	public func move(playAreaTokenWrapper: PlayAreaTokenWrapper, alongPath playAreaPathWrapper: PlayAreaPathWrapper, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let moveTokenAlongPathCompletionHandler: ((PathWrapperBase, Error?) -> Void) =
		{
			(pathWrapper, error) -> Void in
			
			self.endMovingTokenView()
			
			// Call the completion handler
			completionHandler(error)
			
		}
		
		// Get fromCellCoord
		let fromCellCoord: CellCoord = CellCoord(column: playAreaTokenWrapper.column, row: playAreaTokenWrapper.row)
		
		self.controlManager!.set(isMovingTokenYN: true)
		
		// Move token
		self.gridScapeManager!.move(tokenFrom: fromCellCoord, alongPath: playAreaPathWrapper, oncomplete: moveTokenAlongPathCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayAreaViewControlManager()
		
		self.controlManager!.delegate 	= self
	
		self.controlManager!.setUrls(imagesUrlRoot: UrlsHelper.imagesUrlRoot)
		
		// gridScapeContainerView
		self.setupGridScapeContainerViewControlManager()
		
	}
	
	fileprivate func setupGridScapeContainerViewControlManager() {
		
		// Setup the control manager
		let controlManager: GridScapeContainerViewControlManager = GridScapeContainerViewControlManager()
		
		self.controlManager!.set(gridScapeContainerViewControlManager: controlManager)
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		ModelFactory.setupPlayAreaCellModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayAreaTileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayMoveModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		
		// gridScapeContainerView
		self.setupGridScapeContainerViewModelManager()
		
	}
	
	fileprivate func setupGridScapeContainerViewModelManager() {
		
		// Set the model manager
		self.controlManager!.gridScapeContainerViewControlManager!.set(modelManager: self.controlManager!.modelManager!)
		
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: PlayAreaViewViewAccessStrategy = PlayAreaViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playAreaView: self)
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayAreaViewViewManager(viewAccessStrategy: viewAccessStrategy)
		
		// gridScapeContainerView
		self.setupGridScapeContainerViewViewManager()
		
	}
	
	fileprivate func setupGridScapeContainerViewViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: GridScapeContainerViewViewAccessStrategy = GridScapeContainerViewViewAccessStrategy()
		
		viewAccessStrategy.setup(gridScapeView: self.gridScapeView)
		
		// Setup the view manager
		self.controlManager!.gridScapeContainerViewControlManager!.viewManager = GridScapeContainerViewViewManager(viewAccessStrategy: viewAccessStrategy)
		
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayAreaView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

		self.setupGridScape()
		self.setupGridScapeView()
		
	}
	
	fileprivate func setupGridScape() {
		
		self.gridScapeManager 			= GridScapeManager(gridScapeView: self.gridScapeView)
		
		self.gridScapeManager!.delegate	= self
		
		self.setupGridScapeProperties()
		
	}
	
	fileprivate func setupGridScapeProperties() {
		
		let gp: 								GridProperties = self.gridScapeManager!.gridProperties
		
		gp.cellWidth 							= 100
		gp.cellHeight 							= 100
		gp.marginTopBlocks 						= 1
		gp.marginRightBlocks 					= 1
		gp.marginBottomBlocks 					= 1
		gp.marginLeftBlocks 					= 1
		gp.blockWidthCells 						= 3
		gp.blockHeightCells 					= 3
		gp.horizontalScrollYN					= true
		gp.verticalScrollYN						= true
		gp.scrollLimitToPopulatedCellsYN		= false
		gp.blockCoordsVisibleYN					= true
		gp.gridLinesVisibleYN					= true
		gp.gridLinesColor 						= UIColor.darkGray
		gp.gridLinesAlpha 						= 0.4
		gp.blockBackgroundColorOnYN				= false
		gp.blockBackgroundColor					= nil
		gp.cellBackgroundColor					= UIColor.white
		gp.cellBorderColor						= nil
		gp.cellBorderWidth						= 1.0
		gp.cellHighlightBorderColor				= UIColor.yellow
		gp.cellHighlightFilterColor				= UIColor.yellow
		gp.alternatingCellBackgroundColorOnYN	= false
		gp.dragAndDropCellsYN					= false
		gp.dragAndDropTilesYN					= false
		
	}
	
	fileprivate func setupGridScapeView() {
		
		// Hide placeholder view which is just used for view in interface builder
		self.gridScapePlaceholderView.isHidden	= true
		
		self.gridScapeView.set(stateView: false)
		
	}
	
	fileprivate func buildGridScapeView(oncomplete completionHandler:@escaping (Error?) -> Void) {
	
		// Create completion handler
		let buildCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			//self.hideActivityIndicatorView()
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		self.retrieveGridScapeScrollPosition()
		
		// Build grid scape
		self.gridScapeManager!.build(oncomplete: buildCompletionHandler)
		
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
	
	fileprivate func storeGridScapeScrollPosition(indicatedOffsetX: CGFloat, indicatedOffsetY: CGFloat) {
		
		let prefix: String = self.controlManager!.playGameWrapper!.id

		SettingsManager.set(int: Int(indicatedOffsetX), forKey: "\(AppSettingsKeys.PlayAreaViewGridScapeIndicatedOffsetX)", prefix: prefix)
		
		SettingsManager.set(int: Int(indicatedOffsetY), forKey: "\(AppSettingsKeys.PlayAreaViewGridScapeIndicatedOffsetY)", prefix: prefix)
		
	}
	
	fileprivate func retrieveGridScapeScrollPosition() {
		
		let prefix: String = self.controlManager!.playGameWrapper!.id
		
		let indicatedOffsetX: Int = SettingsManager.get(intForKey: "\(AppSettingsKeys.PlayAreaViewGridScapeIndicatedOffsetX)", prefix: prefix) ?? 0
		let indicatedOffsetY: Int = SettingsManager.get(intForKey: "\(AppSettingsKeys.PlayAreaViewGridScapeIndicatedOffsetY)", prefix: prefix) ?? 0
		
		self.gridScapeManager!.set(gridPositionAt: CGFloat(indicatedOffsetX), indicatedOffsetY: CGFloat(indicatedOffsetY))

	}
	
	fileprivate func createGridCellView(cellWrapper: PlayAreaCellWrapper, cellCoord: CellCoord, with gridCellProperties: GridCellProperties, playAreaPathWrappers: [String:PlayAreaPathWrapper]?, playAreaPathPointWrappers: [String:PlayAreaPathPointWrapper]?) -> ProtocolGridCellView {
		
		// Create View
		let result: ProtocolPlayAreaGridCellView? = PlayViewFactory.createPlayAreaGridCellView(forPlayAreaCell: cellWrapper, with: gridCellProperties, delegate: nil)
		
		if (playAreaPathWrappers != nil && playAreaPathPointWrappers != nil) {
		
			// Go through each item
			for pappw in playAreaPathPointWrappers!.values {
			
				// Check cellCoord
				guard (pappw.column == cellCoord.column && pappw.row == cellCoord.row) else { continue }
				
				// Get playAreaPathWrapper
				let papw: PlayAreaPathWrapper? = playAreaPathWrappers![pappw.pathID]
				
				guard (papw != nil) else { continue }
				
				// Check isDisplayedYN
				guard (papw!.isDisplayedYN) else { continue }
				
				// Present playAreaPathPointWrapper
				result!.present(playAreaPathPointWrapper: pappw)
				
			}
			
		}
		
		return result as! ProtocolGridCellView
		
	}
	
}

	
// MARK: - Extension ProtocolPlayAreaViewControlManagerDelegate

extension PlayAreaView: ProtocolPlayAreaViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
	public func playAreaViewControlManager(isNotConnected error: Error?) {
		
		self.presentIsNotConnectedAlert()
		
		//self.hideActivityIndicatorView(animateYN: false)
		
	}
	
}


// MARK: - Extension ProtocolPlayExperienceContainerViewDelegate

extension PlayAreaView: ProtocolPlayExperienceContainerViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceContainerView(startExperienceFor playMoveWrapper: PlayMoveWrapper, delegate: ProtocolPlayExperienceViewDelegate, responseCompletionHandler: @escaping (MoveAlongPathResponseTypes, Error?) -> Void) {
		
		if let _delegate = self.delegate as? ProtocolPlayExperienceContainerViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceContainerView(startExperienceFor: playMoveWrapper, delegate: delegate, responseCompletionHandler: responseCompletionHandler)
			
		}
		
	}
	
}


// MARK: - Extension ProtocolPlayExperienceDelegate

extension PlayAreaView: ProtocolPlayExperienceViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceView(closeButtonTapped sender: ProtocolPlayExperienceView) {
		
		if let _delegate = self.delegate as? ProtocolPlayExperienceViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceView(closeButtonTapped: sender)
			
		}

	}
	
	public func playExperienceView(playExperienceCompleted wrapper: PlayExperienceWrapper, sender: ProtocolPlayExperienceView) {

		// Create completion handler
		let doAfterPlayExperienceCompletedCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in		// [unowned self]
			
			if let _delegate = self.delegate as? ProtocolPlayExperienceViewDelegate {
				
				// Notify the delegate
				_delegate.playExperienceView(playExperienceCompleted: wrapper, sender: sender)
				
			}
			
		}
		
		self.controlManager!.doAfterPlayExperienceCompleted(wrapper: wrapper, oncomplete: doAfterPlayExperienceCompletedCompletionHandler)
		
	}
	
	public func playExperienceView(presentPlayExperienceStepViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceView, delegate: ProtocolPlayExperienceStepViewDelegate) {
		
		if let _delegate = self.delegate as? ProtocolPlayExperienceViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceView(presentPlayExperienceStepViewFor: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper, sender: sender, delegate: delegate)
			
		}
		
	}
	
	public func playExperienceView(playExperienceStepCompleted wrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceView, oncomplete completionHandler:@escaping (Error?) -> Void, onuicomplete uiCompletionHandler:@escaping (Error?) -> Void) {

		if let _delegate = self.delegate as? ProtocolPlayExperienceViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceView(playExperienceStepCompleted: wrapper, sender: sender, oncomplete: completionHandler, onuicomplete: uiCompletionHandler)
			
		}
		
	}
	
	public func playExperienceView(playExperienceStepViewCloseButtonTapped sender: ProtocolPlayExperienceStepView) {
		
		if let _delegate = self.delegate as? ProtocolPlayExperienceViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceView(playExperienceStepViewCloseButtonTapped: sender)
			
		}
		
	}
	
}


// MARK: - Extension ProtocolGridScapeManagerDelegate

extension PlayAreaView: ProtocolGridScapeManagerDelegate {

	// MARK: - Public Methods
	
	public func gridScapeManager(isBuilding sender: GridScapeManager) {
		
		//self.presentActivityIndicatorView(animateYN: false)
		
	}
	
	public func gridScapeManager(isFinishedBuilding sender: GridScapeManager) {
		
		//self.hideActivityIndicatorView()
		
	}
	
	public func gridScapeManager(touchesBegan sender: GridScapeManager, on view: UIView?) {
		
		// Notify the delegate
		self.delegate?.playAreaView(touchesBegan: self, on: view)
		
	}
	
	public func gridScapeManager(tapped indicatedPoint: CGPoint, cellCoord: CellCoord) {
	
	}
	
	public func gridScapeManager(tapped cellView: ProtocolGridCellView, at indicatedPoint: CGPoint) {
		
		// Notify the delegate
		self.delegate?.playAreaView(tapped: cellView, at: indicatedPoint)
		
	}
	
	public func gridScapeManager(tapped tileView: ProtocolGridTileView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint) {
		
		// Notify the delegate
		self.delegate?.playAreaView(tapped: tileView, cellView: cellView, at: indicatedPoint)
		
	}
	
	public func gridScapeManager(tapped tokenView: ProtocolGridTokenView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint) {

		// Notify the delegate
		self.delegate?.playAreaView(tapped: tokenView, cellView: cellView, at: indicatedPoint)
		
	}
	
	public func gridScapeManager(longPressed cellView: ProtocolGridCellView, at indicatedPoint: CGPoint, gesture: UILongPressGestureRecognizer) {

	}
	
	public func gridScapeManager(longPressed tileView: ProtocolGridTileView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint, gesture: UILongPressGestureRecognizer) {

	}
	
	public func gridScapeManager(longPressed tokenView: ProtocolGridTokenView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint, gesture: UILongPressGestureRecognizer) {

		if (gesture.state == .began) {
			
			// Set moving tokenView
			self.controlManager!.set(isMovingTokenYN: true)
			
		} else if (gesture.state == .ended) {
			
		}
	
	}
	
	public func gridScapeManager(cellPropertyChanged key: String, cellCoord: CellCoord, with cellView: ProtocolGridCellView?) {
		
	}
	
	public func gridScapeManager(tilePropertyChanged key: String, cellCoord: CellCoord, with tileView: ProtocolGridTileView?) {
		
	}
	
	public func gridScapeManager(tokenPropertyChanged key: String, cellCoord: CellCoord, with tokenView: ProtocolGridTokenView?) {
		
	}
	
	public func gridScapeManager(gridScapeView: GridScapeView, cellViewForItemAt cellCoord: CellCoord) -> ProtocolGridCellView? {
		
		var result: 							ProtocolGridCellView? = nil
		
		// Get cellWrapper
		let cellWrapper:						PlayAreaCellWrapper? = self.controlManager!.gridScapeContainerViewControlManager!.get(cellWrapper: cellCoord) as? PlayAreaCellWrapper
		
		if (cellWrapper != nil) {
			
			// Get cellCoordRange
			let cellCoordRange: 				CellCoordRange = CellCoordRange(topLeft: cellCoord, bottomRight: cellCoord)
			
			// Get playAreaPathPointWrappers
			let playAreaPathPointWrappers: 		[String:PlayAreaPathPointWrapper]? = PlayWrapper.current!.get(byCellCoordRange: cellCoordRange, isDisplayedYN: true)
			
			// Get playAreaPathWrappers
			let playAreaPathWrappers: 			[String:PlayAreaPathWrapper]? = (playAreaPathPointWrappers != nil) ? PlayWrapper.current!.get(forPlayAreaPathPointWrappers: playAreaPathPointWrappers!) : nil
			
			// Create gridCellProperties
			let gridCellProperties: GridCellProperties = GridCellProperties(cellCoord: cellCoord)
			gridCellProperties.cellWidth		= self.gridScapeManager!.gridProperties.cellWidth
			gridCellProperties.cellHeight 		= self.gridScapeManager!.gridProperties.cellHeight
			
			// Create cellView
			result = self.createGridCellView(cellWrapper: cellWrapper!, cellCoord: cellCoord, with: gridCellProperties, playAreaPathWrappers: playAreaPathWrappers, playAreaPathPointWrappers: playAreaPathPointWrappers)
			
		}
		
		return result
		
	}
	
	public func gridScapeManager(gridScapeView: GridScapeView, tokenViewForItemAt cellCoord: CellCoord, key: String?, completionHandler:@escaping (ProtocolGridTokenView?, Error?) -> Void) {
		
	}
	
	public func gridScapeManager(unloadedCells cellCoords: [CellCoord]) {
		
	}
	
	public func gridScapeManager(unloadedCells cellCoordRange: CellCoordRange) {
		
	}
	
	public func gridScapeManager(scrollingBegan sender: GridScapeManager) {
		
		// Notify the delegate
		self.delegate?.playAreaView(scrollingBegan: self)
		
	}
	
	public func gridScapeManager(scrolled sender: GridScapeManager, indicatedOffsetX: CGFloat, indicatedOffsetY: CGFloat) {
		
		self.endMovingTokenView()
		
		self.storeGridScapeScrollPosition(indicatedOffsetX: indicatedOffsetX, indicatedOffsetY: indicatedOffsetY)
		
	}
	
	public func gridScapeManager(loadCells sender: GridScapeManager, cellCoordRange: CellCoordRange) {
		
		// TODO:
		// Get paths in cellCoordRange
		// When creating cellView set pathPoint on cellView to display the path
		
		// Create completion handler
		let loadCompletionHandler: (([String: Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil) else { return }
			
			// Get playAreaCellWrappers
			let playAreaCellWrappers: 				[PlayAreaCellWrapper]? = wrappers!["PlayAreaCells"] as? [PlayAreaCellWrapper]
			
			guard (playAreaCellWrappers != nil) else { return }
			
			// Get playAreaPathPointWrappers
			let playAreaPathPointWrappers: 			[String:PlayAreaPathPointWrapper]? = PlayWrapper.current!.get(byCellCoordRange: cellCoordRange, isDisplayedYN: true)
			
			// Get playAreaPathWrappers
			let playAreaPathWrappers: 				[String:PlayAreaPathWrapper]? = (playAreaPathPointWrappers != nil) ? PlayWrapper.current!.get(forPlayAreaPathPointWrappers: playAreaPathPointWrappers!) : nil
			
			// Go through each item
			for pacw in playAreaCellWrappers! {
				
				// Get cellCoord
				let cc: 							CellCoord = CellCoord(column: pacw.column, row: pacw.row)
				
				// Create gridCellProperties
				let gridCellProperties: 			GridCellProperties = GridCellProperties(cellCoord: cc)
				gridCellProperties.cellWidth		= self.gridScapeManager!.gridProperties.cellWidth
				gridCellProperties.cellHeight 		= self.gridScapeManager!.gridProperties.cellHeight
				
				// Create cellView
				let cv: 							ProtocolGridCellView? = self.createGridCellView(cellWrapper: pacw, cellCoord: cc, with: gridCellProperties, playAreaPathWrappers: playAreaPathWrappers, playAreaPathPointWrappers: playAreaPathPointWrappers)
				
				// Present cellView
				self.gridScapeManager!.present(cellView: cv!, at: cc)
				
			}
			
		}
		
		// Load the data
		self.controlManager!.loadPlayAreaCells(for: RelativeMemberWrapper.current!, playGameID: self.controlManager!.playGameWrapper!.id, playAreaID: self.controlManager!.playAreaID!, cellCoordRange: cellCoordRange, oncomplete: loadCompletionHandler)
		
	}
	
	public func gridScapeManager(loadCells sender: GridScapeManager, cellCoordRange: CellCoordRange, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let loadCompletionHandler: (([String: Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call the completion handler
			completionHandler(error)
			
		}
		
		// Load the data
		self.controlManager!.loadPlayAreaCells(for: RelativeMemberWrapper.current!, playGameID: self.controlManager!.playGameWrapper!.id, playAreaID: self.controlManager!.playAreaID!, cellCoordRange: cellCoordRange, oncomplete: loadCompletionHandler)
		
	}
	
	public func gridScapeManager(canDrop cellView: ProtocolGridCellView, at cellCoord: CellCoord) -> Bool {
		
		return true
		
	}
	
	public func gridScapeManager(cellMoved cellView: ProtocolGridCellView, from fromCellCoord: CellCoord, to toCellCoord: CellCoord) {
		
	}
	
	public func gridScapeManager(cellDropped cellView: ProtocolGridCellView, at toCellCoord: CellCoord) {
		
		// Create cellWrapper
		let cellWrapper:			PlayAreaCellWrapper = self.controlManager!.createPlayAreaCellWrapper(for: self.controlManager!.playGameWrapper!)

		// Copy from cellView
		self.controlManager!.gridScapeContainerViewControlManager!.copy(from: cellView, to: cellWrapper)
		
		// Go through each tileView
		for tileView in cellView.tileViews.values {
			
			// Create tileWrapper
			let tileWrapper:		TileWrapperBase = TileWrapperBase()
			
			// Copy from tileView
			self.controlManager!.gridScapeContainerViewControlManager!.copy(from: tileView, to: tileWrapper)
			
			cellWrapper.tileWrapper = tileWrapper
			
		}
		
		// Create completion handler
		let addCellCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// TODO:
			
		}
		
		// Add cell
		self.controlManager!.gridScapeContainerViewControlManager!.addCell(cellWrapper: cellWrapper, cellCoord: toCellCoord, oncomplete: addCellCompletionHandler)
		
	}
	
	public func gridScapeManager(canDrop tileView: ProtocolGridTileView, at cellCoord: CellCoord) -> Bool {
		
		return true
		
	}
	
	public func gridScapeManager(tileMoved tileView: ProtocolGridTileView, from fromCellCoord: CellCoord, to toCellCoord: CellCoord) {
		
	}
	
	public func gridScapeManager(tileDropped tileView: ProtocolGridTileView, at toCellCoord: CellCoord) {
		
		// Create tileWrapper
		let tileWrapper:			PlayAreaTileWrapper = self.controlManager!.createPlayAreaTileWrapper(for: self.controlManager!.playGameWrapper!)
		
		// Copy from tileView
		self.controlManager!.gridScapeContainerViewControlManager!.copy(from: tileView, to: tileWrapper)

		// Set position
		tileWrapper.position 		= tileView.tileWrapper.position
		
		// Nb: We don't want to keep these properties as we want these to come from the playAreaTileType
		tileWrapper.widthPixels 	= 0
		tileWrapper.heightPixels 	= 0
		
		// Create completion handler
		let savePlayAreaTileDataCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Not required
		}
		
		// Create completion handler
		let addTileCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// TODO:
			// Check ID is set
			
			// Set playAreaTileID
			tileWrapper.playAreaTileData!.playAreaTileID 	= tileWrapper.id
			tileWrapper.playAreaTileData!.status 			= .new
			
			// Save playAreaTileData
			self.controlManager!.savePlayAreaTileData(wrapper: tileWrapper.playAreaTileData!, oncomplete: savePlayAreaTileDataCompletionHandler)
			
		}
		
		// Add tile
		self.controlManager!.gridScapeContainerViewControlManager!.addTile(tileWrapper: tileWrapper, cellCoord: toCellCoord, oncomplete: addTileCompletionHandler)
		
	}
	
	public func gridScapeManager(canDrop tokenView: ProtocolGridTokenView, at cellCoord: CellCoord) -> Bool {
		
		guard (self.controlManager!.isMovingTokenYN) else { return false }
		
		return true
		
	}
	
	public func gridScapeManager(tokenMoved tokenView: ProtocolGridTokenView, from fromCellCoord: CellCoord, to toCellCoord: CellCoord) {

		self.controlManager!.set(isMovingTokenYN: false)
		
		let saveTokenCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Not required
			
		}
		
		// Save token
		self.controlManager!.gridScapeContainerViewControlManager!.saveToken(afterMoved: tokenView, from: fromCellCoord, oncomplete: saveTokenCompletionHandler)
		
	}

	public func gridScapeManager(tokenMoving tokenView: ProtocolGridTokenView, alongPath pathWrapper: PathWrapperBase, doBeforeStartMovingAlongPath sender: GridScapeManager, completionHandler: @escaping (MoveAlongPathResponseTypes, Error?) -> Void) {

		// Get PlayMoveWrapper
		let pmw: PlayMoveWrapper? = (pathWrapper as! PlayAreaPathWrapper).get(playReferenceType: .PlayAreaPath, playReferenceID: pathWrapper.id, playReferenceActionType: .BeforeStartMovingAlongPath)
		
		// Create completion handler
		let playExperienceContainerViewStartExperienceCompletionHandler: ((MoveAlongPathResponseTypes, Error?) -> Void) =
		{
			(response, error) -> Void in
			
			// Call the completion handler
			completionHandler(response, nil)
			
		}
		
		if (pmw == nil) {
			
			// Call the completion handler
			completionHandler(.Continue, nil)

		} else if let _delegate = self.delegate as? ProtocolPlayExperienceContainerViewDelegate {

			// Notify the delegate
			_delegate.playExperienceContainerView(startExperienceFor: pmw!, delegate: self, responseCompletionHandler: playExperienceContainerViewStartExperienceCompletionHandler)
			
		} else {
			
			// Call the completion handler
			completionHandler(.Continue, nil)
			
		}

	}
	
	public func gridScapeManager(tokenMoving tokenView: ProtocolGridTokenView, alongPath pathWrapper: PathWrapperBase, from fromPathPointWrapper: PathPointWrapperBase, to toPathPointWrapper: PathPointWrapperBase, doBeforeMovePoint sender: GridScapeManager, completionHandler:@escaping (MoveAlongPathResponseTypes, Error?) -> Void) {
		
		// Get PlayMoveWrapper
		let pmw: PlayMoveWrapper? = (pathWrapper as! PlayAreaPathWrapper).get(playReferenceType: .PlayAreaPathPoint, playReferenceID: toPathPointWrapper.id, playReferenceActionType: .BeforeMoveToPathPoint)
		
		// Create completion handler
		let playExperienceContainerViewStartExperienceCompletionHandler: ((MoveAlongPathResponseTypes, Error?) -> Void) =
		{
			(response, error) -> Void in
			
			// Call the completion handler
			completionHandler(response, nil)
			
		}
		
		if (pmw == nil) {
			
			// Call the completion handler
			completionHandler(.Continue, nil)
			
		} else if let _delegate = self.delegate as? ProtocolPlayExperienceContainerViewDelegate {

			// Notify the delegate
			_delegate.playExperienceContainerView(startExperienceFor: pmw!, delegate: self, responseCompletionHandler: playExperienceContainerViewStartExperienceCompletionHandler)
			
		} else {
			
			// Call the completion handler
			completionHandler(.Continue, nil)
			
		}

	}
	
	public func gridScapeManager(tokenMoving tokenView: ProtocolGridTokenView, alongPath pathWrapper: PathWrapperBase, from fromPathPointWrapper: PathPointWrapperBase, to toPathPointWrapper: PathPointWrapperBase, doAfterMovePoint sender: GridScapeManager, completionHandler:@escaping (MoveAlongPathResponseTypes, Error?) -> Void) {
		
		// Get PlayMoveWrapper
		let pmw: PlayMoveWrapper? = (pathWrapper as! PlayAreaPathWrapper).get(playReferenceType: .PlayAreaPathPoint, playReferenceID: toPathPointWrapper.id, playReferenceActionType: .AfterMoveToPathPoint)
		
		// Create completion handler
		let playExperienceContainerViewStartExperienceCompletionHandler: ((MoveAlongPathResponseTypes, Error?) -> Void) =
		{
			(response, error) -> Void in
			
			// Call the completion handler
			completionHandler(response, nil)
			
		}
		
		if (pmw == nil) {
			
			// Call the completion handler
			completionHandler(.Continue, nil)
			
		} else if let _delegate = self.delegate as? ProtocolPlayExperienceContainerViewDelegate {

			// Notify the delegate
			_delegate.playExperienceContainerView(startExperienceFor: pmw!, delegate: self, responseCompletionHandler: playExperienceContainerViewStartExperienceCompletionHandler)
			
		} else {
			
			// Call the completion handler
			completionHandler(.Continue, nil)
			
		}
		
	}
	
	public func gridScapeManager(tokenMoving tokenView: ProtocolGridTokenView, alongPath pathWrapper: PathWrapperBase, doAfterFinishedMovingAlongPath sender: GridScapeManager, completionHandler: @escaping (MoveAlongPathResponseTypes, Error?) -> Void) {
	
		// Get PlayMoveWrapper
		let pmw: PlayMoveWrapper? = (pathWrapper as! PlayAreaPathWrapper).get(playReferenceType: .PlayAreaPath, playReferenceID: pathWrapper.id, playReferenceActionType: .AfterFinishedMovingAlongPath)
		
		// Check pathWrapper status
		if (pathWrapper.status == .Finished) {
			
			PlayWrapper.current!.clearPlayAreaPaths()
			
		}
		
		// Create completion handler
		let playExperienceContainerViewStartExperienceCompletionHandler: ((MoveAlongPathResponseTypes, Error?) -> Void) =
		{
			(response, error) -> Void in
			
			// Call the completion handler
			completionHandler(response, nil)

		}
		
		if (pmw == nil) {
			
			// Call the completion handler
			completionHandler(.Continue, nil)
			
		} else if let _delegate = self.delegate as? ProtocolPlayExperienceContainerViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceContainerView(startExperienceFor: pmw!, delegate: self, responseCompletionHandler: playExperienceContainerViewStartExperienceCompletionHandler)
			
		} else {
			
			// Call the completion handler
			completionHandler(.Continue, nil)
			
		}
		
	}
	
}

