//
//  ProtocolPlayAreaTileTypeModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel

/// Defines a class which provides a strategy for accessing the PlayAreaTileType model data
public protocol ProtocolPlayAreaTileTypeModelAccessStrategy {
	
	// MARK: - Methods

	func select(byID ID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
	func select(byPlaySubsetID playSubsetID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
