//
//  RecoverPasswordView.swift
//  f30
//
//  Created by David on 13/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFSecurity
import f30View

/// A view class for a RecoverPasswordView
public class RecoverPasswordView: UIView, ProtocolRecoverPasswordView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var emailTextFieldIsValidYN: 								Bool = false
	fileprivate var isBusyYN: 												Bool = false
	fileprivate var topSpaceViewHeightLayoutConstraintConstant: 			CGFloat = 0
	fileprivate var textBoxesTopSpaceViewHeightLayoutConstraintConstant: 	CGFloat = 0
	fileprivate var signInInsteadButtonTopLayoutConstraintConstant: 		CGFloat = 0
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:													ProtocolRecoverPasswordViewDelegate?

	@IBOutlet weak var contentView:											UIView!
	@IBOutlet weak var activityIndicatorView: 								UIActivityIndicatorView!
	@IBOutlet weak var topSpaceView: 										UIView!
	@IBOutlet weak var topSpaceViewHeightLayoutConstraint: 					NSLayoutConstraint!
	@IBOutlet weak var textBoxesTopSpaceView: 								UIView!
	@IBOutlet weak var textBoxesTopSpaceViewHeightLayoutConstraint: 		NSLayoutConstraint!
	@IBOutlet weak var textBoxesView: 										UIView!
	@IBOutlet public weak var emailTextField: 								UITextField!
	@IBOutlet weak var recoverPasswordButton: 								UIButton!
	@IBOutlet weak var signInInsteadButton: 								UIButton!
	@IBOutlet weak var signInInsteadButtonTopLayoutConstraint: 				NSLayoutConstraint!
	
	
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
		
		self.emailTextField.text 		= nil
		self.emailTextFieldIsValidYN 	= false
	}
	
	public func recoverPasswordSuccessful() {
		
		self.isBusyYN = false
		
		self.activityIndicatorView.stopAnimating()
		
		self.setButtons()
		
		// Present message
		self.presentRecoverPasswordSuccessfulMessage()
	}

	public func recoverPasswordFailed(error:	Error?,
									  code: 	AuthenticationErrorCodes?) {
		
		self.isBusyYN = false
		
		self.activityIndicatorView.stopAnimating()
		
		self.setButtons()
		
		// DEBUG:
		//print(error?.localizedDescription)
		
		// Present message
		self.presentRecoverPasswordFailedMessage(error: error, code: code)
		
	}
	
	public func keyboardWillShow(_ sender:Notification) {
		
		self.layoutIfNeeded()
		
		// Get the topSpaceViewHeightLayoutConstraintConstant
		self.topSpaceViewHeightLayoutConstraintConstant = self.topSpaceViewHeightLayoutConstraint.constant
		
		// Get textBoxesTopSpaceViewHeightLayoutConstraintConstant
		self.textBoxesTopSpaceViewHeightLayoutConstraintConstant = self.textBoxesTopSpaceViewHeightLayoutConstraint.constant
		
		// Get signInInsteadButtonTopLayoutConstraintConstant
		self.signInInsteadButtonTopLayoutConstraintConstant = self.signInInsteadButtonTopLayoutConstraint.constant
		
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
			
			// signInInsteadButtonTopLayoutConstraint
			self.signInInsteadButtonTopLayoutConstraint.constant = 0
			
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
			
			// signInInsteadButtonTopLayoutConstraint
			self.signInInsteadButtonTopLayoutConstraint.constant = self.signInInsteadButtonTopLayoutConstraintConstant
			
			self.layoutIfNeeded()
		})
	}

	
	// MARK: - Private Methods
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("RecoverPasswordView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
		self.setupTextBoxesView()
		self.setupEmailTextField()
		self.setupRecoverPasswordButton()
		self.setupActivityIndicatorView()
		
	}
	
	fileprivate func setupTextBoxesView() {
		
		self.textBoxesView.layer.cornerRadius = 5
		
	}
	
	fileprivate func setupEmailTextField() {
		
		self.emailTextField.delegate = self
	}
	
	fileprivate func setupRecoverPasswordButton() {
		
		self.recoverPasswordButton.layer.cornerRadius 	= 5
		self.recoverPasswordButton.isEnabled 			= false
	}
	
	fileprivate func setupActivityIndicatorView() {
		
		self.activityIndicatorView.stopAnimating()
		
	}
	
	fileprivate func setButtons() {
		
		let isValidYN: Bool = (self.emailTextFieldIsValidYN)
		
		self.recoverPasswordButton.isEnabled 	= isValidYN && !self.isBusyYN
		
		self.signInInsteadButton.isEnabled 		= !self.isBusyYN
	}
	
	fileprivate func checkEmailTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check emailTextField
		let emailTextFieldLength: Int = self.emailTextField.text?.count ?? 0
		if (emailTextFieldLength == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func presentRecoverPasswordFailedMessage(error: 	Error?,
														 code: 		AuthenticationErrorCodes?) {
		
		// Get alert title and message
		var alertTitle: 	String = ""
		var alertMessage: 	String = ""
		
		
		let code = code ?? .unspecified
		
		switch code {
		case .invalidEmail, .userNotFound:
			alertTitle 		= NSLocalizedString("AlertTitleRecoverPasswordUserNotFound", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageRecoverPasswordUserNotFound", comment: "")
			
		case .notConnected:
			alertTitle 		= NSLocalizedString("AlertTitleRecoverPasswordNotConnected", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageRecoverPasswordNotConnected", comment: "")
			
		default:
			alertTitle 		= NSLocalizedString("AlertTitleRecoverPasswordFailedUnspecified", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageRecoverPasswordFailedUnspecified", comment: "")
			
		}
		
		self.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage)
		
	}
	
	fileprivate func presentRecoverPasswordSuccessfulMessage() {
		
		// Get alert title and message
		let alertTitle: 	String = NSLocalizedString("AlertTitleRecoverPasswordSuccessful", comment: "")
		let alertMessage: 	String = NSLocalizedString("AlertMessageRecoverPasswordSuccessful", comment: "")
		
		self.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage)
		
	}
	
	fileprivate func endTyping() {
		
		self.emailTextField.resignFirstResponder()
		
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
	
	
	// MARK: - emailTextField Methods
	
	@IBAction func emailTextFieldTextChanged(_ sender: Any) {
		
		self.emailTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkEmailTextFieldIsEntered()) { self.emailTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}
	
	
	// MARK: - recoverPasswordButton Methods
	
	@IBAction func recoverPasswordButtonTapped(_ sender: Any) {
		
		self.isBusyYN = true
		
		self.activityIndicatorView.startAnimating()
		self.setButtons()
		
		// Notify the delegate
		self.delegate?.recoverPasswordView(recoverPasswordWithEmail: self)
		
	}
	
	
	// MARK: - signInInsteadButton Methods
	
	@IBAction func signInInsteadButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Notify the delegate
		self.delegate?.recoverPasswordView(cancel: self)
		
	}
	
}

// MARK: - Extension UITextFieldDelegate

extension RecoverPasswordView : UITextFieldDelegate {
	
	// MARK: - Public Methods
	
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		// Get maxLength
		var maxLength: 		Int = Int.max
		
		if (textField == self.emailTextField) 			{ maxLength = 50 }		// emailTextField
		
		let result: 		Bool = UITextFieldHelper.checkMaxLength(textField: textField, shouldChangeCharactersIn: range, replacementString: string, maxLength: maxLength)
		
		return result
	}
	
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		// emailTextField
		if (textField == self.emailTextField) {
			
			self.recoverPasswordButtonTapped(self)
			
			return true
		}
		
		return true
		
	}
	
}




