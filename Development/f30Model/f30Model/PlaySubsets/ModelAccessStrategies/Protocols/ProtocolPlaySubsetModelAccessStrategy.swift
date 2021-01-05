//
//  ProtocolPlaySubsetModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel

/// Defines a class which provides a strategy for accessing the PlaySubset model data
public protocol ProtocolPlaySubsetModelAccessStrategy {
	
	// MARK: - Methods

	func select(byRelativeMember relativeMemberID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
