//
//  BasicPlayExperienceStepView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFCore
import SFView
import SFSerialization
import f30Model
import f30View
import f30Controller

/// A view class for a BasicPlayExperienceStepView
public class BasicPlayExperienceStepView: UIView, ProtocolBasicPlayExperienceStepView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:					BasicPlayExperienceStepViewControlManager?
	fileprivate var isNotConnectedAlertIsShownYN:	Bool = false

	
	// MARK: - Public Stored Properties
	
	public weak var delegate:						ProtocolPlayExperienceStepViewDelegate?
	
	@IBOutlet weak var contentView:					UIView!
	@IBOutlet weak var layoutView: 					UIView!
	@IBOutlet weak var exercisesView: 				UIView!
	@IBOutlet weak var experienceStepProgressView: 	UIView!
	@IBOutlet weak var exerciseCorrectView: 		UIView!
	@IBOutlet weak var exerciseIncorrectView: 		UIView!
	@IBOutlet weak var exerciseCheckView: 			UIView!
	@IBOutlet weak var checkExerciseButton: 		UIButton!
	@IBOutlet weak var progresLabel: UILabel!
	
	
	// MARK: - Public Computed Properties
	
	fileprivate var _properties: 					PlayExperienceStepViewProperties = PlayExperienceStepViewProperties()
	
	public var properties: PlayExperienceStepViewProperties {
		get {
			return _properties
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
		self.controlManager 			= BasicPlayExperienceStepViewControlManager()
		
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
		let viewAccessStrategy: BasicPlayExperienceStepViewViewAccessStrategy = BasicPlayExperienceStepViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playExperienceStepView: self)

		// Setup the view manager
		self.controlManager!.viewManager = BasicPlayExperienceStepViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("BasicPlayExperienceStepView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

		self.isExclusiveTouch = true
		
		self.doSetExerciseCorrectView()
		self.doSetExerciseIncorrectView()
		self.doSetExerciseCheckView()
		self.doSetButtons()

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

	fileprivate func doSetPlayExperienceStepExerciseViewAnimation(v: UIView) {
		
		let offset: CGFloat = 0
		
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
			
			// TODO:
			
			v.centerXAnchor.constraint(equalTo: self.exercisesView.centerXAnchor, constant: offset).isActive = true
			
			self.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetExerciseCorrectView() {
		
		let p: PlayExperienceStepViewProperties = self.properties
		
		self.exerciseCorrectView.alpha = (p.hasCheckedYN && p.isCorrectYN) ? 1 : 0
		
	}

	fileprivate func doSetExerciseIncorrectView() {
		
		let p: PlayExperienceStepViewProperties = self.properties
		
		self.exerciseIncorrectView.alpha = (p.hasCheckedYN && !p.isCorrectYN) ? 1 : 0
		
	}
	
	fileprivate func doSetExerciseCheckView() {
		
		let p: PlayExperienceStepViewProperties = self.properties
		
		self.exerciseCheckView.alpha = (!p.hasCheckedYN) ? 1 : 0
		
	}
	
	fileprivate func doSetExerciseViews() {
		
		self.doSetExerciseCheckView()
		self.doSetExerciseCorrectView()
		self.doSetExerciseIncorrectView()
		
	}
	
	fileprivate func doSetButtons() {
		
		let p: PlayExperienceStepViewProperties = self.properties
		
		self.checkExerciseButton.isEnabled 	= p.canCheckYN
		
	}
	
	fileprivate func doSetProgressView() {
		
		// Get PlayExperienceStepViewProperties
		let p: 				PlayExperienceStepViewProperties = self.properties
		
		// Set progressTarget
		p.progressTarget 	= self.controlManager!.playExperienceStepWrapper!.playExperienceStepExercises().count
		
		// Set progress
		p.progress 			= 0
		
		self.doDisplayProgress()
	}
	
	fileprivate func doDisplayProgress() {
		
		// Get PlayExperienceStepViewProperties
		let p: 		PlayExperienceStepViewProperties = self.properties
		
		var i: 		Int = 0
		
		// Go through each item
		for wrapper in self.controlManager!.playExperienceStepWrapper!.playExperienceStepExercises().values {
		
			// Check isCompleteYN
			if (wrapper.isCompleteYN) { i += 1 }
			
		}
		
		// Set progress
		p.progress 	= i
		
		self.progresLabel.text = "Progress \(p.progress) of \(p.progressTarget)"
		
	}
	
	
	// MARK: - backButton TapGestureRecogniser Methods
	
	@IBAction func backButtonTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playExperienceStepView(closeButtonTapped: self)
		
	}
	
	
	// MARK: - checkExercise Methods
	
	@IBAction func checkExerciseButtonTapped(_ sender: Any) {

		// Get PlayExperienceStepViewProperties
		let p: 			PlayExperienceStepViewProperties = self.properties
		
		// Get currentPlayExperienceStepExerciseView
		let v: 			ProtocolPlayExperienceStepExerciseView? = p.currentPlayExperienceStepExerciseView
		
		guard (v != nil) else { return }
		
		// Get isCorrectYN
		p.isCorrectYN 	= v!.properties.isCorrectYN
		
		// Set hasCheckedYN
		p.hasCheckedYN 	= true
		
		// Set views
		self.doSetExerciseViews()
		
		// Check isCorrectYN
		if (!p.isCorrectYN) { return }
		
		// Display progress
		self.doDisplayProgress()
		
		self.controlManager!.doAfterPlayExperienceStepExerciseCompleted(wrapper: v!.playExperienceStepExerciseWrapper!)
		
	}
	
	
	// MARK: - continueButton Methods
	
	@IBAction func continueButtonTapped(_ sender: Any) {
		
		// Check isCompleteYN
		if (!self.controlManager!.playExperienceStepWrapper!.isCompleteYN) {
			
			// Get PlayExperienceStepViewProperties
			let p: 			PlayExperienceStepViewProperties = self.properties
			
			// Set properties
			p.isCorrectYN 	= false
			p.hasCheckedYN 	= false
			p.canCheckYN 	= false
			
			self.doSetButtons()
			self.doSetExerciseViews()
			
			// Display next PlayExperienceStepExercise
			self.controlManager!.displayNextPlayExperienceStepExercise()
			
		}
		
		// TODO: Should this be a different view for the last exercise????
		// Check playExperienceStepWrapper isCompleteYN
		if (self.controlManager!.playExperienceStepWrapper!.isCompleteYN) {
			
			self.controlManager!.doAfterPlayExperienceStepCompleted()
			
		}
		
	}
	
	
	// MARK: - tryAgainButton Methods
	
	@IBAction func tryAgainButtonTapped(_ sender: Any) {
		
		// Get PlayExperienceStepViewProperties
		let p: 			PlayExperienceStepViewProperties = self.properties
		
		// Get currentPlayExperienceStepExerciseView
		let v: 			ProtocolPlayExperienceStepExerciseView? = p.currentPlayExperienceStepExerciseView
		
		guard (v != nil) else { return }
		
		// Set properties
		p.isCorrectYN 	= false
		p.hasCheckedYN 	= false
		p.canCheckYN 	= false
		
		// Reset view
		v!.reset()
		
		// Set views
		self.doSetExerciseViews()
		self.doSetButtons()
	}
	
}

// MARK: - Extension ProtocolBasicPlayExperienceStepViewControlManagerDelegate

extension BasicPlayExperienceStepView: ProtocolBasicPlayExperienceStepViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolPlayExperienceStepViewControlManagerDelegate

extension BasicPlayExperienceStepView: ProtocolPlayExperienceStepViewControlManagerDelegate {

	// MARK: - Public Methods
	
	public func playExperienceStepViewControlManager(playExperienceStepCompleted wrapper: PlayExperienceStepWrapper) {
		
		// Notify the delegate
		self.delegate?.playExperienceStepView(playExperienceStepCompleted: self.controlManager!.playExperienceStepWrapper!, sender: self)
		
	}
	
	public func playExperienceStepViewControlManager(createPlayExperienceStepExerciseViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper) -> ProtocolPlayExperienceStepExerciseView {
		
		var result: ProtocolPlayExperienceStepExerciseView? = nil
		
		// Create PlayExperienceStepExerciseView
		result = PlayViewFactory.createPlayExperienceStepExerciseView(playExperienceWrapper: playExperienceWrapper, playExperienceStepExerciseWrapper: playExperienceStepExerciseWrapper, delegate: self)

		return result!
		
	}

}

// MARK: - Extension ProtocolPlayExperienceStepView

extension BasicPlayExperienceStepView: ProtocolPlayExperienceStepView {
	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
		self.doSetButtons()
		
	}
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper) {
	
		self.controlManager!.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper)

		// Set progressView
		self.doSetProgressView()
		
		// Display first PlayExperienceStepExercise
		self.controlManager!.displayNextPlayExperienceStepExercise()
		
	}
	
	public func present(playExperienceStepExerciseView view: ProtocolPlayExperienceStepExerciseView) {
		
		// Get current playExperienceStepExerciseView
		// Animate next playExperienceStepExerciseView in
		// Animate current playExperienceStepExerciseView out
		// Set current playExperienceStepExerciseView
		
		// TODO:
		// Animation etc
		
		// Set currentPlayExperienceStepExerciseView
		self.properties.currentPlayExperienceStepExerciseView = view
		
		DispatchQueue.main.async {
			
			let v = view as! UIView
			
			self.exercisesView.addSubview(v)

			let offset: CGFloat = 50
			v.centerXAnchor.constraint(equalTo: self.exercisesView.centerXAnchor, constant: offset).isActive = true
			v.centerYAnchor.constraint(equalTo: self.exercisesView.centerYAnchor).isActive = true
			
			self.layoutIfNeeded()
			self.layoutSubviews()
			
			self.doSetPlayExperienceStepExerciseViewAnimation(v: v)
		}
		
	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseViewDelegate

extension BasicPlayExperienceStepView: ProtocolPlayExperienceStepExerciseViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceStepExerciseView(canCheck wrapper: PlayExperienceStepExerciseWrapper, sender: ProtocolPlayExperienceStepExerciseView, canCheckYN: Bool) {
	
		// Set canCheckYN
		self.properties.canCheckYN 			= canCheckYN
		
		self.checkExerciseButton.isEnabled 	= canCheckYN
		
	}
	
}
