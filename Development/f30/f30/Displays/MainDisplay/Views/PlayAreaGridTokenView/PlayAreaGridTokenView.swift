//
//  PlayAreaGridTokenView.swift
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

/// A view class for a PlayAreaGridTokenView
public class PlayAreaGridTokenView: GridTokenViewBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager: 	PlayAreaGridTokenViewControlManager?

	
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
		Bundle.main.loadNibNamed("PlayAreaGridTokenView", owner: self, options: nil)
		
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
		
		let result: Bool = true
		
		// TODO:
		// How to get to playAreaView????
		
		
//		// Nb: Not compatible if; any neighbour has same tileType
//
//		// Get neighbour tileWrapper
//		let tileWrapper: TokenWrapperBase? = neighbour.cellView!.cellWrapper.tileWrapper
//
//		guard (tileWrapper != nil) else { return true }
//
//		// Check neighbour tileTypeID is not current tileTypeID
//		if (tileWrapper!.tileTypeID == self.tileWrapper.tileTypeID) { result = false }
		
		return result
		
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
		self.controlManager 			= PlayAreaGridTokenViewControlManager()
		
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
		let viewAccessStrategy: PlayAreaGridTokenViewViewAccessStrategy = PlayAreaGridTokenViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayAreaGridTokenViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupView() {

	}

	fileprivate func doSetPlayAreaPathAbilityDisplay(type: PlayAreaGridTokenViewPathAbilityDisplayTypes) {
		
		// TODO:
		
		if (type == .IsEngaged) {
			
			self.tokenImageView.backgroundColor = UIColor.blue
			
		} else if (type == .IsGoing) {
			
			self.tokenImageView.backgroundColor = UIColor.red
			
		} else {
			
			self.tokenImageView.backgroundColor = UIColor.clear
			
		}
		
	}
	
}

// MARK: - Extension ProtocolPlayAreaGridTokenViewControlManagerDelegate

extension PlayAreaGridTokenView: ProtocolPlayAreaGridTokenViewControlManagerDelegate {

	// MARK: - Public Methods

}


// MARK: - Extension ProtocolPlayAreaGridTokenView

extension PlayAreaGridTokenView: ProtocolPlayAreaGridTokenView {

	// MARK: - Public Methods

	public func setPlayAreaPathAbilityDisplay(type: PlayAreaGridTokenViewPathAbilityDisplayTypes) {
		
		self.doSetPlayAreaPathAbilityDisplay(type: type)
		
	}
	
}


