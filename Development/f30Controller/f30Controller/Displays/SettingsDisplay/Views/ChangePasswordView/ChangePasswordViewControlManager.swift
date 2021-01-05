//
//  ChangePasswordViewControlManager.swift
//  f30Controller
//
//  Created by David on 29/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFController
import SFSecurity
import f30View
import f30Model
import f30Core

/// Manages the PrimarySettingsView control layer
public class ChangePasswordViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:						ProtocolChangePasswordViewControlManagerDelegate?
	public var viewManager:							ChangePasswordViewViewManager?
	
	
	// MARK: - Private Stored Properties

	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: ChangePasswordViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager				= viewManager
	}


	// MARK: - Public Methods

	public func changePassword() {
		
		// Get email
		let email: 			String = AuthenticationManager.shared.currentUserProperties!.email!
		
		let fromPassword: 	String = self.viewManager!.getFromPassword()
		let toPassword: 	String = self.viewManager!.getToPassword()
		
		
		// Change password
		AuthenticationManager.shared.updatePassword(withEmail: email, fromPassword: fromPassword, toPassword: toPassword)
		
	}
	
	
	// MARK: - Override Methods
	
	public override func onUpdatePasswordSuccessful() {
		
		// Notify the delegate
		self.delegate?.changePasswordViewControlManager(changePasswordSuccessful: self)
		
	}
	
	public override func onUpdatePasswordFailed(error: Error?, code: AuthenticationErrorCodes?) {
		
		// Notify the delegate
		self.delegate?.changePasswordViewControlManager(changePasswordFailed: error, code: code)
		
	}
	
}
