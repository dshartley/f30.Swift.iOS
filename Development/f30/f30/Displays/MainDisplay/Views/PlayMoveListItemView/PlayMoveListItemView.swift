//
//  PlayMoveListItemView.swift
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

/// A view class for a PlayMoveListItemView
public class PlayMoveListItemView: UIView {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:						ProtocolPlayMoveListItemViewDelegate?
	public fileprivate(set) var playMoveWrapper: 	PlayMoveWrapper?
	
	@IBOutlet weak var contentView:					UIView!
	@IBOutlet weak var thumbnailImageView: 			UIImageView!
	@IBOutlet weak var titleLabel: 					UILabel!
	
	
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

	public func set(playMove: PlayMoveWrapper) {

		self.playMoveWrapper = playMove
		
		self.displayThumbnailImage()
		self.displayTitle()
		
	}
	

	// MARK: - Private Methods
	
	fileprivate func setup() {

	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayMoveListItemView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
	}
	
	fileprivate func displayThumbnailImage() {
		
		guard (self.playMoveWrapper != nil) else { return }
		
		let pmw: PlayMoveWrapper = self.playMoveWrapper!
		
		// Check thumbnailImageData
		if (self.playMoveWrapper?.thumbnailImageData != nil) {
			
			// Create image
			let image: UIImage? = UIImage(data: pmw.thumbnailImageData!)
			
			self.thumbnailImageView.image 	= image
			
		} else {
			
			self.thumbnailImageView.image 	= nil
			
		}
		
	}

	fileprivate func displayTitle() {
	
		guard (self.playMoveWrapper != nil) else { return }
	
		// Get title
		let title: 				String = self.playMoveWrapper!.playMoveContentData!.get(key: "\(PlayMoveContentDataKeys.Title)") ?? ""
		
		self.titleLabel.text 	= title
		
	}
	
	
	// MARK: - thumbnailImageView TapGestureRecognizer Methods
	
	@IBAction func thumbnailImageViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playMoveListItemView(tapped: self)
		
	}
	
	
	// MARK: - titleLabel TapGestureRecognizer Methods
	
	@IBAction func titleLabelTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playMoveListItemView(tapped: self)
		
	}
	
	
	// MARK: - contentView TapGestureRecognizer Methods
	
	@IBAction func contentViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playMoveListItemView(tapped: self)
		
	}
	
}

