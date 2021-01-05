//
//  ApplicationMenuView.swift
//  f30
//
//  Created by David on 29/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core

/// A view class for a ApplicationMenuView
public class ApplicationMenuView: UIView {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var delegate:								ProtocolApplicationMenuViewDelegate?
	public var menuViewTopLayoutConstraintOffset:		CGFloat = 0
	
	@IBOutlet var contentView:							UIView!
	@IBOutlet weak var menuViewTopLayoutConstraint:		NSLayoutConstraint!
	@IBOutlet weak var menuViewHeightLayoutConstraint:	NSLayoutConstraint!
	@IBOutlet weak var backgroundView:					UIView!
	@IBOutlet weak var menuShadowView:					UIView!
	
	
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
			self.delegate?.applicationMenuView(didDismiss: self)
		}
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("ApplicationMenuView", owner: self, options: nil)
		
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
		self.delegate?.applicationMenuView(willDismiss: self)
		
		self.dismissMenu()
	}

	
	// MARK: - settingsButton Methods
	
	@IBAction func settingsButtonTapped(_ sender: Any) {
	
		self.dismissMenu()
		
		// Notify the delegate
		self.delegate?.applicationMenuView(settingsButtonTapped: self)
	
	}
	
	
	// MARK: - signOutButton Methods
	
	@IBAction func signOutButtonTapped(_ sender: Any) {
		
		self.dismissMenu()
		
		// Notify the delegate
		self.delegate?.applicationMenuView(signOutButtonTapped: self)
		
	}
	
}


