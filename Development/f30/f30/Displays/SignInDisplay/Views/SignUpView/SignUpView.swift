//
//  SignUpView.swift
//  f30
//
//  Created by David on 08/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFSecurity
import f30View

/// A view class for a SignUpView
public class SignUpView: UIView, ProtocolSignUpView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var emailTextFieldIsValidYN: 								Bool = false
	fileprivate var dateofBirthTextFieldIsValidYN: 							Bool = false
	fileprivate var passwordTextFieldIsValidYN: 							Bool = false
	fileprivate var confirmPasswordTextFieldIsValidYN: 						Bool = false
	fileprivate var isBusyYN: 												Bool = false
	fileprivate var topSpaceViewHeightLayoutConstraintConstant: 			CGFloat = 0
	fileprivate var textBoxesTopSpaceViewHeightLayoutConstraintConstant: 	CGFloat = 0
	fileprivate var signInInsteadButtonTopLayoutConstraintConstant: 		CGFloat = 0
	fileprivate var dateofBirthDatePicker: 									UIDatePicker = UIDatePicker()
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:												ProtocolSignUpViewDelegate?
	
	@IBOutlet weak var contentView:											UIView!
	@IBOutlet weak var activityIndicatorView: 								UIActivityIndicatorView!
	@IBOutlet weak var topSpaceView: 										UIView!
	@IBOutlet weak var topSpaceViewHeightLayoutConstraint: 					NSLayoutConstraint!
	@IBOutlet weak var textBoxesTopSpaceView: 								UIView!
	@IBOutlet weak var textBoxesTopSpaceViewHeightLayoutConstraint: 		NSLayoutConstraint!
	@IBOutlet weak var textBoxesView: 										UIView!
	@IBOutlet public weak var emailTextField: 								UITextField!
	@IBOutlet weak var dateofBirthTextField: 								UITextField!
	@IBOutlet public weak var passwordTextField: 							UITextField!
	@IBOutlet weak var confirmPasswordTextField: 							UITextField!
	@IBOutlet weak var signUpButton: 										UIButton!
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
		
		self.emailTextField.text 				= nil
		self.dateofBirthTextField.text 			= nil
		self.passwordTextField.text 			= nil
		self.confirmPasswordTextField.text 		= nil
		
		self.emailTextFieldIsValidYN 			= false
		self.dateofBirthTextFieldIsValidYN 		= false
		self.passwordTextFieldIsValidYN 		= false
		self.confirmPasswordTextFieldIsValidYN 	= false
	}
	
	public func signUpFailed(userProperties: 	UserProperties?,
	                         error: 			Error?,
	                         code: 				AuthenticationErrorCodes?) {
		
		self.isBusyYN = false
		
		self.activityIndicatorView.stopAnimating()
		
		self.setButtons()
		
		// DEBUG:
		//print(error?.localizedDescription)
		
		// Present message
		self.presentSignUpFailedMessage(error: error, code: code)
		
	}
	
	public func getDateofBirth() -> Date {
		
		return self.dateofBirthDatePicker.date
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
		Bundle.main.loadNibNamed("SignUpView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
		
	}
	
	fileprivate func setupView() {
		
		self.setupTextBoxesView()
		self.setupEmailTextField()
		self.setupDateofBirthTextField()
		self.setupDateofBirthDatePicker()
		self.setupPasswordTextField()
		self.setupConfirmPasswordTextField()
		self.setupSignUpButton()
		self.setupActivityIndicatorView()
		
	}
	
	fileprivate func setupTextBoxesView() {
		
		self.textBoxesView.layer.cornerRadius = 5
		
	}
	
	fileprivate func setupEmailTextField() {
		
		self.emailTextField.delegate = self
	}
	
	fileprivate func setupDateofBirthTextField() {
		
		self.dateofBirthTextField.delegate = self
	}
	
	fileprivate func setupDateofBirthDatePicker() {
		
		self.dateofBirthDatePicker.datePickerMode 	= UIDatePickerMode.date
		
		self.dateofBirthDatePicker.addTarget(self, action: #selector(dateofBirthDatePickerChanged(sender:)), for: .valueChanged)
		
	}
	
	fileprivate func setupPasswordTextField() {
		
		self.passwordTextField.delegate = self
	}
	
	fileprivate func setupConfirmPasswordTextField() {
		
		self.confirmPasswordTextField.delegate = self
	}
	
	fileprivate func setupSignUpButton() {
		
		self.signUpButton.layer.cornerRadius 	= 5
		self.signUpButton.isEnabled 			= false
	}
	
	fileprivate func setupActivityIndicatorView() {
		
		self.activityIndicatorView.stopAnimating()
		
	}
	
	fileprivate func setButtons() {
		
		let isValidYN: Bool = 		(self.emailTextFieldIsValidYN
									&& self.dateofBirthTextFieldIsValidYN
									&& self.passwordTextFieldIsValidYN
									&& self.confirmPasswordTextFieldIsValidYN)
		
		self.signUpButton.isEnabled 		= isValidYN && !self.isBusyYN
		
		self.signInInsteadButton.isEnabled 	= !self.isBusyYN
	}

	fileprivate func checkEmailTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check emailTextField
		let emailTextFieldLength: Int = self.emailTextField.text?.count ?? 0
		if (emailTextFieldLength == 0) { result = false }
		
		return result
		
	}

	fileprivate func checkDateofBirthTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check dateofBirthTextField
		let dateofBirthTextFieldLength: Int = self.dateofBirthTextField.text?.count ?? 0
		if (dateofBirthTextFieldLength == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func checkPasswordTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check passwordTextField
		let passwordTextFieldLength: Int = self.passwordTextField.text?.count ?? 0
		if (passwordTextFieldLength == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func checkConfirmPasswordTextFieldIsCorrect() -> Bool {
		
		var result: Bool = true
		
		// Check confirmPasswordTextField
		if (self.confirmPasswordTextField.text == nil ||
			self.confirmPasswordTextField.text != self.passwordTextField.text) { result = false }
		
		return result
		
	}
	
	fileprivate func checkConfirmPasswordTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check confirmPasswordTextField
		let confirmPasswordTextFieldLength: Int = self.confirmPasswordTextField.text?.count ?? 0
		if (confirmPasswordTextFieldLength == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func presentSignUpFailedMessage(error: 	Error?,
	                                            code: 	AuthenticationErrorCodes?) {
		
		// Get alert title and message
		var alertTitle: 	String = ""
		var alertMessage: 	String = ""
		
		
		let code = code ?? .unspecified
		
		switch code {
		case .invalidEmail:
			alertTitle 		= NSLocalizedString("AlertTitleSignUpInvalidEmail", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignUpInvalidEmail", comment: "")
			
		case .emailAlreadyInUse:
			alertTitle 		= NSLocalizedString("AlertTitleSignUpEmailAlreadyInUse", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignUpEmailAlreadyInUse", comment: "")

		case .weakPassword:
			alertTitle 		= NSLocalizedString("AlertTitleSignUpWeakPassword", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignUpWeakPassword", comment: "")

		case .wrongConfirmPassword:
			alertTitle 		= NSLocalizedString("AlertTitleSignUpWrongConfirmPassword", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignUpWrongConfirmPassword", comment: "")
			
		case .notConnected:
			alertTitle 		= NSLocalizedString("AlertTitleSignUpNotConnected", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignUpNotConnected", comment: "")
			
		default:
			alertTitle 		= NSLocalizedString("AlertTitleSignUpFailedUnspecified", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageSignUpFailedUnspecified", comment: "")
			
		}
		
		self.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage)
		
	}
	
	fileprivate func endTyping() {
		
		self.emailTextField.resignFirstResponder()
		self.dateofBirthTextField.resignFirstResponder()
		self.passwordTextField.resignFirstResponder()
		self.confirmPasswordTextField.resignFirstResponder()
		
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
	
	
	// MARK: - signUpButton Methods
	
	@IBAction func signUpButtonTapped(_ sender: Any) {

		self.confirmPasswordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkConfirmPasswordTextFieldIsCorrect()) {
			
			self.confirmPasswordTextFieldIsValidYN = false
			self.setButtons()
			
			// Present message
			self.presentSignUpFailedMessage(error: nil, code: .wrongConfirmPassword)
			
			return
		}
		
		self.isBusyYN = true
		
		self.activityIndicatorView.startAnimating()
		self.setButtons()
		
		// Notify the delegate
		self.delegate?.signUpView(signUp: self)
		
	}
	
	
	// MARK: - signInInsteadButton Methods
	
	@IBAction func signInInsteadButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Notify the delegate
		self.delegate?.signUpView(signInInstead: self)
		
	}
	
	
	// MARK: - emailTextField Methods
	
	@IBAction func emailTextFieldTextChanged(_ sender: Any) {
		
		self.emailTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkEmailTextFieldIsEntered()) { self.emailTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}

	
	// MARK: - dateofBirthTextField Methods
	
	@IBAction func dateofBirthTextFieldEditingDidEnd(_ sender: Any) {
		
		self.dateofBirthTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkDateofBirthTextFieldIsEntered()) { self.dateofBirthTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}
	
	fileprivate func dateofBirthTextFieldDidBeginEditing() {
		
		self.dateofBirthDatePicker.maximumDate 	= Date()
		
		self.dateofBirthTextField.inputView 	= self.dateofBirthDatePicker

	}
	
	
	// MARK: - dateofBirthDatePicker Methods
	
	@objc func dateofBirthDatePickerChanged(sender: UIDatePicker) {
		
		let dateFormatter: DateFormatter 	= DateFormatter()
		dateFormatter.dateStyle 			= .medium
		
		self.dateofBirthTextField.text 		= dateFormatter.string(from: sender.date)

	}
	
	
	// MARK: - passwordTextField Methods
	
	@IBAction func passwordTextFieldTextChanged(_ sender: Any) {
		
		self.passwordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkPasswordTextFieldIsEntered()) { self.passwordTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}

	
	// MARK: - confirmPasswordTextField Methods
	
	@IBAction func confirmPasswordTextFieldTextChanged(_ sender: Any) {
		
		self.confirmPasswordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkConfirmPasswordTextFieldIsEntered()) { self.confirmPasswordTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}
	
}

// MARK: - Extension UITextFieldDelegate

extension SignUpView : UITextFieldDelegate {
	
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
		
		// confirmPasswordTextField
		if (textField == self.confirmPasswordTextField) {
			
			self.signUpButtonTapped(self)
			
			return true
		}
		
		return true
		
	}
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		
		if (textField == self.dateofBirthTextField) {
			
			self.dateofBirthTextFieldDidBeginEditing()
			
		}
		
	}

}




