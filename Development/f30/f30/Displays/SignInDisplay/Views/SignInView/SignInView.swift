//
//  SignInView.swift
//  f30
//
//  Created by David on 08/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFSecurity
import f30View

/// A view class for a SignInView
public class SignInView: UIView, ProtocolSignInView {
	
	// MARK: - Private Stored Properties

	fileprivate var emailTextFieldIsValidYN: 								Bool = false
	fileprivate var passwordTextFieldIsValidYN: 							Bool = false
	fileprivate var isBusyYN: 												Bool = false
	fileprivate var topSpaceViewHeightLayoutConstraintConstant: 			CGFloat = 0
	fileprivate var textBoxesTopSpaceViewHeightLayoutConstraintConstant: 	CGFloat = 0
	fileprivate var pageButtonsStackViewTopLayoutConstraintConstant: 		CGFloat = 0
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:												ProtocolSignInViewDelegate?
	
	@IBOutlet weak var contentView:											UIView!
	@IBOutlet weak var activityIndicatorView: 								UIActivityIndicatorView!
	@IBOutlet weak var topSpaceView: 										UIView!
	@IBOutlet weak var topSpaceViewHeightLayoutConstraint: 					NSLayoutConstraint!
	@IBOutlet weak var textBoxesTopSpaceView: 								UIView!
	@IBOutlet weak var textBoxesTopSpaceViewHeightLayoutConstraint: 		NSLayoutConstraint!
	@IBOutlet weak var textBoxesView: 										UIView!
	@IBOutlet public weak var emailTextField: 								UITextField!
	@IBOutlet public weak var passwordTextField: 							UITextField!
	@IBOutlet weak var signInButton: 										UIButton!
	@IBOutlet weak var pageButtonsStackViewTopLayoutConstraint: 			NSLayoutConstraint!
	@IBOutlet weak var signUpInsteadButton: 								UIButton!
	@IBOutlet weak var recoverPasswordButton: 								UIButton!
	@IBOutlet weak var socialNetworksView: 									UIView!
	@IBOutlet weak var socialNetworksButtonsStackView: 						UIStackView!
	@IBOutlet weak var socialNetworksViewHeightLayoutConstraint: 			NSLayoutConstraint!
	
	
	// MARK: - Initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setupContentView()
		self.setupView()
		
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setupContentView()
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
	
	public func clearView() {
		
		self.emailTextField.text 			= nil
		self.passwordTextField.text 		= nil
		
		self.emailTextFieldIsValidYN 		= false
		self.passwordTextFieldIsValidYN 	= false
	}

	public func signInFailed(userProperties: 	UserProperties?,
	                         error: 			Error?,
	                         code: 				AuthenticationErrorCodes?) {
		
		self.isBusyYN = false
		
		self.activityIndicatorView.stopAnimating()
		
		self.setButtons()
		
		// DEBUG:
		//print(error?.localizedDescription)

		// Present message
		self.presentSignInFailedMessage(error: error, code: code)
	}
	
	public func keyboardWillShow(_ sender:Notification) {
		
		self.layoutIfNeeded()
		
		// Get the topSpaceViewHeightLayoutConstraintConstant
		self.topSpaceViewHeightLayoutConstraintConstant = self.topSpaceViewHeightLayoutConstraint.constant
		
		// Get textBoxesTopSpaceViewHeightLayoutConstraintConstant
		self.textBoxesTopSpaceViewHeightLayoutConstraintConstant = self.textBoxesTopSpaceViewHeightLayoutConstraint.constant
		
		// Get pageButtonsStackViewTopLayoutConstraintConstant
		self.pageButtonsStackViewTopLayoutConstraintConstant = self.pageButtonsStackViewTopLayoutConstraint.constant
		
		var topSpacePerc: 				CGFloat = 0.4
		var textBoxesTopSpacePerc: 		CGFloat = 0.6
		
		if (self.traitCollection.verticalSizeClass == .compact) {
			topSpacePerc 				= 1
			textBoxesTopSpacePerc 		= 1
		}
		
		UIView.animate(withDuration: 0.4, animations: {
			
			// Set topSpaceViewHeightLayoutConstraint
			self.topSpaceViewHeightLayoutConstraint.constant = (self.topSpaceViewHeightLayoutConstraintConstant - (self.topSpaceView.frame.size.height * topSpacePerc))
			
			// Set textBoxesTopSpaceViewHeightLayoutConstraint
			self.textBoxesTopSpaceViewHeightLayoutConstraint.constant = (self.textBoxesTopSpaceViewHeightLayoutConstraintConstant - (self.textBoxesTopSpaceView.frame.size.height * textBoxesTopSpacePerc))
			
			// pageButtonsStackViewTopLayoutConstraint
			self.pageButtonsStackViewTopLayoutConstraint.constant = 0
			
			self.socialNetworksView.alpha = 0
			
			self.layoutIfNeeded()
		})
		
	}
	
