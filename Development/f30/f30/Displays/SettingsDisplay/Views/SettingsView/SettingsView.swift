//
//  SettingsView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFSecurity
import f30Model
import f30View
import f30Controller
import CoreGraphics

/// Specifies settings views
enum SettingsViews : Int {
	case primary = 1
	case changepassword = 2
}

/// A view class for a SettingsView
public class SettingsView: UIView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						SettingsViewControlManager?
	fileprivate var uikeyboardHelper: 					UIKeyboardHelper = UIKeyboardHelper()
	fileprivate var currentView: 						SettingsViews = .primary
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolSettingsViewDelegate?
	
	@IBOutlet weak var contentView:						UIView!
	@IBOutlet weak var primarySettingsView: 			PrimarySettingsView!
	@IBOutlet weak var primarySettingsPlaceholderView: 	UIView!
	@IBOutlet weak var changePasswordView: 				ChangePasswordView!
	@IBOutlet weak var changePasswordPlaceholderView: 	UIView!
	@IBOutlet weak var fadeOutView: 					UIView!
	
	
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
		
		self.endTyping()
	}
	
	public override func resignFirstResponder() -> Bool {
		
		self.endTyping()
		
		return super.resignFirstResponder()
	}
	
	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
		self.primarySettingsView!.viewDidAppear()
	}
	
	public func clearView() {
		
	}
	
	public func handleTouchesBeganOutside(_ point: CGPoint, with event: UIEvent?) {
		
		// Check view is displayed
		guard (!isHidden && alpha != 0) else { return }

		// Handle changePasswordView touches
		if (self.currentView == .changepassword) {
			
			// Check point is inside changePasswordView
			if (self.changePasswordView.frame.contains(point)) {
				
				let subviewPoint: CGPoint = self.changePasswordView.convert(point, from: self)
				
				self.changePasswordView.handleTouchesBeganInside(subviewPoint, with: event)
				
			}
			
		}
		
	}
	
	public func dispose() {
		
		self.uikeyboardHelper.dispose()
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= SettingsViewControlManager()
		
		self.controlManager!.delegate 	= self
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: SettingsViewViewAccessStrategy = SettingsViewViewAccessStrategy()
		
		viewAccessStrategy.setup(primarySettingsView: 	self.primarySettingsView,
								 changePasswordView: 	self.changePasswordView)
		
		// Setup the view manager
		self.controlManager!.viewManager = SettingsViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("SettingsView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupKeyboard() {
		
		self.uikeyboardHelper.delegate = self
		self.uikeyboardHelper.setup()
		
	}
	
	fileprivate func setupView() {
		
		self.setupKeyboard()
		self.setupPrimarySettingsView()
		self.setupChangePasswordView()
		self.setupFadeOutView()
		
	}
	
	fileprivate func setupFadeOutView() {
		
		self.fadeOutView.alpha = 0
	}
	
	fileprivate func presentFadeOutView() {
		
		// Notify the delegate
		self.delegate?.settingsView(isPresentingModalDialog: self)
		
		// Show view
		UIView.animate(withDuration: 0.1) {
			
			self.fadeOutView.alpha = 1
		}
		
	}
	
	fileprivate func hideFadeOutView() {
		
		guard (self.fadeOutView.alpha != 0) else { return }
		
		// Notify the delegate
		self.delegate?.settingsView(isHidingModalDialog: self)
		
		// Hide view
		UIView.animate(withDuration: 0.1) {
			
			self.fadeOutView.alpha = 0
		}
		
	}
	
	fileprivate func setupPrimarySettingsView() {
		
		self.primarySettingsView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.primarySettingsPlaceholderView.isHidden	= true
		
		self.primarySettingsView.alpha					= 1
	}

	fileprivate func setupChangePasswordView() {

		self.changePasswordView.delegate				= self

		// Hide placeholder view which is just used for view in interface builder
		self.changePasswordPlaceholderView.isHidden	= true

		self.changePasswordView.alpha					= 0
	}
	
	fileprivate func endTyping() {
		
		_ = self.primarySettingsView.resignFirstResponder()
		_ = self.changePasswordView.resignFirstResponder()
		
	}
	
	fileprivate func presentPrimarySettingsView() {
		
		self.currentView = .primary
		
		self.hideFadeOutView()
		
		self.primarySettingsView.clearView()
		
		if (self.primarySettingsView.alpha != 1) {
			
			// Show view
			UIView.animate(withDuration: 0.3) {
				
				self.primarySettingsView.alpha 	= 1
				
			}
			
		}

	}
	
	fileprivate func presentChangePasswordView() {
		
		self.currentView = .changepassword
		
		self.presentFadeOutView()
		
		self.changePasswordView.clearView()
		
		self.changePasswordView.alpha 		= 0
		self.changePasswordView.transform 	= CGAffineTransform(scaleX: 0.001, y: 0.001)
		self.changePasswordView.alpha 		= 1
		
		UIView.animate(withDuration: 0.3, delay: 0.2, usingSpringWithDamping: 0.6, initialSpringVelocity: 1, options: .curveEaseInOut, animations: {

			self.changePasswordView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			
		}) { _ in

			self.changePasswordView.transform = CGAffineTransform.identity
		
		}
		
	}

	fileprivate func hideChangePasswordView() {
		
		// Hide view
		UIView.animate(withDuration: 0.1) {
			
			self.changePasswordView.alpha 	= 0
			
		}
		
	}
	
}

// MARK: - Extension ProtocolSettingsViewControlManagerDelegate

extension SettingsView: ProtocolSettingsViewControlManagerDelegate {
	
	// MARK: - Public Methods

	public func settingsViewControlManager(isNotConnected error: Error?) {
	
		
	}
	
}

// MARK: - Extension ProtocolPrimarySettingsViewDelegate

extension SettingsView: ProtocolPrimarySettingsViewDelegate {
	
	// MARK: - Public Methods
	
	public func primarySettingsView(changePasswordButtonTapped sender: PrimarySettingsView) {
		
		self.presentChangePasswordView()
		
	}
	
	public func primarySettingsView(avatarImageChanged sender: PrimarySettingsView) {
		
		// Notify the delegate
		self.delegate?.settingsView(avatarImageChanged: self)
		
	}
	
}

// MARK: - Extension ProtocolChangePasswordViewDelegate

extension SettingsView: ProtocolChangePasswordViewDelegate {
	
	// MARK: - Public Methods
	
	public func changePasswordView(cancelButtonTapped sender: ChangePasswordView) {

		self.hideChangePasswordView()
		self.presentPrimarySettingsView()
		
	}
	
	public func changePasswordView(doneButtonTapped sender: ChangePasswordView) {
		
		self.hideChangePasswordView()
		self.presentPrimarySettingsView()
		
	}
	
}

// MARK: - Extension ProtocolUIKeyboardHelperDelegate

extension SettingsView : ProtocolUIKeyboardHelperDelegate {
	
	// MARK: - Public Methods
	
	public func uikeyboardHelper(keyboardWillShow sender:Notification) {
		
		switch self.currentView {
		case .primary:
			self.primarySettingsView.keyboardWillShow(sender)
			
		case .changepassword:
			self.changePasswordView.keyboardWillShow(sender)
			
		}
		
	}
	
	public func uikeyboardHelper(keyboardWillHide sender:Notification) {
		
		switch self.currentView {
		case .primary:
			self.primarySettingsView.keyboardWillHide(sender)
			
		case .changepassword:
			self.changePasswordView.keyboardWillHide(sender)
			
		}
		
	}
	
}
