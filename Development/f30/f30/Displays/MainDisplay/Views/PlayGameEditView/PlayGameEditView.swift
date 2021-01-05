//
//  PlayGameEditView.swift
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

/// A view class for a PlayGameEditView
public class PlayGameEditView: UIView, ProtocolPlayGameEditView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:						PlayGameEditViewControlManager?
	fileprivate var isNotConnectedAlertIsShownYN:		Bool = false
	fileprivate var playGameWrapper:					PlayGameWrapper? = nil
	fileprivate var selectedLanguageID:					String = "1"
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:							ProtocolPlayGameEditViewDelegate?
	
	@IBOutlet weak var contentView:						UIView!
	@IBOutlet weak var gameImageImageView: 				UIImageView!
	@IBOutlet weak var gameImageContainerView: 			UIView!
	@IBOutlet weak var gameNameTextField: 				UITextField!
	@IBOutlet weak var languageFlagImageContainerView: 	UIView!
	@IBOutlet weak var languageFlagImageImageView: 		UIImageView!
	@IBOutlet weak var languageNameLabel: 				UILabel!
	
	
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
	
	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
	}
	
	public func clearView() {
		
		self.gameNameTextField.text 					= ""
		self.gameImageContainerView.backgroundColor 	= UIColor.white
		
	}

	public func set(wrapper: PlayGameWrapper) {
	
		self.playGameWrapper 		= wrapper
		
		self.displayGameName()
		self.displayGameImage()
		
		// TODO: Change to playSubsetID
		self.selectedLanguageID 	= self.playGameWrapper!.playSubsetID
		self.displaySelectedLanguage(languageID: self.playGameWrapper!.playSubsetID)
		
	}
	
	public func set(languageID: String) {
		
		self.selectedLanguageID = languageID
		
		self.displaySelectedLanguage(languageID: languageID)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= PlayGameEditViewControlManager()
		
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
		let viewAccessStrategy: PlayGameEditViewViewAccessStrategy = PlayGameEditViewViewAccessStrategy()
		
		viewAccessStrategy.setup(gameImageImageView: self.gameImageImageView, gameNameTextField: self.gameNameTextField, languageFlagImageImageView: self.languageFlagImageImageView, languageNameLabel: self.languageNameLabel)
		
		// Setup the view manager
		self.controlManager!.viewManager = PlayGameEditViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("PlayGameEditView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

		self.setupGameImageView()
		self.setupGameNameTextField()
		self.setupLanguageFlagImageView()
		
	}

	fileprivate func setupGameImageView() {
		
		// gameImageContainerView
		UIViewHelper.roundCorners(view: self.gameImageContainerView, corners: UIRectCorner.allCorners, radius: 10.0)
		
	}

	fileprivate func setupGameNameTextField() {
		
		self.gameNameTextField.delegate = self
	}
	
	fileprivate func setupLanguageFlagImageView() {
		
		// languageFlagImageContainerView
		UIViewHelper.roundCorners(view: self.languageFlagImageContainerView, corners: UIRectCorner.allCorners, radius: 5.0)
		
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
	
	fileprivate func endTyping() {
		
		self.gameNameTextField.resignFirstResponder()
		
	}
	
	fileprivate func displaySelectedLanguage(languageID: String) {
	
		self.languageFlagImageImageView.image 		= nil
		
		// Get PlaySubsetWrapper
		let psw: 									PlaySubsetWrapper? = PlayWrapper.current?.playSubsets?[languageID]
		
		guard (psw != nil) else { return }
		
		self.languageNameLabel.text 				= psw!.name
		
		if (psw!.thumbnailImageData != nil) {
			
			self.languageFlagImageImageView.image 	= UIImage(data: psw!.thumbnailImageData!)
			
		}
		
	}

	fileprivate func getSelectedLanguage() {
		
		self.playGameWrapper!.playSubsetID = "\(self.selectedLanguageID)"
		
	}
	
	fileprivate func displayGameImage() {
		
		var backgroundColor: UIColor? = nil
		
		// Get backgroundColor
		//if (self.playGameWrapper!.imageBackgroundColor.count > 0) {
		//
	//		backgroundColor = UIColorHelper.toColor(hex: self.playGameWrapper!.imageBackgroundColor)
		//
		//}
		
		if (backgroundColor == nil) {
			
			// Get random color
			backgroundColor = UIColorHelper.randomColor()
			
		}
		
		self.gameImageContainerView.backgroundColor = backgroundColor
		
	}
	
	fileprivate func getGameImage() {
		
		// Set in playGameWrapper
		//self.playGameWrapper!.imageBackgroundColor = UIColorHelper.toHex(color: self.gameImageContainerView.backgroundColor!)
		
	}
	
	fileprivate func displayGameName() {
		
		// gameNameLabel
		self.gameNameTextField.text	= self.playGameWrapper!.name
		
	}
	
	fileprivate func getGameName() {
		
		self.playGameWrapper!.name = self.gameNameTextField.text ?? ""
		
	}

	fileprivate func updatePlayGameWrapper() {
		
		self.getGameName()
		self.getGameImage()
		self.getSelectedLanguage()
		
	}
	
	
	// MARK: - backButton TapGestureRecogniser Methods
	
	@IBAction func backButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Notify the delegate
		self.delegate!.playGameEditView(sender: self, backButtonTapped: self.playGameWrapper!)
		
	}
	
	
	// MARK: - doneButton Methods
	
	@IBAction func doneButtonTapped(_ sender: Any) {
		
		self.endTyping()
		
		self.updatePlayGameWrapper()
		
		// Notify the delegate
		self.delegate!.playGameEditView(sender: self, doneButtonTapped: self.playGameWrapper!)
		
	}
	
	
	// MARK: - languageNameLabel TapGestureRecogniser Methods
	
	@IBAction func languageNameLabelTapped(_ sender: Any) {
		
		self.endTyping()
		
		// Notify the delegate
		self.delegate!.playGameEditView(sender: self, willSelectLanguage: self.playGameWrapper!, source: self.languageNameLabel)

	}
	
	
	// MARK: - gameImageImageView TapGestureRecogniser Methods
	
	@IBAction func gameImageImageViewTapped(_ sender: Any) {
		
		self.endTyping()
		
	}
	
}


// MARK: - Extension ProtocolPlayGameEditViewControlManagerDelegate

extension PlayGameEditView: ProtocolPlayGameEditViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}


// MARK: - Extension UITextFieldDelegate

extension PlayGameEditView : UITextFieldDelegate {
	
	public func textField(_ textField: UITextField, shouldChangeCharactersIn range: NSRange, replacementString string: String) -> Bool {
		
		// Get maxLength
		var maxLength: 		Int = Int.max
		
		if (textField == self.gameNameTextField) { maxLength = 50 }		// gameNameTextField
		
		let result: 		Bool = UITextFieldHelper.checkMaxLength(textField: textField, shouldChangeCharactersIn: range, replacementString: string, maxLength: maxLength)
		
		return result
		
	}
	
	public func textFieldDidBeginEditing(_ textField: UITextField) {
		
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

