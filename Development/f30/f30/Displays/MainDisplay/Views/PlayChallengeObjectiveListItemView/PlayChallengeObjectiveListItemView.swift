//
//  PlayChallengeObjectiveListItemView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFSerialization
import f30Model
import f30View
import f30Controller

/// A view class for a PlayChallengeObjectiveListItemView
public class PlayChallengeObjectiveListItemView: UIView, ProtocolPlayChallengeObjectiveListItemView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:									PlayChallengeObjectiveListItemViewControlManager?
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:									ProtocolPlayChallengeObjectiveListItemViewDelegate?

	@IBOutlet weak var contentView:									UIView!
	@IBOutlet weak var thumbnailImageView: 							UIImageView!
	@IBOutlet weak var titleLabel: 									UILabel!
	@IBOutlet weak var isCompleteYNIndicatorImageView: 				UIImageView!
	
	
	// MARK: - Public Computed Properties
	
	public var playChallengeObjectiveWrapper: PlayChallengeObjectiveWrapper? {
		get {
			
			return self.controlManager?.playChallengeObjectiveWrapper
			
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
	
	public func clearView() {

	}

	public func set(playChallengeObjectiveWrapper: PlayChallengeObjectiveWrapper) {

		self.controlManager!.set(playChallengeObjectiveWrapper: playChallengeObjectiveWrapper)
		
		self.displayThumbnailImage()
		self.displayTitle()
		
	}
	
	
	// MARK: - Public Methods; ProtocolPlayChallengeObjectiveListItemView
	
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
		self.controlManager 			= PlayChallengeObjectiveListItemViewControlManager()
		
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
		let viewAccessStrategy: PlayChallengeObjectiveListItemViewViewAccessStrategy = PlayChallengeObjectiveListItemViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playChallengeObjectiveListItemView: self)
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayChallengeObjectiveListItemViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayChallengeObjectiveListItemView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
	}
	
	fileprivate func displayThumbnailImage() {
		
		guard (self.playChallengeObjectiveWrapper != nil) else { return }
		
//		let pmw: PlayChallengeObjectiveWrapper = self.playChallengeObjectiveWrapper!
//
//		// Check thumbnailImageData
//		if (self.playChallengeObjectiveWrapper?.thumbnailImageData != nil) {
//
//			// Create image
//			let image: UIImage? = UIImage(data: pmw.thumbnailImageData!)
//
//			self.thumbnailImageView.image 	= image
//
//		} else {
//
			self.thumbnailImageView.image 	= nil
//
//		}
		
	}

	fileprivate func displayTitle() {
	
		guard (self.playChallengeObjectiveWrapper != nil) else { return }
		
		// Get title
		let title: String = self.playChallengeObjectiveWrapper!.playChallengeObjectiveTypeWrapper!.playChallengeObjectiveTypeContentData!.get(key: "\(PlayChallengeObjectiveContentDataKeys.Title)") ?? ""
		
		self.titleLabel.text = title
		
	}
	
	
	// MARK: - thumbnailImageView TapGestureRecognizer Methods
	
	@IBAction func thumbnailImageViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playChallengeObjectiveListItemView(tapped: self)
		
	}
	
	
	// MARK: - titleLabel TapGestureRecognizer Methods
	
	@IBAction func titleLabelTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playChallengeObjectiveListItemView(tapped: self)
		
	}
	
	
	// MARK: - contentView TapGestureRecognizer Methods
	
	@IBAction func contentViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playChallengeObjectiveListItemView(tapped: self)
		
	}
	
}

// MARK: - Extension ProtocolPlayChallengeObjectiveListItemViewControlManagerDelegate

extension PlayChallengeObjectiveListItemView: ProtocolPlayChallengeObjectiveListItemViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

