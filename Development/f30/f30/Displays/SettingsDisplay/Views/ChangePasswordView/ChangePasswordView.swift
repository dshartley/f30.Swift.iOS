//
//  ChangePasswordView.swift
//  f30
//
//  Created by David on 29/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import SFSecurity
import f30Model
import f30View
import f30Controller

/// A view class for a ChangePasswordView
public class ChangePasswordView: UIView, ProtocolChangePasswordView {

	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:							ChangePasswordViewControlManager?
	fileprivate var fromPasswordTextFieldIsValidYN: 		Bool = false
	fileprivate var toPasswordTextFieldIsValidYN: 			Bool = false
	fileprivate var confirmToPasswordTextFieldIsValidYN: 	Bool = false
	fileprivate var isBusyYN: 								Bool = false
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:								ProtocolChangePasswordViewDelegate?
	
	@IBOutlet weak var contentView: 						UIView!
	@IBOutlet weak var dialogView: 							UIView!
	@IBOutlet weak var activityIndicatorView: 				UIActivityIndicatorView!
	@IBOutlet weak var fromPasswordTextField: 				UITextField!
	@IBOutlet weak var toPasswordTextField: 				UITextField!
	@IBOutlet weak var confirmToPasswordTextField: 			UITextField!
	@IBOutlet weak var doneButton: 							UIButton!
	@IBOutlet weak var cancelButton: 						UIButton!
	
	
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
	
	public func clearView() {

		self.fromPasswordTextField.text 			= nil
		self.toPasswordTextField.text 				= nil
		self.confirmToPasswordTextField.text 		= nil
		
		self.fromPasswordTextFieldIsValidYN 		= false
		self.toPasswordTextFieldIsValidYN 			= false
		self.confirmToPasswordTextFieldIsValidYN 	= false
		
	}
	
	public func handleTouchesBeganInside(_ point: CGPoint, with event: UIEvent?) {
		
		// Check view is displayed
		guard (!isHidden && alpha != 0) else { return }
		
		// Handle cancelButton touches
		if (self.cancelButton.frame.contains(point)) {
			
			self.cancelButton.sendActions(for: .touchUpInside)
			
		}
		
	}
	
	public func keyboardWillShow(_ sender:Notification) {
		
		self.layoutIfNeeded()
		
		UIView.animate(withDuration: 0.4, animations: {
			
			// TODO:
			
			self.layoutIfNeeded()
		})
		
	}
	
	public func keyboardWillHide(_ sender:Notification) {
		
		self.layoutIfNeeded()
		
		UIView.animate(withDuration: 0.4, animations: {
			
			// TODO:
			
			self.layoutIfNeeded()
		})
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= ChangePasswordViewControlManager()
		
		self.controlManager!.delegate 	= self
		
		// Setup authentication
		self.controlManager!.setupAuthentication()
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		//ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: ChangePasswordViewViewAccessStrategy = ChangePasswordViewViewAccessStrategy()

		viewAccessStrategy.setup(toPasswordTextField: 	self.toPasswordTextField,
								 fromPasswordTextField: self.fromPasswordTextField)

		// Setup the view manager
		self.controlManager!.viewManager = ChangePasswordViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("ChangePasswordView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
		
		self.setButtons()
		
		self.setupDialogView()
		self.setupFromPasswordTextField()
		self.setupToPasswordTextField()
		self.setupConfirmToPasswordTextField()
		self.setupActivityIndicatorView()
		
	}
	
	fileprivate func setupDialogView() {
		
		self.dialogView.layer.cornerRadius 		= 10.0;
		self.dialogView.layer.borderWidth 		= 1.0;
		self.dialogView.layer.borderColor 		= UIColor.clear.cgColor
		self.dialogView.layer.masksToBounds 	= true;
	}
	
	fileprivate func setupFromPasswordTextField() {
		
		self.fromPasswordTextField.delegate = self
	}

	fileprivate func setupToPasswordTextField() {
		
		self.toPasswordTextField.delegate = self
	}
	
	fileprivate func setupConfirmToPasswordTextField() {
		
		self.confirmToPasswordTextField.delegate = self
	}
	
	fileprivate func setupActivityIndicatorView() {
		
		self.activityIndicatorView.stopAnimating()
		
	}
	
	fileprivate func setButtons() {
		
		let isValidYN: Bool = 	(self.fromPasswordTextFieldIsValidYN &&
								self.toPasswordTextFieldIsValidYN &&
								self.confirmToPasswordTextFieldIsValidYN)
		
		self.doneButton.isEnabled 	= isValidYN && !self.isBusyYN

	}
	
	fileprivate func checkFromPasswordTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check fromPasswordTextField
		let fromPasswordTextField: Int = self.fromPasswordTextField.text?.count ?? 0
		if (fromPasswordTextField == 0) { result = false }
		
		return result
		
	}

