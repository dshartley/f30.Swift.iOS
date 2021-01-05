//
//  FirebaseAuthenticationStrategy.swift
//  Smart.Foundation
//
//  Created by David on 01/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity
import FirebaseAuth

/// A strategy for managing user authentication using Firebase
public class FirebaseAuthenticationStrategy: AuthenticationStrategyBase {
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	
	// MARK: - Override Methods
	
	public override func getCurrentUserId() -> String? {
		
		var result: String? = nil
		
		if Auth.auth().currentUser != nil {
			result = Auth.auth().currentUser!.uid
		}
		
		return result
	}
	
	public override func isSignedInYN() -> Bool {
		
		var result = false
		
		if Auth.auth().currentUser != nil {
			result = true
		}
		
		return result
	}
	
	public override func getCurrentUserProperties() -> UserProperties? {
		
		var userProperties: UserProperties? = nil

		// Get the current user
		if let user = Auth.auth().currentUser {
			
			userProperties = self.getUserProperties(from: user)
		}
	
		return userProperties
	}
	
	public override func signUp(withEmail email: String, password: String, oncomplete completionHandler:@escaping (UserProperties?, Error?, AuthenticationErrorCodes?) -> Void) {
		
		// Sign up
		Auth.auth().createUser(withEmail: email, password: password, completion: { (user, error) in

			// Create authentication error code
			var code: 				AuthenticationErrorCodes? = nil
			
			// Create user properties
			var userProperties: 	UserProperties? = nil
			
			if (error == nil && user != nil) {
				
				// Get user properties
				userProperties = self.getUserProperties(from: user!)
				
			} else if (error != nil) {
				
				// Get authentication error code
				code = self.getAuthenticationErrorCode(from: error!)
				
			}
			
			// Call completion handler
			completionHandler(userProperties, error, code)
		})
		
	}
	
	public override func signIn(withEmail email: String, password: String, oncomplete completionHandler:@escaping (UserProperties?, Error?, AuthenticationErrorCodes?) -> Void) {
		
		self.credentialProviderKey = .app
		
		// Sign in
		Auth.auth().signIn(withEmail: email, password: password, completion: { (user, error) in
			
			// Create authentication error code
			var code: 				AuthenticationErrorCodes? = nil
			
			// Create user properties
			var userProperties: 	UserProperties? = nil
			
			if (error == nil && user != nil) {
				
				// Get user properties
				userProperties = self.getUserProperties(from: user!)
				
			} else if (error != nil) {
				
				// Get authentication error code
				code = self.getAuthenticationErrorCode(from: error!)
				
			}
			
			// Call completion handler
			completionHandler(userProperties, error, code)
		})
		
	}
	
	public override func signIn(withCredential credential: Any, credentialProviderKey: CredentialProviderKeys, oncomplete completionHandler:@escaping (UserProperties?, Error?, AuthenticationErrorCodes?) -> Void) {
		
		self.credentialProviderKey = credentialProviderKey
		
		// Sign in
		Auth.auth().signIn(with: credential as! AuthCredential, completion: { (user, error) in
			
			// Create authentication error code
			var code: 				AuthenticationErrorCodes? = nil
			
			// Create user properties
			var userProperties: 	UserProperties? = nil
			
			if (error == nil && user != nil) {
				
				// Get user properties
				userProperties = self.getUserProperties(from: user!)
				
			} else if (error != nil) {
				
				// Get authentication error code
				code = self.getAuthenticationErrorCode(from: error!)
				
			}
			
			// Call completion handler
			completionHandler(userProperties, error, code)
		})
	}
	
	public override func signOut(oncomplete completionHandler:@escaping (Error?, AuthenticationErrorCodes?) -> Void) {
		
		do {
			// Sign out
			try Auth.auth().signOut()
			
			// Call completion handler
			completionHandler(nil, nil)
			
		} catch let error as NSError {
			
			// Get authentication error code
			let code: AuthenticationErrorCodes? = self.getAuthenticationErrorCode(from: error)
			
			// Call completion handler
			completionHandler(error, code)
		}
		
	}
	
	public override func recoverPassword(withEmail email: String, oncomplete completionHandler:@escaping (Error?, AuthenticationErrorCodes?) -> Void) {
		
		// Recover password
		Auth.auth().sendPasswordReset(withEmail: email, completion:
		{
			(error) in
			
			// Create authentication error code
			var code: AuthenticationErrorCodes? = nil

			if (error != nil) {
				
				// Get authentication error code
				code = self.getAuthenticationErrorCode(from: error!)
				
			}
			
			// Call completion handler
			completionHandler(error, code)
		})
		
	}

	public override func updatePassword(withEmail email: String, fromPassword: String, toPassword: String, oncomplete completionHandler:@escaping (Error?, AuthenticationErrorCodes?) -> Void) {
		
		guard (Auth.auth().currentUser != nil) else {
			
			// Call completion handler
			completionHandler(NSError(), nil)
			
			return
		}
		
		// Get credential
		let credential: AuthCredential = EmailAuthProvider.credential(withEmail: email, password: fromPassword)
		
		// Reauthenticate the user
		Auth.auth().currentUser!.reauthenticate(with: credential)
		{
			[weak self] (error) in
			
			if (error == nil) {
				
				// Update password
				self?.updatePassword(toPassword: toPassword, oncomplete: completionHandler)
				
			} else {
				
				// Create authentication error code
				var code: AuthenticationErrorCodes? = nil
				
				// Get authentication error code
				code = self?.getAuthenticationErrorCode(from: error!)
				
				// Call completion handler
				completionHandler(error, code)
			
			}
			
		}
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func updatePassword(toPassword: String, oncomplete completionHandler:@escaping (Error?, AuthenticationErrorCodes?) -> Void) {
		
		guard (Auth.auth().currentUser != nil) else {
			
			// Call completion handler
			completionHandler(NSError(), nil)
			
			return
		}
		
		// Update password
		Auth.auth().currentUser!.updatePassword(to: toPassword)
		{
			[weak self] (error) in
			
			// Create authentication error code
			var code: AuthenticationErrorCodes? = nil
			
			if (error != nil) {

				// Get authentication error code
				code = self?.getAuthenticationErrorCode(from: error!)
				
			}
			
			// Call completion handler
			completionHandler(error, code)
		}

	}
	
	fileprivate func getUserProperties(from user: User!) -> UserProperties {
		
		let userProperties = UserProperties()
		
		userProperties.id						= user.uid
		userProperties.email					= user.email
		userProperties.displayName				= user.displayName
		userProperties.photoURL					= user.photoURL
		userProperties.credentialProviderKey 	= self.credentialProviderKey
		
		return userProperties
	}

	fileprivate func getAuthenticationErrorCode(from error: Error) -> AuthenticationErrorCodes {
		
		var result: AuthenticationErrorCodes = .unspecified

		// Get the error code from the error
		let errorCode: AuthErrorCode = AuthErrorCode(rawValue: (error as NSError).code)!
		
		switch errorCode {
		case .invalidEmail:
			result = .invalidEmail
			
		case .emailAlreadyInUse:
			result = .emailAlreadyInUse
			
		case .weakPassword:
			result = .weakPassword
			
		case .wrongPassword:
			result = .wrongPassword
			
		case .userNotFound:
			result = .userNotFound
			
		default:
			result = .unspecified
		}
		
		return result
	}
	
}


