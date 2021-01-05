//
//  PlayAreaTileWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape
import SFModel

/// A wrapper for a PlayAreaTile model item
public class PlayAreaTileWrapper: TileWrapperBase {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var relativeMemberID:					String = ""
	public var playGameID:							String = ""
	public var status: 								ModelItemStatusTypes = .new
	public fileprivate(set) var playAreaTileData:	PlayAreaTileDataWrapper? = nil
	
	
	// MARK: - Initializers
	
	
	// MARK: - Public Methods
	
	public func set(playAreaTileDataWrapper: PlayAreaTileDataWrapper) {
		
		self.playAreaTileData 				= playAreaTileDataWrapper
		
		// Set playGameID
		self.playAreaTileData!.playGameID 	= self.playGameID
		
	}
	
}
