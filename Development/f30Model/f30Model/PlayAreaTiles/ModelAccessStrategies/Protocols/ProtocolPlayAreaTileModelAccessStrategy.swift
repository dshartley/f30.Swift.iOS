//
//  ProtocolPlayAreaTileModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel

/// Defines a class which provides a strategy for accessing the PlayAreaTile model data
public protocol ProtocolPlayAreaTileModelAccessStrategy {
	
	// MARK: - Methods

	func select(byID ID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
	func select(byCellCoordRange relativeMemberID: String, playGameID: String, playAreaID: String, fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
	func select(byIsSpecialYN isSpecialYN: Bool, relativeMemberID: String, playGameID: String, playAreaID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
