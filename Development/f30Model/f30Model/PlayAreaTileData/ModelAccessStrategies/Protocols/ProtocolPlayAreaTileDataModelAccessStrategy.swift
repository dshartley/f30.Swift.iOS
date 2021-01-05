//
//  ProtocolPlayAreaTileDataModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel

/// Defines a class which provides a strategy for accessing the PlayAreaTileData model data
public protocol ProtocolPlayAreaTileDataModelAccessStrategy {
	
	// MARK: - Methods

	func select(byPlayAreaTileID playAreaTileID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
