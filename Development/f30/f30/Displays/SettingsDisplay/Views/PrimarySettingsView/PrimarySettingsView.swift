//
//  PrimarySettingsView.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import f30Model
import f30View
import f30Controller

/// A view class for a PrimarySettingsView
public class PrimarySettingsView: UIView, ProtocolPrimarySettingsView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						PrimarySettingsViewControlManager?
	fileprivate var uiimagePickerHelper: 				UIImagePickerHelper?
	fileprivate var fullNameTextFieldIsValidYN: 		Bool = false
	fileprivate var dateofBirthTextFieldIsValidYN: 		Bool = false
	fileprivate var dateofBirthDatePicker: 				UIDatePicker = UIDatePicker()
	fileprivate var isNotConnectedAlertIsShownYN:		Bool = false
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPrimarySettingsViewDelegate?
	
	@IBOutlet weak var contentView:						UIView!
	@IBOutlet weak var avatarImageFrameView: 			UIView!
	@IBOutlet weak var avatarImageView: 				UIImageView!
	@IBOutlet weak var fullNameTextField: 				UITextField!
	@IBOutlet weak var dateofBirthTextField: 			UITextField!
	@IBOutlet weak var appSettingSwitch: 				UISwitch!
	@IBOutlet weak var changePasswordButton: 			UIButton!
	
	
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
	
	// Comment; touchesBegan won't be invoked because a UIScrollView is used to frame the content. We implement a tap gesture recognizer on the UIScrollView to call endTyping.
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		self.endTyping()
	}
	
	public override func resignFirstResponder() -> Bool {
		
		self.endTyping()
		
		return super.resignFirstResponder()
	}

	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
		self.setupUIImagePickerHelper()
	}
	
	public func clearView() {
		
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
		self.controlManager 			= PrimarySettingsViewControlManager()
		
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
		let viewAccessStrategy: PrimarySettingsViewViewAccessStrategy = PrimarySettingsViewViewAccessStrategy()
		
		viewAccessStrategy.setup(avatarImageView: 			self.avatarImageView,
								 fullNameTextField: 		self.fullNameTextField,
		                         dateofBirthTextField: 		self.dateofBirthTextField,
		                         dateofBirthDatePicker: 	self.dateofBirthDatePicker,
		                         appSettingSwitch: 			self.appSettingSwitch)
		
		// Setup the view manager
		self.controlManager!.viewManager = PrimarySettingsViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PrimarySettingsView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

		self.setupAvatarImageView()
		self.controlManager!.displayAvatar()
		self.setupChangePasswordButton()
		self.setupFullNameTextField()
		self.setupDateofBirthTextField()
		self.setupDateofBirthDatePicker()
		
		self.controlManager!.displayFullName()
		self.controlManager!.displayDateofBirth()
		self.controlManager!.displayAppSetting()
		
	}
	
	fileprivate func setupAvatarImageView() {
		
		self.avatarImageFrameView.layer.cornerRadius = self.avatarImageFrameView.frame.size.width / 2
		
		let avatarBlankImage: UIImage = UIImage(named: "Avatar")!
		
		self.avatarImageView.image = avatarBlankImage
		
	}

	fileprivate func setupUIImagePickerHelper() {
		
		self.uiimagePickerHelper 			= UIImagePickerHelper()
		
		self.uiimagePickerHelper!.setup(presentedViewController: UIViewControllerHelper.getPresentedViewController(), popoverSourceView: self.avatarImageView)
		
		self.uiimagePickerHelper!.delegate 	= self
		
	}
	
	fileprivate func setupChangePasswordButton() {
		
		let allowChangePasswordYN: Bool = self.controlManager!.getAllowChangePasswordYN()
		
		self.changePasswordButton.isEnabled = allowChangePasswordYN
		
	}

	fileprivate func setupFullNameTextField() {
		
		self.fullNameTextField.delegate = self
	}
	
	fileprivate func setupDateofBirthTextField() {
		
		self.dateofBirthTextField.delegate = self
	}
	
	fileprivate func setupDateofBirthDatePicker() {
		
		self.dateofBirthDatePicker.datePickerMode 	= UIDatePickerMode.date
		self.dateofBirthDatePicker.timeZone 		= TimeZone(secondsFromGMT: 0)
		
		self.dateofBirthDatePicker.addTarget(self, action: #selector(dateofBirthDatePickerChanged(sender:)), for: .valueChanged)
		
	}
	
	fileprivate func endTyping() {

		self.fullNameTextField.resignFirstResponder()
		self.dateofBirthTextField.resignFirstResponder()
		
	}
	
	fileprivate func saveUserProfileAvatarImage(image: UIImage?) {
		
		// Display image
		self.avatarImageView.image = image!
		
		// Create completion handler
		let completionHandler: ((Error?) -> Void) =
		{
			[unowned self] (error) -> Void in
			
			if (error != nil) {

				DispatchQueue.main.async {
					
					// Display existing avatar image
					self.controlManager!.displayAvatar()
					
					self.presentOperationFailedAlert()
					
				}

			}
			
		}
		
		// Check is connected
		if (self.controlManager!.checkIsConnected()) {
			
			self.controlManager!.saveUserProfileAvatarImageFromDisplay(oncomplete: completionHandler)
			
		} else {
			
			self.presentIsNotConnectedAlert()

		}
		
	}
	
	fileprivate func saveUserProfileFullName() {
		
		// Create completion handler
		let completionHandler: ((Error?) -> Void) =
		{
			[unowned self] (error) -> Void in
			
			if (error != nil) {
				
				DispatchQueue.main.async {
					
					// Display existing full name
					self.controlManager!.displayFullName()
					
					self.presentOperationFailedAlert()
					
				}
				
			}
			
		}
		
		self.controlManager!.saveUserProfileFullNameFromDisplay(oncomplete: completionHandler)
	}
	
	fileprivate func saveUserProfileDateofBirth() {
		
		// Create completion handler
		let completionHandler: ((Error?) -> Void) =
		{
			[unowned self] (error) -> Void in
			
			if (error != nil) {
				
				DispatchQueue.main.async {
					
					// Display existing date of birth
					self.controlManager!.displayDateofBirth()
					
					self.presentOperationFailedAlert()
					
				}
				
			}
			
		}
		
		self.controlManager!.saveUserProfileDateofBirthFromDisplay(oncomplete: completionHandler)
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
	
	fileprivate func checkFullNameTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check fullNameTextField
		let fullNameTextFieldLength: Int = self.fullNameTextField.text?.count ?? 0
		if (fullNameTextFieldLength == 0) { result = false }
		
		return result
		
	}
	
	fileprivate func checkDateofBirthTextFieldIsEntered() -> Bool {
		
		var result: Bool = true
		
		// Check dateofBirthTextField
		let dateofBirthTextFieldLength: Int = self.dateofBirthTextField.text?.count ?? 0
		if (dateofBirthTextFieldLength == 0) { result = false }
		
		return result
		
	}
	
	
	// MARK: - scrollView TapGestureRecognizer Methods
	
	@IBAction func scrollViewTapped(_ sender: Any) {
		
		self.endTyping()
		
	}
	
	
	// MARK: - avatarImageView TapGestureRecognizer Methods
	
	@IBAction func avatarImageViewTapped(_ sender: Any) {
		
		if (!self.controlManager!.checkIsConnected()) {
			
			self.presentIsNotConnectedAlert()
			
			return
		}
		
		self.uiimagePickerHelper!.pick()
		
	}
	
	
	// MARK: - fullNameTextField Methods
	
	@IBAction func fullNameTextFieldEditingDidEnd(_ sender: Any) {

		// Check is changed
		guard (self.controlManager!.checkFullNameIsChanged()) else { return }
		
		// Check is connected
		guard (self.controlManager!.checkIsConnected()) else {

			// Display current full name
			self.controlManager!.displayFullName()
			
			self.presentIsNotConnectedAlert()

			return
		}

		self.fullNameTextFieldIsValidYN = true

		// Validations
		if (!self.checkFullNameTextFieldIsEntered()) { self.fullNameTextFieldIsValidYN = false }

		if (self.fullNameTextFieldIsValidYN) {

			self.saveUserProfileFullName()
		}
		
	}
	
	
	// MARK: - dateofBirthTextField Methods
	
	@IBAction func dateofBirthTextFieldEditingDidEnd(_ sender: Any) {
		
		// Check is changed
		guard (self.controlManager!.checkDateofBirthIsChanged()) else { return }
		
		if (!self.controlManager!.checkIsConnected()) {

			// Display current date of birth
			self.controlManager!.displayDateofBirth()

			self.presentIsNotConnectedAlert()

			return
		}
		
		self.dateofBirthTextFieldIsValidYN = true
		
		// Validations
		if (!self.checkDateofBirthTextFieldIsEntered()) { self.dateofBirthTextFieldIsValidYN = false }
		
		if (self.dateofBirthTextFieldIsValidYN) {
			
			self.saveUserProfileDateofBirth()
		}
	}
	
	fileprivate func dateofBirthTextFieldDidBeginEditing() {
		
		self.dateofBirthDatePicker.maximumDate 	= Date()
		
		self.dateofBirthTextField.inputView 	= self.dateofBirthDatePicker
		
	}
	
	
	// MARK: - dateofBirthDatePicker Methods
	
	@objc func dateofBirthDatePickerChanged(sender: UIDatePicker) {
		
		let dateFormatter: 					DateFormatter = DateFormatter()
		dateFormatter.dateStyle 			= .medium
		dateFormatter.timeZone 				= TimeZone(secondsFromGMT: 0)
		
		self.dateofBirthTextField.text 		= dateFormatter.string(from: sender.date)
		
	}
	
	
	// MARK: - appSettingSwitch Methods
	
	@IBAction func appSettingSwitchValueChanged(_ sender: Any) {
		
		self.endTyping()
		
		self.controlManager!.saveAppSettingFromDisplay()
	
	}
	
	
	// MARK: - changePasswordButton Methods
	
	@IBAction func changePasswordButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Notify the delegate
		self.delegate?.primarySettingsView(changePasswordButtonTapped: self)

	}
	
}

