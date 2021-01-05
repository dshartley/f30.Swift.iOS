//
//  PlayActiveChallengeView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFGridScape
import f30Model
import f30View
import f30Controller

/// A view class for a PlayActiveChallengeView
public class PlayActiveChallengeView: UIView, ProtocolPlayActiveChallengeView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:							PlayActiveChallengeViewControlManager?
	fileprivate var isNotConnectedAlertIsShownYN:			Bool = false
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:								ProtocolPlayActiveChallengeViewDelegate?

	@IBOutlet weak var contentView:							UIView!
	@IBOutlet weak var containerView: 						UIView!
	@IBOutlet weak var titleLabel: 							UILabel!
	@IBOutlet weak var playChallengeObjectivesStackView: 	UIStackView!
	
	
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

	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	
		// Notify the delegate
		self.delegate?.playActiveChallengeView(touchesBegan: self)
		
	}
	
	public override func hitTest(_ point: CGPoint, with event: UIEvent?) -> UIView? {
		
		// Nb: If self is returned, then touchesBegan is called
		
		// checkHitTest on sub views
		return self.checkHitTest(point: point, withEvent: event)
		
	}
	
	
	// MARK: - Public Methods
	
	public func checkHitTest(point: CGPoint, withEvent event: UIEvent?) -> UIView? {
		
		// Check gestures enabled
		if (!self.isUserInteractionEnabled || self.isHidden || self.alpha == 0) {
			
			return nil
			
		}
		
		// Check gestures enabled
		if (!self.contentView.isUserInteractionEnabled || self.contentView.isHidden || self.contentView.alpha == 0) {
			
			return nil
			
		}
		
		// Check point inside
		if (!self.contentView.point(inside: point, with: event)) {
			
			return nil
			
		}
		
		// Nb: Check whether to handle the event in subviews
		
		return nil
		
	}
	
	public func viewDidAppear() {
		
		self.setupContainerView()
	
	}
	
	public func clearView() {

		DispatchQueue.main.async {
			
			self.titleLabel.text = ""
			
			// Clear playChallengeObjectivesStackView
			UIStackViewHelper.clearAllItems(from: self.playChallengeObjectivesStackView)

		}
		
	}

	
	// MARK: - Public Methods; ProtocolPlayActiveChallengeView

	public func set(playChallengeWrapper: PlayChallengeWrapper) {
		
		self.controlManager!.set(playChallengeWrapper: playChallengeWrapper)
		
		self.controlManager!.displayPlayChallenge()
		
		// Present PlayChallengeObjectives
		self.controlManager!.displayPlayChallengeObjectives()
		
	}
	
	public func clearPlayActiveChallenge() {
		
		self.clearView()
		self.controlManager!.clear()
		
	}
	
	public func present(playChallengeObjectiveListItemView view: ProtocolPlayChallengeObjectiveListItemView) {

		DispatchQueue.main.async {
			
			self.playChallengeObjectivesStackView.addArrangedSubview(view as! UIView)
			
			self.playChallengeObjectivesStackView.translatesAutoresizingMaskIntoConstraints = false
			self.layoutSubviews()
			
		}
		
	}
	
	public func doAfterPlayChallengeObjectiveCompleted(playChallengeObjectiveWrapper: PlayChallengeObjectiveWrapper) {
		
		self.controlManager!.doAfterPlayChallengeObjectiveCompleted(playChallengeObjectiveWrapper: playChallengeObjectiveWrapper)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayActiveChallengeViewControlManager()
		
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
		let viewAccessStrategy: PlayActiveChallengeViewViewAccessStrategy = PlayActiveChallengeViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playActiveChallengeView: self, titleLabel: self.titleLabel)

		// Setup the view manager
		self.controlManager!.viewManager = PlayActiveChallengeViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayActiveChallengeView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

		self.setupPlayChallengeObjectivesStackView()
		
	}
	
	fileprivate func setupContainerView() {
		
		self.containerView.layer.cornerRadius = 5
		
		UIViewHelper.setShadow(view: self.containerView)
		
	}
	
	fileprivate func setupPlayChallengeObjectivesStackView() {
		
		// Clear playChallengeObjectivesStackView
		UIStackViewHelper.clearAllItems(from: self.playChallengeObjectivesStackView)
	
	}
	
	fileprivate func presentIsNotConnectedAlert() {
		
		guard (!self.isNotConnectedAlertIsShownYN) else { return }
		
		self.isNotConnectedAlertIsShownYN = true
		
		// Create completion handler
		let completionHandler: ((UIAlertAction?) -> Void) =
		{
			[unowned self] (action) -> Void in
			
			self.isNotConnectedAlertIsShownYN = false
			
		}
		
		let alertTitle: 	String = NSLocalizedString("AlertTitleNotConnected", comment: "")
		let alertMessage: 	String = NSLocalizedString("AlertMessageNotConnected", comment: "")
		
		UIAlertControllerHelper.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: completionHandler)
		
	}

	fileprivate func presentOperationFailedAlert() {
		
		let alertTitle: 	String = NSLocalizedString("AlertTitleOperationFailed", comment: "")
		let alertMessage: 	String = NSLocalizedString("AlertMessageOperationFailed", comment: "")
		
		UIAlertControllerHelper.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: nil)
		
	}
	
}


// MARK: - Extension ProtocolPlayActiveChallengeViewControlManagerDelegate

extension PlayActiveChallengeView: ProtocolPlayActiveChallengeViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
	public 	func playActiveChallengeViewControlManager(createPlayChallengeObjectiveListItemViewFor wrapper: PlayChallengeObjectiveWrapper) -> ProtocolPlayChallengeObjectiveListItemView {
		
		// Create PlayChallengeObjectiveListItemView
		let result: 		PlayChallengeObjectiveListItemView = PlayChallengeObjectiveListItemView()
		
		// Set playChallengeObjectiveWrapper
		result.set(playChallengeObjectiveWrapper: wrapper)
		
		result.delegate 	= self
		
		let v: 				UIView = result as UIView
		
		// Set layout constraints
		v.widthAnchor.constraint(equalToConstant: self.playChallengeObjectivesStackView.frame.width).isActive = true
		v.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
		
		return result
		
	}
	
}

// MARK: - Extension ProtocolPlayChallengeObjectiveListItemViewDelegate

extension PlayActiveChallengeView: ProtocolPlayChallengeObjectiveListItemViewDelegate {
	
	// MARK: - Public Methods
	
	public func playChallengeObjectiveListItemView(tapped sender: PlayChallengeObjectiveListItemView) {
		
//		guard (sender.playMoveWrapper != nil) else { return }
//
//		// Get PlayMoveWrapper
//		let pmw: 				PlayMoveWrapper? = PlayWrapper.current?.playMoves?[sender.playMoveWrapper!.id]
//
//		guard (pmw != nil) else { return }
//
//		if let _delegate = self.delegate as? ProtocolPlayExperienceContainerViewDelegate {
//
//			// Notify the delegate
//			_delegate.playExperienceContainerView(startExperienceFor: pmw!, delegate: self)
//
//		}
		
	}
	
}
