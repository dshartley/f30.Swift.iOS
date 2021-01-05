//
//  PlayResultsView.swift
//  f30
//
//  Created by David on 29/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core
import f30Model

/// A view class for a PlayResultsView
public class PlayResultsView: UIView {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var delegate:								ProtocolPlayResultsViewDelegate?
	public var menuViewTopLayoutConstraintOffset:		CGFloat = 0
	
	@IBOutlet var contentView:							UIView!
	@IBOutlet weak var menuViewTopLayoutConstraint:		NSLayoutConstraint!
	@IBOutlet weak var menuViewHeightLayoutConstraint:	NSLayoutConstraint!
	@IBOutlet weak var backgroundView:					UIView!
	@IBOutlet weak var menuShadowView:					UIView!
	@IBOutlet weak var numberOfFeathersLabel: 			UILabel!
	@IBOutlet weak var numberOfPointsLabel: 			UILabel!
	@IBOutlet weak var numberOfExperiencePointsLabel: 	UILabel!
	
	
	// MARK: - Initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}
	
	
	// MARK: - Public Methods
	
	public func setup() {
		
		self.setupContentView()
		self.setupBackgroundView()
		
	}
	
	public func presentMenu() {
		
		self.isHidden = false
		
		// Make sure the menu is at correct position
		self.setMenuViewHidden()
		
		self.layoutIfNeeded()
		
		UIView.animate(withDuration: 0.3, animations: {
			
			self.backgroundView.alpha					= 0.5
			self.menuShadowView.alpha					= 0.5
			self.menuViewTopLayoutConstraint.constant	= 0 + self.menuViewTopLayoutConstraintOffset
			
			self.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
	}
	
	public func dismissMenu() {
		
		self.layoutIfNeeded()
		
		UIView.animate(withDuration: 0.3, animations: {
			
			self.backgroundView.alpha = 0
			self.menuShadowView.alpha = 0
			
			self.setMenuViewHidden()
			
			self.layoutIfNeeded()
			
		}) { (completedYN) in
			
			self.isHidden = true
			
			// Notify the delegate
			self.delegate?.playResultsView(didDismiss: self)
		}
	}
	
	public func clearView() {
		
		DispatchQueue.main.async {
			
			self.numberOfFeathersLabel.text 			= "0"
			self.numberOfPointsLabel.text 				= "0"
			self.numberOfExperiencePointsLabel.text 	= "0"
			
		}

	}
	
	public func displayPlayGameData(playGameWrapper: PlayGameWrapper) {
		
		let pgdw: 										PlayGameDataWrapper? = playGameWrapper.playGameData
		
		guard (pgdw != nil) else { return }

		let w: 											PlayGameDataOnCompleteDataWrapper? = pgdw!.playGameDataOnCompleteData!
		
		DispatchQueue.main.async {
		
			self.numberOfFeathersLabel.text 			= "\(w!.numberOfFeathers)"
			self.numberOfPointsLabel.text 				= "\(w!.numberOfPoints)"
			self.numberOfExperiencePointsLabel.text 	= "\(w!.numberOfExperiencePoints)"
			
		}
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayResultsView", owner: self, options: nil)
		
		addSubview(contentView)
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
		
	}
	
	fileprivate func setupBackgroundView() {
		
		// Set backgroundView alpha
		self.backgroundView.alpha = 0
		
		// Position menuView out of view
		self.setMenuViewHidden()
		
	}
	
	fileprivate func setMenuViewHidden() {
		
		self.menuViewTopLayoutConstraint.constant	= (0 + self.menuViewTopLayoutConstraintOffset) - self.menuViewHeightLayoutConstraint.constant
		
		self.menuShadowView.alpha = 0
	}
	
	
	// MARK: - backgroundView Methods
	
	@IBAction func backgroundViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playResultsView(willDismiss: self)
		
		self.dismissMenu()
	}

}


