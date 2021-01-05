//
//  BasicPlayExperienceView.swift
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

/// A view class for a BasicPlayExperienceView
public class BasicPlayExperienceView: UIView, ProtocolBasicPlayExperienceView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						BasicPlayExperienceViewControlManager?
	fileprivate var isNotConnectedAlertIsShownYN:		Bool = false

	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayExperienceViewDelegate?
	
	@IBOutlet weak var contentView:						UIView!
	@IBOutlet weak var layoutView: 						UIView!
	@IBOutlet weak var titleLabel: 						UILabel!
	@IBOutlet weak var stepsStackView: 					UIStackView!

	
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
	
		
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= BasicPlayExperienceViewControlManager()
		
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
		let viewAccessStrategy: BasicPlayExperienceViewViewAccessStrategy = BasicPlayExperienceViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playExperienceView: self,
								 titleLabel: self.titleLabel)
		
		// Setup the view manager
		self.controlManager!.viewManager = BasicPlayExperienceViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("BasicPlayExperienceView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

		self.isExclusiveTouch = true

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

	
	// MARK: - backButton TapGestureRecogniser Methods
	
	@IBAction func backButtonTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playExperienceView(closeButtonTapped: self)
		
	}
	
}

// MARK: - Extension ProtocolBasicPlayExperienceViewControlManagerDelegate

extension BasicPlayExperienceView: ProtocolBasicPlayExperienceViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolPlayExperienceViewControlManagerDelegate

extension BasicPlayExperienceView: ProtocolPlayExperienceViewControlManagerDelegate {

	// MARK: - Public Methods
	
	public func playExperienceViewControlManager(playExperienceCompleted wrapper: PlayExperienceWrapper, sender: PlayExperienceViewControlManagerBase) {

		// Notify the delegate
		self.delegate?.playExperienceView(playExperienceCompleted: wrapper, sender: self)
		
	}
	
	public func playExperienceViewControlManager(createPlayExperienceStepMarkerViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper) -> ProtocolPlayExperienceStepMarkerView {
		
		var result: ProtocolPlayExperienceStepMarkerView? = nil
		
		// Create PlayExperienceStepMarkerView
		result = PlayViewFactory.createPlayExperienceStepMarkerView(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper, delegate: self)
		
		return result!
		
	}
	
}

// MARK: - Extension ProtocolPlayExperienceView

extension BasicPlayExperienceView: ProtocolPlayExperienceView {
	
	// MARK: - Public Computed Properties
	
	public var playExperienceWrapper: PlayExperienceWrapper? {
		
		return self.controlManager!.playExperienceWrapper
		
	}
	

	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper) {
	
		self.controlManager!.set(playExperienceWrapper: playExperienceWrapper)

		self.controlManager!.displayPlayExperience()
		
		// Present PlayExperienceSteps
		self.controlManager!.displayPlayExperienceSteps()
		
	}
	
	public func present(playExperienceStepMarkerView view: ProtocolPlayExperienceStepMarkerView) {
		
		DispatchQueue.main.async {
			
			self.stepsStackView.addArrangedSubview(view as! UIView)
			
			self.stepsStackView.translatesAutoresizingMaskIntoConstraints = false
			self.layoutSubviews()
			
		}
		
	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepViewDelegate

extension BasicPlayExperienceView: ProtocolPlayExperienceStepViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceStepView(closeButtonTapped sender: ProtocolPlayExperienceStepView) {
		
		// Notify the delegate
		self.delegate?.playExperienceView(playExperienceStepViewCloseButtonTapped: sender)
		
	}
	
	public func playExperienceStepView(playExperienceStepCompleted wrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceStepView) {
		
		// Create completion handler
		let completionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in

			// Not required
			
		}
		
		// Create completion handler
		let uiCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			print("uiCompletionHandler")
			
		}
		
		self.controlManager!.doAfterPlayExperienceStepCompleted(playExperienceStepWrapper: wrapper)
		
		// Notify the delegate
		self.delegate!.playExperienceView(playExperienceStepCompleted: wrapper, sender: self, oncomplete: completionHandler, onuicomplete: uiCompletionHandler)
		
	}

}

// MARK: - Extension ProtocolPlayExperienceStepMarkerViewDelegate

extension BasicPlayExperienceView: ProtocolPlayExperienceStepMarkerViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceStepMarkerView(tapped playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceStepMarkerView) {
		
		guard (!playExperienceStepWrapper.isCompleteYN && playExperienceStepWrapper.isActiveYN) else { return }
		
		// Notify the delegate
		self.delegate?.playExperienceView(presentPlayExperienceStepViewFor: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper, sender: self, delegate: self)
		
	}
	
}

