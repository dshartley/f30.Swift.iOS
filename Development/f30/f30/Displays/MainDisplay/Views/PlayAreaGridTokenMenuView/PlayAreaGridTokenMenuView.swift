//
//  PlayAreaGridTokenMenuView.swift
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

/// A view class for a PlayAreaGridTokenMenuView
public class PlayAreaGridTokenMenuView: UIView, ProtocolPlayAreaGridTokenMenuView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:				PlayAreaGridTokenMenuViewControlManager?
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:					ProtocolPlayAreaGridTokenMenuViewDelegate?
	
	@IBOutlet weak var contentView:				UIView!
	@IBOutlet weak var containerView: 			UIView!
	@IBOutlet weak var playMovesStackView: 		UIStackView!
	
	
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
	
	
	// MARK: - Public Computed Properties
	
	public var tokenWrapper: PlayAreaTokenWrapper? {
		get {
			
			return self.controlManager!.tokenWrapper
			
		}
	}
	
	
	// MARK: - Override Methods
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		
		let contentViewMarginTop: 		CGFloat = 5
		let contentViewMarginBottom: 	CGFloat = 20
		let containerViewMarginTop: 	CGFloat = 10
		let containerViewMarginBottom: 	CGFloat = 10
		
		let totalMargins: 				CGFloat = contentViewMarginTop + contentViewMarginBottom + containerViewMarginTop + containerViewMarginBottom
		
		let s: 							CGSize = CGSize(width: size.width, height: self.playMovesStackView.frame.size.height + totalMargins)
		
		return s
		
	}
	
	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
		self.contentView.layoutSubviews()
		
		self.setupContainerView()
		
	}
	
	public func clearView() {

		self.controlManager!.clear()
		
		for v in self.playMovesStackView.subviews {
			v.removeFromSuperview()
		}
		
	}

	public func present(playMoves wrappers: [PlayMoveWrapper], for tokenWrapper: PlayAreaTokenWrapper) {
		
		self.controlManager!.set(tokenWrapper: tokenWrapper)
		
		for v in self.playMovesStackView.subviews {
		
			v.removeFromSuperview()
			
		}
		
		// Go through each item
		for pmw in wrappers {

			// Create PlayMoveListItemView
			let item: PlayMoveListItemView = self.createPlayMoveListItemView(for: pmw)

			self.playMovesStackView.addArrangedSubview(item)
			self.playMovesStackView.translatesAutoresizingMaskIntoConstraints = false
			
			self.layoutIfNeeded()
		
		}

	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayAreaGridTokenMenuViewControlManager()
		
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
		let viewAccessStrategy: PlayAreaGridTokenMenuViewViewAccessStrategy = PlayAreaGridTokenMenuViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayAreaGridTokenMenuViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayAreaGridTokenMenuView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
	}
	
	fileprivate func setupContainerView() {
		
		self.containerView.layer.cornerRadius = 5
		
		UIViewHelper.setShadow(view: self.containerView)
		
	}
	
	fileprivate func createPlayMoveListItemView(for playMoveWrapper: PlayMoveWrapper) -> PlayMoveListItemView {
		
		// Create PlayMoveListItemView
		let result: 		PlayMoveListItemView = PlayMoveListItemView()

		// Set playMoveWrapper
		result.set(playMove: playMoveWrapper)
		
		result.delegate 	= self

		let v: 				UIView = result as UIView
		
		// Set layout constraints
		v.widthAnchor.constraint(equalToConstant: self.playMovesStackView.frame.width).isActive = true
		v.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
		
		return result
		
	}
	
}


// MARK: - Extension ProtocolPlayAreaGridTokenMenuViewControlManagerDelegate

extension PlayAreaGridTokenMenuView: ProtocolPlayAreaGridTokenMenuViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}


// MARK: - Extension ProtocolPlayExperienceDelegate

extension PlayAreaGridTokenMenuView: ProtocolPlayExperienceViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceView(closeButtonTapped sender: ProtocolPlayExperienceView) {
		
		if let _delegate = self.delegate as? ProtocolPlayExperienceViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceView(closeButtonTapped: sender)
			
		}
		
	}
	
	public func playExperienceView(playExperienceCompleted wrapper: PlayExperienceWrapper, sender: ProtocolPlayExperienceView) {
		
		if let _delegate = self.delegate as? ProtocolPlayExperienceViewDelegate {
			
			// Notify the delegate
			_delegate.playExperienceView(playExperienceCompleted: wrapper, sender: sender)
			
		}
		
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


// MARK: - Extension ProtocolPlayMoveListItemViewDelegate

extension PlayAreaGridTokenMenuView: ProtocolPlayMoveListItemViewDelegate {

	// MARK: - Public Methods

	public func playMoveListItemView(tapped sender: PlayMoveListItemView) {

		guard (sender.playMoveWrapper != nil) else { return }
		
		// Get PlayMoveWrapper
		let pmw: 				PlayMoveWrapper? = PlayWrapper.current?.playMoves?[sender.playMoveWrapper!.id]
		
		guard (pmw != nil) else { return }

		// Check playChallenge
		if (pmw!.playChallenge != nil) {
			
			// Notify the delegate
			self.delegate!.playAreaGridTokenMenuView(tapped: pmw!, sender: self)
			
		}
		
	}
	
}



