//
//  PlayAreaPathMenuView.swift
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

/// A view class for a PlayAreaPathMenuView
public class PlayAreaPathMenuView: UIView, ProtocolPlayAreaPathMenuView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:				PlayAreaPathMenuViewControlManager?
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:					ProtocolPlayAreaPathMenuViewDelegate?
	
	@IBOutlet weak var contentView:				UIView!
	@IBOutlet weak var containerView: 			UIView!
	
	
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
	
	public var playAreaPathWrapper: PlayAreaPathWrapper? {
		get {
			
			return self.controlManager?.playAreaPathWrapper
			
		}
	}
	
	
	// MARK: - Override Methods
	
	public override func sizeThatFits(_ size: CGSize) -> CGSize {
		
//		let contentViewMarginTop: 		CGFloat = 5
//		let contentViewMarginBottom: 	CGFloat = 20
//		let containerViewMarginTop: 	CGFloat = 10
//		let containerViewMarginBottom: 	CGFloat = 10
//
//		let totalMargins: 				CGFloat = contentViewMarginTop + contentViewMarginBottom + containerViewMarginTop + containerViewMarginBottom
//
		//let s: 							CGSize = CGSize(width: size.width, height: self.playMovesStackView.frame.size.height + totalMargins)

		let s: 							CGSize = CGSize(width: size.width, height: 50)
		
		return s
		
	}
	
	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
		self.contentView.layoutSubviews()
		
		self.setupContainerView()
		
	}
	
	public func clearView() {

		self.controlManager!.clear()
		
	}

	public func present(for tokenWrapper: PlayAreaTokenWrapper, playAreaPathWrapper: PlayAreaPathWrapper) {
		
		self.controlManager!.set(playAreaPathWrapper: playAreaPathWrapper)
		
//		for v in self.playMovesStackView.subviews {
//			v.removeFromSuperview()
//		}
//
//		// Go through each item
//		for pmw in wrappers {
//
//			// Create PlayMoveListItemView
//			let item: PlayMoveListItemView = self.createPlayMoveListItemView(for: pmw)
//
//			self.playMovesStackView.addArrangedSubview(item)
//			self.playMovesStackView.translatesAutoresizingMaskIntoConstraints = false
//
//			self.layoutIfNeeded()
//
//		}
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayAreaPathMenuViewControlManager()
		
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
		let viewAccessStrategy: PlayAreaPathMenuViewViewAccessStrategy = PlayAreaPathMenuViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayAreaPathMenuViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayAreaPathMenuView", owner: self, options: nil)
		
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
	
	
	// MARK: - goButton Methods
	
	@IBAction func goButtonTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playAreaPathMenuView(goButtonTapped: self)
		
	}
	
}


// MARK: - Extension ProtocolPlayAreaPathMenuViewControlManagerDelegate

extension PlayAreaPathMenuView: ProtocolPlayAreaPathMenuViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}