	public func keyboardWillHide(_ sender:Notification) {
		
		self.layoutIfNeeded()
		
		UIView.animate(withDuration: 0.4, animations: {
			
			// Set topSpaceViewHeightLayoutConstraint
			self.topSpaceViewHeightLayoutConstraint.constant = self.topSpaceViewHeightLayoutConstraintConstant
			
			// Set textBoxesTopSpaceViewHeightLayoutConstraint
			self.textBoxesTopSpaceViewHeightLayoutConstraint.constant = self.textBoxesTopSpaceViewHeightLayoutConstraintConstant
			
			// pageButtonsStackViewTopLayoutConstraint
			self.pageButtonsStackViewTopLayoutConstraint.constant = self.pageButtonsStackViewTopLayoutConstraintConstant
			
			self.socialNetworksView.alpha = 1
			
			self.layoutIfNeeded()
		})
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("SignInView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
		
	}

	fileprivate func setupView() {
		
		self.setupTextBoxesView()
		self.setupEmailTextField()
		self.setupPasswordTextField()
		self.setupSignInButton()
		self.setupActivityIndicatorView()
		self.setupSocialNetworksView()
		self.setupSignInWithTwitterView()
		self.setupSignInWithFacebookView()
	}
	
	fileprivate func setupTextBoxesView() {
		
		self.textBoxesView.layer.cornerRadius = 5
		
	}
	
	fileprivate func setupEmailTextField() {
		
		self.emailTextField.delegate = self
	}

	fileprivate func setupPasswordTextField() {
		
		self.passwordTextField.delegate = self
	}
	
	fileprivate func setupSignInButton() {
		
		self.signInButton.layer.cornerRadius 	= 5
		self.signInButton.isEnabled 			= false
	}
	
	fileprivate func setupActivityIndicatorView() {
		
		self.activityIndicatorView.stopAnimating()
		
	}
	
	fileprivate func setupSocialNetworksView() {
		
	}
	
	fileprivate func setupSignInWithTwitterView() {
		
		// Setup Twitter sign in
		let twitterSignInButton	= self.setupSignInWithTwitter()
		
		self.setupSignInButtonTwitter(twitterSignInButton)
		
	}
	
	fileprivate func setupSignInWithTwitter() -> UIButton {
		
		// Setup credential provider
		let credentialProvider = TwitterCredentialProvider()
		AuthenticationManager.shared.add(credentialProvider: credentialProvider, key: .twitter)
		
		// Create completion handler
		let signInCompletionHandler: (([String : Any]?, Error?, AuthenticationErrorCodes?) -> Void) =
		{
			[unowned self] (attributes, error, code) -> Void in
			
			self.activityIndicatorView.startAnimating()
			
			// Notify the delegate
			self.delegate?.signInView(signInWithTwitter: attributes, error: error, code: code, sender: self)
			
		}
		
		// Get button from credential provider
		let signInButton = credentialProvider.getSignInButton(signInCompletion: signInCompletionHandler)
		
		return signInButton
	}
	
	fileprivate func setupSignInButtonTwitter(_ signInButton: UIButton) {
		
		// Setup size constraints
		let heightConstraint	= NSLayoutConstraint(item: signInButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
		
		let widthConstraint		= NSLayoutConstraint(item: signInButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
		
		signInButton.addConstraints([heightConstraint, widthConstraint])
		
		// Set button text and font
		for sub in signInButton.subviews {
			
			for s in sub.subviews {
				
				if s is UILabel {
					
					(s as! UILabel).font = UIFont.systemFont(ofSize: 15, weight: .regular)
					(s as! UILabel).text = "Twitter"
				}
			}
		}
		
		// Add button to view
		self.socialNetworksButtonsStackView.addArrangedSubview(signInButton)
	}
	
	fileprivate func setupSignInWithFacebookView() {
		
		// Setup Facebook sign in
		let facebookSignInButton = self.setupSignInWithFacebook()
		
		self.setupSignInButtonFacebook(facebookSignInButton)
		
	}
	
	fileprivate func setupSignInWithFacebook() -> UIView {
		
		// Setup credential provider
		let credentialProvider = FacebookCredentialProvider()
		AuthenticationManager.shared.add(credentialProvider: credentialProvider, key: .facebook)
		
		// Create completion handler
		let signInCompletionHandler: (([String : Any]?, Error?, AuthenticationErrorCodes?) -> Void) =
		{
			[unowned self] (attributes, error, code) -> Void in
			
			self.activityIndicatorView.startAnimating()
			
			// Notify the delegate
			self.delegate?.signInView(signInWithFacebook: attributes, error: error, code: code, sender: self)
			
		}
		
		// Get button from credential provider
		let signInButton = credentialProvider.getSignInButton(signInCompletion: signInCompletionHandler)
		
		return signInButton
	}
	
	fileprivate func setupSignInButtonFacebook(_ signInButton: UIView) {
		
		// Setup size constraints
		let heightConstraint	= NSLayoutConstraint(item: signInButton, attribute: .height, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 30)
		
		let widthConstraint		= NSLayoutConstraint(item: signInButton, attribute: .width, relatedBy: .equal, toItem: nil, attribute: .notAnAttribute, multiplier: 1, constant: 120)
		
		signInButton.addConstraints([heightConstraint, widthConstraint])
		
		// Get the button
		let uibutton: UIButton = signInButton as! UIButton
		
		// Set button text and font
		uibutton.setAttributedTitle(NSAttributedString(string: "Facebook"), for: .normal)
		uibutton.titleLabel?.font = UIFont.systemFont(ofSize: 15, weight: .regular)
		
		// Add button to view
		self.socialNetworksButtonsStackView.addArrangedSubview(signInButton)
	}
	
	fileprivate func setButtons() {
		
		let isValidYN: Bool = 	(self.emailTextFieldIsValidYN
								&& self.passwordTextFieldIsValidYN)
		
		self.signInButton.isEnabled 				= isValidYN && !self.isBusyYN
		
		self.signUpInsteadButton.isEnabled 			= !self.isBusyYN
		self.recoverPasswordButton.isEnabled 		= !self.isBusyYN
	}
	
	fileprivate func checkEmailTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check emailTextField
		let emailTextFieldLength: Int = self.emailTextField.text?.count ?? 0
		if (emailTextFieldLength == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func checkPasswordTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check passwordTextField
		let passwordTextFieldLength: Int = self.passwordTextField.text?.count ?? 0
		if (passwordTextFieldLength == 0) { result = false }

		return result
		
	}
	
	fileprivate func presentSignInFailedMessage(error: 	Error?,
	                                            code: 	AuthenticationErrorCodes?) {
		
		// Get alert title and message
		var alertTitle: 	String = ""
		var alertMessage: 	String = ""
		
		
		let code = code ?? .unspecified
		
		switch code {
		case .invalidEmail, .userNotFound:
			alertTitle 		= NSLocalizedString("AlertTitleSignInInvalidEmail", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignInInvalidEmail", comment: "")
			
		case .wrongPassword:
			alertTitle 		= NSLocalizedString("AlertTitleSignInWrongPassword", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignInWrongPassword", comment: "")
			
		case .notConnected:
			alertTitle 		= NSLocalizedString("AlertTitleSignInNotConnected", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignInNotConnected", comment: "")
			
		default:
			alertTitle 		= NSLocalizedString("AlertTitleSignInFailedUnspecified", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignInFailedUnspecified", comment: "")
			
		}

		self.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage)
		
	}
	
	fileprivate func endTyping() {
		
		self.emailTextField.resignFirstResponder()
		self.passwordTextField.resignFirstResponder()
		
	}
	
	fileprivate func presentAlert(alertTitle: String, alertMessage: String) {
		
		// Create alertController
		let alertController: 	UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
		
		// Create 'OK' action
		let okAlertActionTitle: String = NSLocalizedString("AlertActionTitleOk", comment: "")
		let alertAction:		UIAlertAction = UIAlertAction(title: okAlertActionTitle, style: .default, handler: nil)
		alertController.addAction(alertAction)
		
		// Present alertController
		UIViewControllerHelper.getPresentedViewController().present(alertController, animated: true, completion: nil)
		
	}
	
	
	// MARK: - signInButton Methods
	
	@IBAction func signInButtonTapped(_ sender: Any) {
		
		self.isBusyYN = true
		
		self.activityIndicatorView.startAnimating()
		self.setButtons()
		
		// Notify the delegate
		self.delegate?.signInView(signInWithEmail: self)
		
	}
	
	
	// MARK: - signUpInsteadButton Methods
	
	@IBAction func signUpInsteadButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Notify the delegate
		self.delegate?.signInView(signUpInstead: self)
		
	}

	
	// MARK: - recoverPasswordButton Methods
	
	@IBAction func recoverPasswordButtonTapped(_ sender: Any) {

		self.endTyping()
		
		// Notify the delegate
		self.delegate?.signInView(recoverPassword: self)
		
	}
	
	
	// MARK: - emailTextField Methods
	
	@IBAction func emailTextFieldTextChanged(_ sender: Any) {

		self.emailTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkEmailTextFieldIsEntered()) { self.emailTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}
	
	
	// MARK: - passwordTextField Methods
	
	@IBAction func passwordTextFieldTextChanged(_ sender: Any) {
		
		self.passwordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkPasswordTextFieldIsEntered()) { self.passwordTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}
	
}

// MARK: - Extension UITextFieldDelegate

extension SignInView : UITextFieldDelegate {

	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {

		// Get maxLength
		var maxLength: 		Int = Int.max

		if (textField == self.emailTextField) 			{ maxLength = 50 }		// emailTextField
		else if (textField == self.passwordTextField) 	{ maxLength = 50 }		// passwordTextField

		let result: 		Bool = UITextFieldHelper.checkMaxLength(textField: textField, shouldChangeCharactersIn: range, replacementString: string, maxLength: maxLength)

		return result
	}

	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		// Try to find next responder
		if let nextField = textField.superview?.viewWithTag(textField.tag + 1) as? UITextField {
			
			nextField.becomeFirstResponder()
			
		} else {
			
			textField.resignFirstResponder()
			
		}
		
		// passwordTextField
		if (textField == self.passwordTextField) {
			
			self.signInButtonTapped(self)
			
			return true
		}
		
		return true
		
	}
	
}



