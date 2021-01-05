//
//  ControlManagerBaseDelegate.swift
//  f30Controller
//
//  Created by David on 19/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFController
import SFSecurity
import SFNet

/// A delegate class for ControlManagerBase
public class ControlManagerBaseDelegate {

	// MARK: - Public Stored Properties
	
	// MARK: - Initializers
	
	public init() {
	}

	
	// MARK: - Public Methods
	
	// MARK: - Private Methods
	
	
}

// MARK: - Extension ProtocolControlManagerBaseDelegate

extension ControlManagerBaseDelegate: ProtocolControlManagerBaseDelegate {
	
	// MARK: - Public Methods
	
	public func controlManagerBase(loadUserPropertiesPhoto userProperties: UserProperties, oncomplete completionHandler:@escaping (Data?, UserProperties?, Error?) -> Void) {
		
		guard (userProperties.photoURL != nil) else {
			
			// Call the completion handler
			completionHandler(nil, userProperties, NSError())
			
			return
		}
		
		// Create completion handler
		let loadDataCompletionHandler: ((Data?, Error?) -> Void) =
		{
			(data, error) -> Void in

			if (data != nil && error == nil) {

				userProperties.photoData = data

				// Save to cache
				self.saveUserPropertiesPhotoToCache(userProperties: userProperties)
				
			} else {

				userProperties.photoData = nil

			}

			// Call completion handler
			completionHandler(data, userProperties, error)

		}

		// Load from cache
		self.loadUserPropertiesPhotoFromCache(userProperties: userProperties)
		
		// Check photoData loaded
		if (userProperties.photoData != nil) {
			
			// Call completion handler
			completionHandler(userProperties.photoData, userProperties, nil)
			
		} else {
			
			// Load data from url
			HTTPHelper.loadData(fromURL: userProperties.photoURL!, oncomplete: loadDataCompletionHandler)
			
		}

	}
	
	
	// MARK: - Private Methods
	
	fileprivate func loadUserPropertiesPhotoFromCache(userProperties: UserProperties) {
		
		guard (	userProperties.photoURL != nil) else { return }
		
		// Get the file name
		let fileName: 	String = userProperties.photoURL!.lastPathComponent
		
		// Load from cache
		let data: 		Data? = UserProfilesCacheManager.shared.loadImageFromCache(with: fileName)
		
		if (data != nil) {
			
			userProperties.photoData = data
			
		}
		
	}
	
	fileprivate func saveUserPropertiesPhotoToCache(userProperties: UserProperties) {
		
		guard (	userProperties.photoURL != nil
				&& userProperties.photoData != nil) else { return }
		
		// Get the file name
		let fileName: String = userProperties.photoURL!.lastPathComponent
		
		// Save to cache
		UserProfilesCacheManager.shared.saveImageToCache(imageData: userProperties.photoData!, fileName: fileName)
		
	}
	
}
