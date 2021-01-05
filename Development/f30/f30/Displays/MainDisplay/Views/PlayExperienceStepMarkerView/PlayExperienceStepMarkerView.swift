//
//  PlayExperienceStepMarkerView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import f30Model
import f30View
import f30Controller

/// A view class for a PlayExperienceStepMarkerView
public class PlayExperienceStepMarkerView: UIView, ProtocolPlayExperienceStepMarkerView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						PlayExperienceStepMarkerViewControlManager?

	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayExperienceStepMarkerViewDelegate?
	
	@IBOutlet weak var contentView:						UIView!
	@IBOutlet weak var layoutView: 						UIView!
	@IBOutlet weak var playExperienceStepNameLabel: 	UILabel!
	@IBOutlet weak var thumbnailImageView: 				UIImageView!
	@IBOutlet weak var isCompleteYNIndicatorImageView: 	UIImageView!
	
	
	// MARK: - Public Computed Properties

	public var playExperienceWrapper: PlayExperienceWrapper? {
		get {
			
			return self.controlManager?.playExperienceWrapper
			
		}
	}
	
	public var playExperienceStepWrapper: PlayExperienceStepWrapper? {
		get {
			
			return self.controlManager?.playExperienceStepWrapper
			
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

	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
	}
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper) {
		
		self.controlManager!.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper)
		
	}
	
	
	// MARK: - Public Methods; ProtocolPlayExperienceStepMarkerView
	
	public func set(isActiveYN: Bool) {
		
		self.contentView.alpha = (isActiveYN || self.playExperienceStepWrapper!.isCompleteYN) ? 1 : 0.5
		
	}

	public func set(isCompleteYN: Bool) {
		
		self.isCompleteYNIndicatorImageView.alpha = (isCompleteYN) ? 1 : 0

	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayExperienceStepMarkerViewControlManager()
		
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
		let viewAccessStrategy: PlayExperienceStepMarkerViewViewAccessStrategy = PlayExperienceStepMarkerViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playExperienceStepMarkerView: self,
								 playExperienceStepNameLabel: self.playExperienceStepNameLabel,
								 thumbnailImageView: self.thumbnailImageView)
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayExperienceStepMarkerViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayExperienceStepMarkerView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

	}
	
	
	// MARK: - contentView Methods TapGestureRecognizer Methods
	
	@IBAction func contentViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playExperienceStepMarkerView(tapped: self.controlManager!.playExperienceWrapper!, playExperienceStepWrapper: self.controlManager!.playExperienceStepWrapper!, sender: self)

	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepMarkerViewControlManagerDelegate

extension PlayExperienceStepMarkerView: ProtocolPlayExperienceStepMarkerViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}