// MARK: - Extension ProtocolPrimarySettingsViewControlManagerDelegate

extension PrimarySettingsView: ProtocolPrimarySettingsViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolUIImagePickerHelperDelegate

extension PrimarySettingsView: ProtocolUIImagePickerHelperDelegate {
	
	// MARK: - Public Methods
	
	public func uiimagePickerHelper(didCancel: UIImagePickerHelper) {

	}
	
	public func uiimagePickerHelper(didFinishPickingMediaWithInfo info: [String : Any]) {

		// Get image
		let image: UIImage? = info[UIImagePickerControllerOriginalImage] as? UIImage
		
		self.saveUserProfileAvatarImage(image: image)
		
		// Notify the delegate
		self.delegate?.primarySettingsView(avatarImageChanged: self)
		
	}

}

// MARK: - Extension UITextFieldDelegate

extension PrimarySettingsView : UITextFieldDelegate {
	
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		// Get maxLength
		var maxLength: 		Int = Int.max
		
		if (textField == self.fullNameTextField) { maxLength = 50 }		// fullNameTextField
		
		let result: 		Bool = UITextFieldHelper.checkMaxLength(textField: textField, shouldChangeCharactersIn: range, replacementString: string, maxLength: maxLength)
		
		return result
	}
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		
		if (textField == self.dateofBirthTextField) {
			
			self.dateofBirthTextFieldDidBeginEditing()
			
		}
		
	}
	
	public func textFieldShouldReturn(_ textField: UITextField) -> Bool {

		// Try to find next responder
		if let nextField = self.viewWithTag(textField.tag + 1) as? UITextField {

			nextField.becomeFirstResponder()

		} else {

			textField.resignFirstResponder()

		}

		return true

	}
	
}


