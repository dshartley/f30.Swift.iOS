//
//  PlayAreaGridCellView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFCore
import SFSerialization
import SFGridScape
import f30Model
import f30View
import f30Controller

/// A view class for a PlayAreaGridCellView
public class PlayAreaGridCellView: GridCellViewBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager: 	PlayAreaGridCellViewControlManager?

	
	// MARK: - Public Stored Properties

	
	// MARK: - Public Computed Properties
	
	
	// MARK: - Initializers
	
	public override init(frame: CGRect, id: UUID) {
		super.init(frame: frame, id: id)
		
	}
	
	public override init(frame: CGRect) {
		super.init(frame: frame)
		
		//self.setupContentView()
		
		self.setup()
		self.setupView()
		
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		//self.setupContentView()
		
		self.setup()
		self.setupView()
		
	}
	
	
	// MARK: - Override Methods

	open override func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayAreaGridCellView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	open override func viewDidAppear() {
		
	}
	
	open override func clearView() {
		
		
	}
	
	open override func isCompatible(with neighbour: GridCellNeighbour, neighbours: [GridCellNeighbour]) -> Bool {
		
		// Check isTouchingYN
		guard (neighbour.isTouchingYN) else { return true }
		
		// Get sideAttributes
		let sideAttributes: 			[String: String] = neighbour.getYourTouchingSideAttributes(for: self)
		
		// Get neighbourSideAttributes
		let neighbourSideAttributes: 	[String: String] = neighbour.getMyTouchingSideAttributes()
		
		// Check 'grass'
		if (sideAttributes["grass"] != nil) {
			
			return (neighbourSideAttributes["grass"] != nil)
			
		}
		
		// Check 'river'
		if (sideAttributes["river"] != nil) {
			
			return (neighbourSideAttributes["river"] != nil)
			
		}
		
		// Check 'road'
		if (sideAttributes["road"] != nil) {
			
			return (neighbourSideAttributes["road"] != nil)
			
		}
		
		// Check 'castle'
		if (sideAttributes["castle"] != nil) {
			
			return (neighbourSideAttributes["castle"] != nil)
			
		}
		
		return false
		
	}
	
	open override func isCompatible(with neighbours: [GridCellNeighbour]) -> Bool {
		
		let result: Bool = true
		
		// Nb: Implementation should override
		
		//if (neighbours.count == 0) { result = false }
		
		return result
		
	}
	
	open override func spawn(frame: CGRect, id: UUID) -> ProtocolGridCellView {
		
		// Override
		
		let result: ProtocolGridCellView = PlayAreaGridCellView(frame: frame, id: id)
		
		return result
		
	}
	
	
	// MARK: - Public Methods

	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayAreaGridCellViewControlManager()
		
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
		let viewAccessStrategy: PlayAreaGridCellViewViewAccessStrategy = PlayAreaGridCellViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayAreaGridCellViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupView() {

	}

}

// MARK: - Extension ProtocolPlayAreaGridCellViewControlManagerDelegate

extension PlayAreaGridCellView: ProtocolPlayAreaGridCellViewControlManagerDelegate {

	// MARK: - Public Methods

}


// MARK: - Extension ProtocolPlayAreaGridCellView

extension PlayAreaGridCellView: ProtocolPlayAreaGridCellView {

	// MARK: - Public Methods

	public func present(playAreaPathPointWrapper: PlayAreaPathPointWrapper) {
		
		self.set(highlight: true)
		
	}
	
	public func hide(playAreaPathPointWrapper: PlayAreaPathPointWrapper) {
		
		self.set(highlight: false)
		
	}
	
}


