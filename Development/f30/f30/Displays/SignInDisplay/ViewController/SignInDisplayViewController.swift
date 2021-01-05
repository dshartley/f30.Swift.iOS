//
//  SignInDisplayViewController.swift
//  f30
//
//  Created by David on 30/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import Foundation
import SFSecurity
import f30Core
import f30Model
import f30View
import f30Controller

/// A ViewController for the SignInDisplay
public class SignInDisplayViewController: UIViewController {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:								SignInDisplayControlManager?
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:									ProtocolSignInDisplayViewControllerDelegate?

	@IBOutlet weak var authenticationView: 						AuthenticationView!
	@IBOutlet weak var authenticationPlaceholderView: 			UIView!

	
	// MARK: - Override Methods
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.setup()
		
		self.setupAuthenticationView()
		
	}
	
	public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		// TODO:
		
	}
	
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		self.endTyping()
	}
	
	public override func viewDidDisappear(_ animated: Bool) {
		
		self.dispose()
	}
	
	
	// MARK: - Public Methods

	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func dispose() {
		
		self.authenticationView.dispose()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager = SignInDisplayControlManager()
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)

	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: SignInDisplayViewAccessStrategy = SignInDisplayViewAccessStrategy()
		
		// Setup the view manager
		self.controlManager!.viewManager = SignInDisplayViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupAuthenticationView() {
		
		self.authenticationView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.authenticationPlaceholderView.isHidden		= true

	}
	
	fileprivate func endTyping() {
		
		_ = self.authenticationView.resignFirstResponder()
		
	}
	
	fileprivate func dismissDisplay() {
		
		if (self.delegate != nil) {
			
			// Notify the delegate
			self.delegate!.signInDisplayViewController(dismiss: self)
			
		} else {
			
			DispatchQueue.main.async {
				
				// Segue to MainDisplay
				self.performSegue(withIdentifier: "showMainDisplay", sender: self)
				
			}

		}
		
	}
	
	fileprivate func onSignInSuccessful() {
		
		// Dismiss display
		self.dismissDisplay()
	}
	
	fileprivate func onSignUpSuccessful() {
		
		if (self.controlManager!.isSignedInYN()) {
			
			// Dismiss display
			self.dismissDisplay()
		}
	}

}

// MARK: - Extension ProtocolAuthenticationViewDelegate

extension SignInDisplayViewController: ProtocolAuthenticationViewDelegate {
	
	// MARK: - Public Methods
	
	public func authenticationView(isSigningIn sender: AuthenticationView) {
		
		// Not required
		
	}
	
	public func authenticationView(signInSuccessful userProperties: UserProperties) {
		
		self.onSignInSuccessful()
	}

	public func authenticationView(signInFailed userProperties: UserProperties?,
	                               error: 	Error?,
	                               code: 	AuthenticationErrorCodes?) {
		
		// Not required
		
	}
	
	public func authenticationView(isSigningUp sender: AuthenticationView) {
		
		// Not required
		
	}
	
	public func authenticationView(signUpSuccessful userProperties: UserProperties) {
		
		self.onSignUpSuccessful()
	}
	
	public func authenticationView(signUpFailed userProperties: UserProperties?,
	                               error: 	Error?,
	                               code: 	AuthenticationErrorCodes?) {
		
		// Not required
		
	}
	
	public func authenticationView(isRecoveringPassword sender: AuthenticationView) {
		
		// Not required
		
	}
	
	public func authenticationView(recoverPasswordSuccessful sender: AuthenticationView) {
		
		// Not required
		
	}
	
	public func authenticationView(recoverPasswordFailed error: Error?,
	                               code: 	AuthenticationErrorCodes?) {
		
		// Not required
		
	}
}