	fileprivate func checkToPasswordTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check toPasswordTextField
		let toPasswordTextField: Int = self.toPasswordTextField.text?.count ?? 0
		if (toPasswordTextField == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func checkConfirmToPasswordTextFieldIsCorrect() -> Bool {
		
		var result: Bool = true
		
		// Check confirmToPasswordTextField
		if (self.confirmToPasswordTextField.text == nil ||
			self.confirmToPasswordTextField.text != self.toPasswordTextField.text) { result = false }
		
		return result
		
	}
	
	fileprivate func checkConfirmToPasswordTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check confirmToPasswordTextField
		let confirmToPasswordTextField: Int = self.confirmToPasswordTextField.text?.count ?? 0
		if (confirmToPasswordTextField == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func presentChangePasswordFailedMessage(error: 	Error?,
												code: 	AuthenticationErrorCodes?) {
		
		// Get alert title and message
		var alertTitle: 	String = ""
		var alertMessage: 	String = ""
		
		
		let code = code ?? .unspecified
		
		switch code {
		case .wrongPassword:
			alertTitle 		= NSLocalizedString("AlertTitleChangePasswordWrongPassword", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageChangePasswordWrongPassword", comment: "")
			
		case .weakPassword:
			alertTitle 		= NSLocalizedString("AlertTitleChangePasswordWeakPassword", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageChangePasswordWeakPassword", comment: "")
			
		case .wrongConfirmPassword:
			alertTitle 		= NSLocalizedString("AlertTitleChangePasswordWrongConfirmPassword", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageChangePasswordWrongConfirmPassword", comment: "")
			
		case .notConnected:
			alertTitle 		= NSLocalizedString("AlertTitleChangePasswordNotConnected", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageChangePasswordNotConnected", comment: "")
			
		default:
			alertTitle 		= NSLocalizedString("AlertTitleChangePasswordFailedUnspecified", comment: "")
			alertMessage 	= NSLocalizedString("AlertMessageChangePasswordFailedUnspecified", comment: "")
			
		}
		
		self.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: nil)
		
	}
	
	fileprivate func presentChangePasswordSuccessfulMessage(oncomplete completionHandler:((UIAlertAction?) -> Void)?) {
		
		// Get alert title and message
		let alertTitle: 	String = NSLocalizedString("AlertTitleChangePasswordSuccessful", comment: "")
		let alertMessage: 	String = NSLocalizedString("AlertMessageChangePasswordSuccessful", comment: "")
		
		self.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: completionHandler)
		
	}
	
	fileprivate func endTyping() {
		
		self.fromPasswordTextField.resignFirstResponder()
		self.toPasswordTextField.resignFirstResponder()
		self.confirmToPasswordTextField.resignFirstResponder()
		
	}
	
	fileprivate func presentAlert(alertTitle: String, alertMessage: String, oncomplete completionHandler:((UIAlertAction?) -> Void)?) {
		
		// Create alertController
		let alertController: 	UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
		
		// Create 'OK' action
		let okAlertActionTitle: String = NSLocalizedString("AlertActionTitleOk", comment: "")
		let alertAction:		UIAlertAction = UIAlertAction(title: okAlertActionTitle, style: .default, handler: completionHandler)
		alertController.addAction(alertAction)
		
		// Present alertController
		UIViewControllerHelper.getPresentedViewController().present(alertController, animated: true, completion: nil)
		
	}

	fileprivate func onChangePasswordSuccessful() {
		
		// Create completion handler
		let completionHandler: ((UIAlertAction?) -> Void) =
		{
			[unowned self] (action) -> Void in
			
			// Notify the delegate
			self.delegate?.changePasswordView(doneButtonTapped: self)
			
		}
		
		self.isBusyYN = false
		
		self.activityIndicatorView.stopAnimating()
		
		self.setButtons()
		
		// Present message
		self.presentChangePasswordSuccessfulMessage(oncomplete: completionHandler)

	}
	
	fileprivate func onChangePasswordFailed(error:	Error?,
									 code: 	AuthenticationErrorCodes?) {
		
		self.isBusyYN = false
		
		self.activityIndicatorView.stopAnimating()
		
		self.setButtons()
		
		// DEBUG:
		//print(error?.localizedDescription)
		
		// Present message
		self.presentChangePasswordFailedMessage(error: error, code: code)
		
	}
	
	
	// MARK: - fromPasswordTextField Methods
	
	@IBAction func fromPasswordTextFieldTextChanged(_ sender: Any) {
		
		self.fromPasswordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkFromPasswordTextFieldIsEntered()) { self.fromPasswordTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}
	
	
	// MARK: - toPasswordTextField Methods
	
	@IBAction func toPasswordTextFieldTextChanged(_ sender: Any) {
		
		self.toPasswordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkToPasswordTextFieldIsEntered()) { self.toPasswordTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}
	
	
	// MARK: - confirmToPasswordTextField Methods
	
	@IBAction func confirmToPasswordTextFieldTextChanged(_ sender: Any) {
		
		self.confirmToPasswordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkConfirmToPasswordTextFieldIsEntered()) { self.confirmToPasswordTextFieldIsValidYN = false }
		
		self.setButtons()
		
	}

	
	// MARK: - cancelButton Methods
	
	@IBAction func cancelButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Notify the delegate
		self.delegate?.changePasswordView(cancelButtonTapped: self)
		
	}
	
	
	// MARK: - doneButton Methods
	
	@IBAction func doneButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		self.confirmToPasswordTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkConfirmToPasswordTextFieldIsCorrect()) {
			
			self.confirmToPasswordTextFieldIsValidYN = false
			self.setButtons()
			
			// Present message
			self.presentChangePasswordFailedMessage(error: nil, code: .wrongConfirmPassword)
			
			return
		}
		
		self.isBusyYN = true
		
		self.activityIndicatorView.startAnimating()
		self.setButtons()
		
		// Change password
		self.controlManager!.changePassword()
		
	}
	
}

