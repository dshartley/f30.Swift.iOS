//
//  ProtocolPlayAreaTokenModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel

/// Defines a class which provides a strategy for accessing the PlayAreaToken model data
public protocol ProtocolPlayAreaTokenModelAccessStrategy {
	
	// MARK: - Methods

	func select(byPlayGameID playGameID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
