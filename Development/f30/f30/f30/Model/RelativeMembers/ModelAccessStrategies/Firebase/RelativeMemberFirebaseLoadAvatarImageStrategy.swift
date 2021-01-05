//
//  RelativeMemberFirebaseLoadAvatarImageStrategy.swift
//  f30
//
//  Created by David on 10/05/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFSocial
import FirebaseDatabase
import FirebaseStorage

/// A strategy for loading the RelativeMember avatarImageData using Firebase
public class RelativeMemberFirebaseLoadAvatarImageStrategy {

	// MARK: - Public Stored Properties
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods


	// MARK: - Private Methods
	
}


// MARK: - Extension ProtocolRelativeMemberLoadAvatarImageStrategy

extension RelativeMemberFirebaseLoadAvatarImageStrategy: ProtocolRelativeMemberLoadAvatarImageStrategy {
	
	// MARK: - Public Methods
	
	public func loadAvatarImageData(item: RelativeMemberWrapper, oncomplete completionHandler: @escaping (RelativeMemberWrapper, Data?, Error?) -> Void) {
		
		guard (!item.avatarImageFileName.isEmpty) else {
			
			// Call completion handler
			completionHandler(item, nil, NSError())
			
			return
		}
		
		let fileName: 			String = item.avatarImageFileName
		
		// Create reference
		let storageReference 	= Storage.storage().reference().child(fileName)
		
		let maxSize: 			Int64 = 1 * 1024 * 1024 	// 1MB (1 * 1024 * 1024 bytes)
		
		storageReference.getData(maxSize: maxSize)
		{
			(data, error) in
			
			if (data != nil && error == nil) {
				
				item.avatarImageData = data
				
				// Call the completion handler
				completionHandler(item, data, nil)
				
			} else {
				
				// Call the completion handler
				completionHandler(item, nil, error)
				
			}
		}
		
	}

}
