//
//  AuthenticationView.swift
//  f30
//
//  Created by David on 02/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import CoreData
import UIKit
import SFView
import SFSecurity
import f30Controller
import f30View
import f30Model

/// Specifies authentication views
enum AuthenticationViews : Int {
	case signIn = 1
	case signUp = 2
	case recoverPassword = 3
}

/// A view class for a AuthenticationView
public class AuthenticationView: UIView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						AuthenticationViewControlManager?
	fileprivate var controlManagerBaseDelegate:			ControlManagerBaseDelegate = ControlManagerBaseDelegate()
	fileprivate var uikeyboardHelper: 					UIKeyboardHelper = UIKeyboardHelper()
	fileprivate var currentView: 						AuthenticationViews = .signIn
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolAuthenticationViewDelegate?

	@IBOutlet var contentView:							UIView!
	@IBOutlet weak var signInView: 						SignInView!
	@IBOutlet weak var signInPlaceholderView: 			UIView!
	@IBOutlet weak var signUpView: 						SignUpView!
	@IBOutlet weak var signUpPlaceholderView: 			UIView!
	@IBOutlet weak var recoverPasswordView: 			RecoverPasswordView!
	@IBOutlet weak var recoverPasswordPlaceholderView: 	UIView!
	
	
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
	
	public func clear() {
		
		// TODO:
		
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
		self.controlManager 				= AuthenticationViewControlManager()
	
		self.controlManager!.baseDelegate 	= self.controlManagerBaseDelegate
		
		self.controlManager!.delegate 		= self
		
		// Setup authentication
		self.controlManager!.setupAuthentication()
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: AuthenticationViewViewAccessStrategy = AuthenticationViewViewAccessStrategy()
		
		viewAccessStrategy.setup(signInView: 			self.signInView,
		                         signUpView: 			self.signUpView,
		                         recoverPasswordView: 	self.recoverPasswordView)
		
		// Setup the view manager
		self.controlManager!.viewManager = AuthenticationViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupView() {
		
		self.setupKeyboard()
		self.setupSignInView()
		self.setupSignUpView()
		self.setupRecoverPasswordView()

	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("AuthenticationView", owner: self, options: nil)
		
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
	
	fileprivate func setupSignInView() {
		
		self.signInView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.signInPlaceholderView.isHidden		= true
	
		self.signInView.alpha					= 1
	}
	
	fileprivate func setupSignUpView() {
		
		self.signUpView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.signUpPlaceholderView.isHidden		= true
		
		self.signUpView.alpha					= 0
	}

	fileprivate func setupRecoverPasswordView() {
		
		self.recoverPasswordView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.recoverPasswordPlaceholderView.isHidden	= true
		
		self.recoverPasswordView.alpha					= 0
	}
	
	fileprivate func endTyping() {
		
		_ = self.signInView.resignFirstResponder()
		_ = self.signUpView.resignFirstResponder()
		_ = self.recoverPasswordView.resignFirstResponder()
		
	}
	
	fileprivate func onSignInSuccessful(userProperties: UserProperties) {
		
		// Notify the delegate
		self.delegate?.authenticationView(signInSuccessful: userProperties)
		
	}
	
	fileprivate func onSignInFailed(userProperties: UserProperties?,
	                                error: 			Error?,
	                                code: 			AuthenticationErrorCodes?) {
		
		self.signInView.signInFailed(userProperties: userProperties, error: error, code: code)
		
		// Notify the delegate
		self.delegate?.authenticationView(signInFailed: userProperties, error: error, code: code)
		
	}
	
	fileprivate func onSignUpSuccessful(userProperties: UserProperties) {
		
		if (self.controlManager!.isSignedInYN()) {
			
			// Notify the delegate
			self.delegate?.authenticationView(signUpSuccessful: userProperties)
			
		}
		
	}
	
	fileprivate func onSignUpFailed(userProperties: UserProperties?,
	                                error: 			Error?,
	                                code: 			AuthenticationErrorCodes?) {
		
		self.signUpView.signUpFailed(userProperties: userProperties, error: error, code: code)
		
		// Notify the delegate
		self.delegate?.authenticationView(signUpFailed: userProperties, error: error, code: code)
		
	}
	
	fileprivate func onRecoverPasswordSuccessful() {

		self.recoverPasswordView.recoverPasswordSuccessful()
		
		// Notify the delegate
		self.delegate?.authenticationView(recoverPasswordSuccessful: self)
		
	}
	
	fileprivate func onRecoverPasswordFailed(error: 	Error?,
	                                         code: 		AuthenticationErrorCodes?) {
	
		self.recoverPasswordView.recoverPasswordFailed(error: error, code: code)
		
		// Notify the delegate
		self.delegate?.authenticationView(recoverPasswordFailed: error, code: code)
		
	}
	
	fileprivate func presentSignUpView() {
		
		self.currentView = .signUp
		
		self.signUpView.clearView()
		
		// Show view
		UIView.animate(withDuration: 0.3) {
			
			self.signUpView.alpha = 1
			self.signInView.alpha = 0
			
		}
		
	}
	
	fileprivate func presentSignInView() {
		
		self.currentView = .signIn
		
		self.signInView.clearView()
		
		// Show view
		UIView.animate(withDuration: 0.3) {
			
			self.signInView.alpha 			= 1
			self.signUpView.alpha 			= 0
			self.recoverPasswordView.alpha 	= 0
			
		}
		
	}
	
	fileprivate func presentRecoverPasswordView() {
		
		self.currentView = .recoverPassword
		
		self.recoverPasswordView.clearView()
		
		// Show view
		UIView.animate(withDuration: 0.3) {
			
			self.recoverPasswordView.alpha 	= 1
			self.signInView.alpha 			= 0
			
		}
		
	}
	
}

// MARK: - Extension ProtocolAuthenticationViewControlManagerDelegate

extension AuthenticationView: ProtocolAuthenticationViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
	public func authenticationViewControlManager(signInSuccessful userProperties: UserProperties) {
		
		self.onSignInSuccessful(userProperties: userProperties)
	}

	public func authenticationViewControlManager(signInFailed userProperties: UserProperties?,
	                                             error: 	Error?,
	                                             code: 		AuthenticationErrorCodes?) {
		
		self.onSignInFailed(userProperties: userProperties, error: error, code: code)
	}
	
	public func authenticationViewControlManager(signUpSuccessful userProperties: UserProperties) {
		
		self.onSignUpSuccessful(userProperties: userProperties)
	}
	
	public func authenticationViewControlManager(signUpFailed userProperties: UserProperties?,
	                                             error: 	Error?,
	                                             code: 		AuthenticationErrorCodes?) {
		
		self.onSignUpFailed(userProperties: userProperties, error: error, code: code)
	}

	public func authenticationViewControlManager(recoverPasswordSuccessful sender: AuthenticationViewControlManager) {
		
		self.onRecoverPasswordSuccessful()
	}
	
	public func authenticationViewControlManager(recoverPasswordFailed error: Error?,
	                                             code: 	AuthenticationErrorCodes?) {
		
		self.onRecoverPasswordFailed(error: error, code: code)
	}
		
}

