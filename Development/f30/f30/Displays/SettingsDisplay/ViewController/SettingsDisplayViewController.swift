//
//  SettingsDisplayViewController.swift
//  f30
//
//  Created by David on 14/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity
import f30Model
import f30View
import f30Controller

/// A ViewController for the SettingsDisplay
public class SettingsDisplayViewController: UIViewController {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						SettingsDisplayControlManager?
	fileprivate var handleTouchesBeganOutsideYN:		Bool = false
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolSettingsDisplayViewControllerDelegate?

	@IBOutlet weak var settingsView: 					SettingsView!
	@IBOutlet weak var settingsPlaceholderView: 		UIView!
	@IBOutlet weak var fadeOutView: 					UIView!
	
	
	// MARK: - Override Methods
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.setup()
		
		self.setupFadeOutView()
		self.setupSettingsView()
	}
	
	public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		// TODO:
		
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		
		self.settingsView!.viewDidAppear()
	}
	
	public override func viewDidDisappear(_ animated: Bool) {
		
		self.dispose()
	}
	
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		_ = self.settingsView.resignFirstResponder()
		
		guard (touches.first != nil) else { return }
		guard (handleTouchesBeganOutsideYN) else { return }
		
		// Get the point
		let point: CGPoint = touches.first!.location(in: self.view)

		// Check point is outside settingsView
		if (!self.settingsView.frame.contains(point)) {
			
			let subviewPoint: CGPoint = self.settingsView.convert(point, from: self.view)
			
			self.settingsView.handleTouchesBeganOutside(subviewPoint, with: event)
			
		}

	}

	
	// MARK: - Public Methods
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
		
	}
	
	fileprivate func dispose() {
		
		self.settingsView.dispose()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= SettingsDisplayControlManager()
		
		self.controlManager!.delegate 	= self
		
		// Setup cacheing
		//self.controlManager!.setupCacheing(managedObjectContext: CoreDataHelper.getManagedObjectContext())
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: SettingsDisplayViewAccessStrategy = SettingsDisplayViewAccessStrategy()
		
		viewAccessStrategy.setup()
		
		// Setup the view manager
		self.controlManager!.viewManager = SettingsDisplayViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupSettingsView() {
		
		self.settingsView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.settingsPlaceholderView.isHidden	= true
		
	}
	
	fileprivate func dismissDisplay() {
		
		if (self.delegate != nil) {
			
			// Notify the delegate
			self.delegate!.settingsDisplayViewController(dismiss: self)
			
		} else {
			
			self.controlManager!.delegate 	= nil
			self.controlManager 			= nil
			self.settingsView.delegate 		= nil
			
			self.dismiss(animated: true, completion: nil)
			
		}
		
	}
	
	fileprivate func setupFadeOutView() {
		
		self.fadeOutView.alpha = 0
	}
	
	fileprivate func presentFadeOutView() {
		
		// Show view
		UIView.animate(withDuration: 0.1) {
			
			self.fadeOutView.alpha = 1
		}
		
	}
	
	fileprivate func hideFadeOutView() {
		
		guard (self.fadeOutView.alpha != 0) else { return }
		
		// Hide view
		UIView.animate(withDuration: 0.1) {
			
			self.fadeOutView.alpha = 0
		}
		
	}
	
	fileprivate func endTyping() {
		
		_ = self.settingsView.resignFirstResponder()
		
	}
	
	
	// MARK: - doneButton Methods
	
	@IBAction func doneButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Dismiss display
		self.dismissDisplay()
		
	}
	
}

// MARK: - Extension ProtocolSettingsViewDelegate

extension SettingsDisplayViewController: ProtocolSettingsViewDelegate {
	
	// MARK: - Public Methods

	public func settingsView(isNotConnected error: Error?) {
		
	}
	
	public func settingsView(isPresentingModalDialog sender: SettingsView) {
	
		self.handleTouchesBeganOutsideYN = true
		
		self.presentFadeOutView()
		
	}
	
	public func settingsView(isHidingModalDialog sender: SettingsView) {
		
		self.handleTouchesBeganOutsideYN = false
		
		self.hideFadeOutView()
		
	}
	
	public func settingsView(avatarImageChanged sender: SettingsView) {
		
		// Notify the delegate
		self.delegate?.settingsDisplayViewController(avatarImageChanged: self)
		
	}
	
}

// MARK: - Extension ProtocolSettingsDisplayControlManagerDelegate

extension SettingsDisplayViewController: ProtocolSettingsDisplayControlManagerDelegate {
	
	// MARK: - Public Methods

	public func settingsDisplayControlManager(isNotConnected error: Error?) {
		
	}
	
}
