//
//  ProtocolPlayAreaPathModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFGridScape

/// Defines a class which provides a strategy for accessing the PlayAreaPath model data
public protocol ProtocolPlayAreaPathModelAccessStrategy {
	
	// MARK: - Methods

	func select(byFromCellCoord fromCellCoord: CellCoord, toCellCoord: CellCoord, playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, playGameID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)

}
