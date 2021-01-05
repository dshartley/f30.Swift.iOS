//
//  PlayControlBarView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFGridScape
import SFCore
import f30Model
import f30View
import f30Controller
import f30Core

/// A view class for a PlayControlBarView
public class PlayControlBarView: UIView, ProtocolPlayControlBarView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:									PlayControlBarViewControlManager?
	fileprivate var isNotConnectedAlertIsShownYN:					Bool = false
	fileprivate var playAreaPathAbilityButtonViews:			[PlayAreaPathAbilityTypes:PlayAreaPathAbilityButtonView] = [PlayAreaPathAbilityTypes:PlayAreaPathAbilityButtonView]()
	fileprivate var widthConstraint: 								NSLayoutConstraint? = nil
	fileprivate var heightConstraint: 								NSLayoutConstraint? = nil
	fileprivate let playAreaPathAbilityButtonViewsLayoutConfig: 	[Int:[Int:Int]] = [0:[0:0],
																					   1:[0:1],
																					   2:[0:2],
																					   3:[0:3],
																					   4:[0:2, 1:2],
																					   5:[0:2, 1:3],
																					   6:[0:3, 1:3],
																					   7:[0:3, 1:4],
																					   8:[0:4, 1:4]]
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:									ProtocolPlayControlBarViewDelegate?
	
	@IBOutlet weak var contentView:								UIView!
	@IBOutlet weak var containerView: 							UIView!
	@IBOutlet weak var containerStackView:						UIStackView!
	
	
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
		self.delegate?.playControlBarView(touchesBegan: self)
		
	}
	
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
		
		// Check containerStackView
		result = self.doCheckHitTest(containerStackView: point, withEvent: event)

		if (result != nil) { return result }
		
		// For each subview
		//		// Check {subview}
		//		result = self.doCheckHitTest({subview}: point, withEvent: event)
		//
		//		if (result != nil) { return result }
		
		return nil
		
	}
	
	public func viewDidAppear() {
		
	}
	
	public func clearView() {

//		for v in self.playAreaPathAbilityButtonsStackView.subviews {
//			v.removeFromSuperview()
//		}
		
		DispatchQueue.main.async {
			
			// containerStackView
			for v in self.containerStackView.subviews {
				v.removeFromSuperview()
			}
			
			// columnStackViews
			//self.columnStackViews 					= [Int:UIStackView]()
			
			// playAreaPathAbilityButtonViews
			self.playAreaPathAbilityButtonViews 	= [PlayAreaPathAbilityTypes:PlayAreaPathAbilityButtonView]()
		
		}
	}
	
	public func cancelTransientViews() {
		
	}
	
	
	// MARK: - Public Methods; ProtocolPlayControlBarView

	public func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, visibleYN: Bool) {
		
		DispatchQueue.main.async {
		
			if (visibleYN) {
				
				self.doPresent(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper)
				
			} else {
				
				self.doHide(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper)
				
			}
			
		}
		
	}
	
	public func set(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {

		// Get playAreaPathAbilityButtonView
		let playAreaPathAbilityButtonView: PlayAreaPathAbilityButtonView? = self.playAreaPathAbilityButtonViews[playAreaPathAbilityWrapper.playAreaPathAbilityType.type]
		
		guard (playAreaPathAbilityButtonView != nil) else { return }
		
		// Set isEngagedYN
		playAreaPathAbilityButtonView!.set(isEngagedYN: playAreaPathAbilityWrapper.isEngagedYN)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayControlBarViewControlManager()
		
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
		let viewAccessStrategy: PlayControlBarViewViewAccessStrategy = PlayControlBarViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playControlBarView: self)

		// Setup the view manager
		self.controlManager!.viewManager = PlayControlBarViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayControlBarView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
		self.clearView()
		
		self.widthConstraint 	= self.widthAnchor.constraint(equalToConstant: 0)
		self.heightConstraint 	= self.heightAnchor.constraint(equalToConstant: 0)
		
		self.setupContainerStackView()
		
	}
	
	fileprivate func setupContainerStackView() {
		
		self.containerStackView.translatesAutoresizingMaskIntoConstraints = false
		
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
	
	fileprivate func doCheckHitTest(containerStackView point: CGPoint, withEvent event: UIEvent?) -> UIView? {

		// Go through each columnStackView
		for columnStackView in self.containerStackView.subviews {

			// Go through each buttonView
			for buttonView in columnStackView.subviews {
				
				// Convert to point inside buttonView
				let buttonViewPoint = self.contentView.convert(point, to: buttonView)
				
				// Check point inside subview
				if (buttonView.point(inside: buttonViewPoint, with: event)) {
					
					return (buttonView as! PlayAreaPathAbilityButtonView).checkHitTest(point: buttonViewPoint, withEvent: event)
					
				}
				
			}

		}

		return nil

	}
	
	fileprivate func doPresent(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {
		
		// Get playAreaPathAbilityType
		let playAreaPathAbilityType: 		PlayAreaPathAbilityTypes = playAreaPathAbilityWrapper.playAreaPathAbilityType.type
		
		guard (self.playAreaPathAbilityButtonViews[playAreaPathAbilityType] == nil) else { return }
		
		// Create playAreaPathAbilityButtonView
		let playAreaPathAbilityButtonView: 	PlayAreaPathAbilityButtonView = self.createPlayAreaPathAbilityButtonView(for: playAreaPathAbilityWrapper)
		
		// Add to collection
		self.playAreaPathAbilityButtonViews[playAreaPathAbilityType] = playAreaPathAbilityButtonView
		
		// Set playAreaPathAbilityButtonView display for isEngagedYN
		playAreaPathAbilityButtonView.set(isEngagedYN: playAreaPathAbilityWrapper.isEngagedYN)
		
		// Layout playAreaPathAbilityButtonViews
		self.doLayoutPlayAreaPathAbilityButtonViews()
		
	}

	fileprivate func doLayoutPlayAreaPathAbilityButtonViews() {
	
		// Clear containerStackView
		for v in self.containerStackView.subviews {
			
			v.removeFromSuperview()
			
		}
		
		// Get numberofButtonViews
		let numberofButtonViews: 	Int = self.playAreaPathAbilityButtonViews.count
	
		// Get layoutConfig
		let layoutConfig: 			[Int:Int]? = self.playAreaPathAbilityButtonViewsLayoutConfig[numberofButtonViews]

		guard (layoutConfig != nil) else { return }
		
		// Get numberofColumns
		let numberofColumns: 		Int = layoutConfig!.count
		
		// Get array of PlayAreaPathAbilityButtonViews
		var bvs: 					[PlayAreaPathAbilityButtonView] = [PlayAreaPathAbilityButtonView]()
		
		for (_, value) in self.playAreaPathAbilityButtonViews {
			
			bvs.append(value)
			
		}
	
		var buttonIndex: 			Int = 0
		
		// Go through each column
		for i in 0...(numberofColumns - 1) {
			
			// Create column stackView
			let sv: 										UIStackView = UIStackView()
			sv.axis 										= .vertical
			sv.spacing 										= 0
			sv.translatesAutoresizingMaskIntoConstraints 	= false
			
			// Get numberofItemsInColumn
			let numberofItemsInColumn: 						Int = layoutConfig![i]!
			
			// Go through each item
			for _ in 1...numberofItemsInColumn {
				
				// Get buttonView
				let bv: PlayAreaPathAbilityButtonView = bvs[buttonIndex]
				
				// Add buttonView to stackView
				sv.addArrangedSubview(bv)
				
				buttonIndex += 1
				
			}
			
			// Add stackView to containerStackView
			self.containerStackView.addArrangedSubview(sv)
			
		}

		self.layoutIfNeeded()
		
		// Set widthConstraint
		self.widthConstraint!.isActive 		= false
		self.widthConstraint 				= self.widthAnchor.constraint(equalToConstant: self.containerStackView.frame.width)
		self.widthConstraint!.isActive 		= true
		
		// Set heightConstraint
		self.heightConstraint!.isActive 	= false
		self.heightConstraint 				= self.heightAnchor.constraint(equalToConstant: self.containerStackView.frame.height)
		self.heightConstraint!.isActive 	= true
		
		self.layoutIfNeeded()
		
	}
	
	fileprivate func doHide(playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {
		
		// TODO:
		
		// Get playAreaPathAbilityButtonView
		let playAreaPathAbilityButtonView: PlayAreaPathAbilityButtonView? = self.playAreaPathAbilityButtonViews[playAreaPathAbilityWrapper.playAreaPathAbilityType.type]
		
		guard (playAreaPathAbilityButtonView != nil) else { return }
		
		// If not visibleYN;
		// Check playAreaPathAbilityButtonView exists
		// Get playAreaPathAbilityButtonView from collection
		// Remove from display
		// Remove from collection
		
	}
	
	
	// MARK: - Private Methods; PlayAreaPathAbilityButtonView
	
	fileprivate func createPlayAreaPathAbilityButtonView(for playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) -> PlayAreaPathAbilityButtonView {
		
		// Create PlayAreaPathAbilityButtonView
		let result: 		PlayAreaPathAbilityButtonView = PlayAreaPathAbilityButtonView()
		
		// Set playAreaPathAbilityWrapper
		result.set(playAreaPathAbilityWrapper: playAreaPathAbilityWrapper)
		
		result.delegate 	= self
		
		let v: 				UIView = result as UIView
		
		// Set layout constraints
		v.widthAnchor.constraint(equalToConstant: 60).isActive = true
		v.heightAnchor.constraint(equalToConstant: 60).isActive = true
		
		return result
		
	}
	
}


// MARK: - Extension ProtocolPlayControlBarViewControlManagerDelegate

extension PlayControlBarView: ProtocolPlayControlBarViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}


// MARK: - Extension ProtocolPlayAreaPathAbilityButtonViewDelegate

extension PlayControlBarView: ProtocolPlayAreaPathAbilityButtonViewDelegate {
	
	// MARK: - Public Methods
	
	public func playAreaPathAbilityButtonView(tapped sender: PlayAreaPathAbilityButtonView) {
		
		guard (sender.playAreaPathAbilityWrapper != nil) else { return }
		
		// Get PlayAreaPathAbilityWrapper
		let papaw: 			PlayAreaPathAbilityWrapper = sender.playAreaPathAbilityWrapper!
		
		// Set isEngagedYN
		papaw.isEngagedYN 	= !papaw.isEngagedYN
		
		// Set PlayAreaPathAbilityButtonView isEngagedYN
		sender.set(isEngagedYN: papaw.isEngagedYN)
		
		// Notify the delegate
		self.delegate?.playControlBarView(touchesBegan: self)

		// Notify the delegate
		self.delegate?.playControlBarView(playAreaPathAbilityTapped: sender.playAreaPathAbilityWrapper!)
		
	}
	
}
