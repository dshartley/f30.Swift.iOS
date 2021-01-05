//
//  PlayChallengeCompleteView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import f30Core
import f30Model
import f30View
import f30Controller

/// A view class for a PlayChallengeCompleteView
public class PlayChallengeCompleteView: UIView, ProtocolPlayChallengeCompleteView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						PlayChallengeCompleteViewControlManager?
	fileprivate var playChallengeWrapper:				PlayChallengeWrapper?
	fileprivate var onCloseCompletionHandler: 			((SequencedViewWrapper, Error?) -> Void)?

	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayChallengeCompleteViewDelegate?
	public fileprivate(set) var sequencedViewWrapper:	SequencedViewWrapper?
	
	@IBOutlet weak var contentView:						UIView!

	
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

	public func set(playChallengeWrapper: PlayChallengeWrapper, sequencedViewWrapper: SequencedViewWrapper, onclose onCloseCompletionhandler: ((SequencedViewWrapper, Error?) -> Void)?) {
		
		self.playChallengeWrapper 		= playChallengeWrapper
		self.sequencedViewWrapper 		= sequencedViewWrapper
		self.onCloseCompletionHandler	= onCloseCompletionhandler
		
	}

	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayChallengeCompleteViewControlManager()
		
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
		let viewAccessStrategy: PlayChallengeCompleteViewViewAccessStrategy = PlayChallengeCompleteViewViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayChallengeCompleteViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayChallengeCompleteView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

	}


	// MARK: - closeButton TapGestureRecogniser Methods
	
	@IBAction func closeButtonTapped(_ sender: Any) {

		// Create completion handler
		let completionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Call the completion handler
			self.onCloseCompletionHandler?(self.sequencedViewWrapper!, error)
			
		}
		
		// Notify the delegate
		self.delegate!.playChallengeCompleteView(sender: self, closeButtonTapped: self.playChallengeWrapper!, oncomplete: completionHandler)
		
	}

}


// MARK: - Extension ProtocolPlayChallengeCompleteViewControlManagerDelegate

extension PlayChallengeCompleteView: ProtocolPlayChallengeCompleteViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}


