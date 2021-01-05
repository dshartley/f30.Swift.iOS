//
//  PlayAreaGridTileView.swift
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

/// A view class for a PlayAreaGridTileView
public class PlayAreaGridTileView: GridTileViewBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager: 	PlayAreaGridTileViewControlManager?

	
	// MARK: - Public Stored Properties

	
	// MARK: - Public Computed Properties
	
	
	// MARK: - Initializers
	
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
		Bundle.main.loadNibNamed("PlayAreaGridTileView", owner: self, options: nil)
		
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
		
		return true
		
//		var result: Bool = true
		
//		// Nb: Not compatible if; any neighbour has same tileType
//
//		// Get neighbour tileWrapper
//		let tileWrapper: TileWrapperBase? = neighbour.cellView!.cellWrapper.tileWrapper
//
//		guard (tileWrapper != nil) else { return true }
//
//		// Check neighbour tileTypeID is not current tileTypeID
//		if (tileWrapper!.tileTypeID == self.tileWrapper.tileTypeID) { result = false }
//
//		return result
		
	}
	
	open override func isCompatible(with neighbours: [GridCellNeighbour]) -> Bool {
		
		let result: Bool = true
		
		// Nb: Implementation should override
		
		//if (neighbours.count == 0) { result = false }
		
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
		self.controlManager 			= PlayAreaGridTileViewControlManager()
		
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
		let viewAccessStrategy: PlayAreaGridTileViewViewAccessStrategy = PlayAreaGridTileViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayAreaGridTileViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupView() {

	}

}

// MARK: - Extension ProtocolPlayAreaGridTileViewControlManagerDelegate

extension PlayAreaGridTileView: ProtocolPlayAreaGridTileViewControlManagerDelegate {

	// MARK: - Public Methods

}


// MARK: - Extension ProtocolPlayAreaGridTileView

extension PlayAreaGridTileView: ProtocolPlayAreaGridTileView {

	// MARK: - Public Methods

}


