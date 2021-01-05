//
//  ProtocolPlayMoveModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Defines a class which provides a strategy for accessing the PlayMove model data
public protocol ProtocolPlayMoveModelAccessStrategy {
	
	// MARK: - Methods
	
	func select(byPlayTileID playTileID: String, playGameID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
	func select(byPlayTokenID playTokenID: String, playGameID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)

	func select(byPlayTokenID playTokenID: String, playGameID: String, playAreaPathData: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