// MARK: - Extension ProtocolChangePasswordViewControlManagerDelegate

extension ChangePasswordView: ProtocolChangePasswordViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
	public func changePasswordViewControlManager(changePasswordSuccessful sender: ChangePasswordViewControlManager) {
		
		self.onChangePasswordSuccessful()
		
	}
	
	public func changePasswordViewControlManager(changePasswordFailed error: Error?,
												 code: 	AuthenticationErrorCodes?) {
		
		self.onChangePasswordFailed(error: error, code: code)
		
	}
	
}

// MARK: - Extension UITextFieldDelegate

extension ChangePasswordView : UITextFieldDelegate {
	
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		// Get maxLength
		var maxLength: 		Int = Int.max
		
		if (textField == self.fromPasswordTextField) 			{ maxLength = 50 }		// fromPasswordTextField
		else if (textField == self.toPasswordTextField) 		{ maxLength = 50 }		// toPasswordTextField
		else if (textField == self.confirmToPasswordTextField) 	{ maxLength = 50 }		// confirmToPasswordTextField
		
		let result: 		Bool = UITextFieldHelper.checkMaxLength(textField: textField, shouldChangeCharactersIn: range, replacementString: string, maxLength: maxLength)
		
		return result
	}
	
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {
		
		// Try to find next responder
		if let nextField = self.viewWithTag(textField.tag + 1) as? UITextField {
			
			nextField.becomeFirstResponder()
			
		} else {
			
			textField.resignFirstResponder()
			
		}
		
		// confirmToPasswordTextField
		if (textField == self.confirmToPasswordTextField) {
			
			self.doneButtonTapped(self)
			
			return true
		}
		
		return true
		
	}
	
}
