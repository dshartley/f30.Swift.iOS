//
//  ProtocolPlayChallengeModelAccessStrategy.swift
//  f30Model
//
//  Created by David on 01/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Defines a class which provides a strategy for accessing the PlayChallenge model data
public protocol ProtocolPlayChallengeModelAccessStrategy {
	
	// MARK: - Methods

	func select(byID playChallengeID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
	func select(byIsActiveYN isActiveYN: Bool, relativeMemberID: String, playGameID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void)
	
}
