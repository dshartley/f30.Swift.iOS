//
//  FacebookCredentialProvider.swift
//  Smart.Foundation
//
//  Created by David on 01/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSecurity
import FirebaseAuth
import FBSDKLoginKit
import FBSDKCoreKit

/// Specifies Facebook credential attribute keys
public enum FacebookCredentialAttributeKeys : String {
	case accessToken
}

/// A strategy for providing a credential using Facebook
public class FacebookCredentialProvider: NSObject {

	// MARK: - Private Stored Properties
	
	fileprivate var signInCompletionHandler: ((_ attributes: [String : Any]?, Error?, AuthenticationErrorCodes?) -> Void)?
	
	
	// MARK: - Initializers
	
	public override init() {
	}
	
	
	// MARK: - Public Methods
	
	public func getSignInButton(signInCompletion completionHandler:@escaping (_ attributes: [String : Any]?, Error?, AuthenticationErrorCodes?) -> Void) -> UIView {
		
		// Keep the completion handler
		self.signInCompletionHandler	= completionHandler
		
		// Create the button
		let button						= FBSDKLoginButton()
		button.readPermissions 			= ["public_profile"]
		
		// Set delegate
		button.delegate = self

		return button
	}
	
}

// MARK: - Extension ProtocolCredentialProvider

extension FacebookCredentialProvider: ProtocolCredentialProvider {
	
	// MARK: - Public Methods
	
	public func getCredential(attributes: [String : Any]?, oncomplete completionHandler:@escaping (_ credential: Any?, Error?) -> Void) {
		
		// Get accessToken
		let accessToken	= attributes?[FacebookCredentialAttributeKeys.accessToken.rawValue] as? FBSDKAccessToken
		
		if (accessToken != nil) {
			
			// Get the credential
			let credential = FacebookAuthProvider.credential(withAccessToken: accessToken!.tokenString)
			
			// Call completion handler
			completionHandler(credential, nil)
		}
	}
	
}

// MARK: - Extension LoginButtonDelegate

extension FacebookCredentialProvider: FBSDKLoginButtonDelegate {

	// MARK: - Public Methods
	
	public func loginButton(_ loginButton: FBSDKLoginButton!, didCompleteWith result: FBSDKLoginManagerLoginResult!, error: Error!) {
		
		// Create attributes
		var attributes = [String : Any]()
		
		if (error != nil) {
		
			// Create authentication error code
			let code: AuthenticationErrorCodes? = .unspecified
			
			// Call completion handler
			self.signInCompletionHandler?(attributes, error, code)
			
		} else {
			
			attributes[FacebookCredentialAttributeKeys.accessToken.rawValue] = FBSDKAccessToken.current()
			
			// Call completion handler
			self.signInCompletionHandler?(attributes, nil, nil)
			
		}
		
	}
	
	public func loginButtonDidLogOut(_ loginButton: FBSDKLoginButton) {
		
		// Not implemented
	}

}
