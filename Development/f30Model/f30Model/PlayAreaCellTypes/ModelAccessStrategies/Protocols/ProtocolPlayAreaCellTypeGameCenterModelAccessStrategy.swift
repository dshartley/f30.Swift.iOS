//
//  ProtocolPlayAreaCellTypeGameCenterModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 21/03/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import SFModel

/// Defines a class which provides a strategy for accessing the PlayAreaCellTypeGameCenter implementation of the PlayAreaCellType model data
public protocol ProtocolPlayAreaCellTypeGameCenterModelAccessStrategy {
	
	// MARK: - Methods
	
	func select(byRelativeMember relativeMemberID: String, playGameID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