// MARK: - Extension ProtocolSignInViewDelegate

extension AuthenticationView: ProtocolSignInViewDelegate {

	// MARK: - Public Methods
	
	public func signInView(signUpInstead sender: SignInView) {
	
		self.presentSignUpView()
	}
	
	public func signInView(signInWithEmail sender: SignInView) {
		
		// Notify the delegate
		self.delegate?.authenticationView(isSigningIn: self)
		
		self.controlManager!.signInWithEmail()
		
	}
	
	public func signInView(signInWithTwitter attributes: [String : Any]?,
	                       error: 	Error?,
	                       code: 	AuthenticationErrorCodes?,
	                       sender: 	SignInView) {

		var code = code
		
		if (error == nil) {
			
			// Notify the delegate
			self.delegate?.authenticationView(isSigningIn: self)
			
			self.controlManager!.signInWithTwitter(attributes: attributes)
			
		} else {

			if (!self.controlManager!.checkIsConnected()) {
				
				code = AuthenticationErrorCodes.notConnected
			}
			
			self.onSignInFailed(userProperties: nil, error: error, code: code)
			
		}
		
	}
	
	public func signInView(signInWithFacebook attributes: [String : Any]?,
	                       error: 	Error?,
	                       code: 	AuthenticationErrorCodes?,
	                       sender: 	SignInView) {
		
		var code = code
		
		if (error == nil) {
			
			// Notify the delegate
			self.delegate?.authenticationView(isSigningIn: self)
			
			self.controlManager!.signInWithFacebook(attributes: attributes)
			
		} else {
			
			if (!self.controlManager!.checkIsConnected()) {
				
				code = AuthenticationErrorCodes.notConnected
			}
			
			self.onSignInFailed(userProperties: nil, error: error, code: code)
			
		}
		
	}
	
	public func signInView(recoverPassword sender: SignInView) {
		
		self.presentRecoverPasswordView()
	}
	
}

// MARK: - Extension ProtocolSignUpViewDelegate

extension AuthenticationView: ProtocolSignUpViewDelegate {
	
	// MARK: - Public Methods
	
	public func signUpView(signInInstead sender: SignUpView) {
	
		self.presentSignInView()
	}
	
	public func signUpView(signUp sender: SignUpView) {
		
		// Notify the delegate
		self.delegate?.authenticationView(isSigningUp: self)
		
		self.controlManager!.signUp()
		
	}

}

// MARK: - Extension ProtocolRecoverPasswordViewDelegate

extension AuthenticationView: ProtocolRecoverPasswordViewDelegate {
	
	// MARK: - Public Methods
	
	public func recoverPasswordView(cancel sender: RecoverPasswordView) {
		
		self.presentSignInView()
	}
	
	public func recoverPasswordView(recoverPasswordWithEmail sender: RecoverPasswordView) {
		
		// Notify the delegate
		self.delegate?.authenticationView(isRecoveringPassword: self)
		
		self.controlManager!.recoverPasswordWithEmail()
	}
	
}

// MARK: - Extension ProtocolUIKeyboardHelperDelegate

extension AuthenticationView : ProtocolUIKeyboardHelperDelegate {
	
	// MARK: - Public Methods
	
	public func uikeyboardHelper(keyboardWillShow sender:Notification) {
		
		switch self.currentView {
		case .signIn:
			self.signInView.keyboardWillShow(sender)
			
		case .signUp:
			self.signUpView.keyboardWillShow(sender)
			
		case .recoverPassword:
			self.recoverPasswordView.keyboardWillShow(sender)
			
		}
		
	}
	
	public func uikeyboardHelper(keyboardWillHide sender:Notification) {
		
		switch self.currentView {
		case .signIn:
			self.signInView.keyboardWillHide(sender)
			
		case .signUp:
			self.signUpView.keyboardWillHide(sender)
			
		case .recoverPassword:
			self.recoverPasswordView.keyboardWillHide(sender)
			
		}
		
	}
	
}
