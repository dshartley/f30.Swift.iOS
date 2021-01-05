//
//  PlayAreaPathAbilityButtonView.swift
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

/// A view class for a PlayAreaPathAbilityButtonView
public class PlayAreaPathAbilityButtonView: UIView, ProtocolPlayAreaPathAbilityButtonView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:			PlayAreaPathAbilityButtonViewControlManager?
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:				ProtocolPlayAreaPathAbilityButtonViewDelegate?

	@IBOutlet weak var contentView:			UIView!
	@IBOutlet weak var containerView: 		UIView!
	@IBOutlet weak var nameLabel: 			UILabel!
	
	
	// MARK: - Public Computed Properties
	
	public var playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper? {
		get {
			
			return self.controlManager?.playAreaPathAbilityWrapper
			
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

	public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		
		// Nb: If self is returned, then touchesBegan is called
		
		// checkHitTest on sub views
		return self.checkHitTest(point: point, withEvent: event)
		
	}
	
	
	// MARK: - Public Methods
	
	public func checkHitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
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
		
		// Check containerView
		result = self.doCheckHitTest(containerView: point, withEvent: event)
		
		if (result != nil) { return result }
		
		return nil
		
	}
	
	public func viewDidAppear() {
		
	
	}
	
	public func clearView() {

	}

	public func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {

		self.controlManager!.set(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper)
		
		self.nameLabel.text = "\(playAreaPathAbilityWrapper.playAreaPathAbilityType.type)"
	}
	
	
	// MARK: - Public Methods; ProtocolPlayAreaPathAbilityButtonView
	
	public func set(isEngagedYN: Bool) {
		
	}
	

	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayAreaPathAbilityButtonViewControlManager()
		
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
		let viewAccessStrategy: PlayAreaPathAbilityButtonViewViewAccessStrategy = PlayAreaPathAbilityButtonViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playAreaPathAbilityButtonView: self)
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayAreaPathAbilityButtonViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayAreaPathAbilityButtonView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
		self.setupContainerView()
		
	}
	
	fileprivate func setupContainerView() {
		
		UIViewHelper.makeCircle(view: self.containerView)
		
		UIViewHelper.setShadow(view: self.containerView)
		
	}
	
	fileprivate func doCheckHitTest(containerView point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		// Convert to point inside containerView
		let containerViewPoint = self.contentView.convert(point, to: containerView)
		
		// Check point inside containerView
		if (containerView.point(inside: containerViewPoint, with: event)) {
			
			return containerView
			
		}
		
		return nil
		
	}
	
	
	// MARK: - containerView TapGestureRecognizer Methods
	
	@IBAction func containerViewTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playAreaPathAbilityButtonView(tapped: self)
		
	}
	
}

// MARK: - Extension ProtocolPlayAreaPathAbilityButtonViewControlManagerDelegate

extension PlayAreaPathAbilityButtonView: ProtocolPlayAreaPathAbilityButtonViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

