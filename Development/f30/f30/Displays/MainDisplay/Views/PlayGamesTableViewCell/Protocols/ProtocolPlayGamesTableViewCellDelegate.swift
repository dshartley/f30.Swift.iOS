//
//  ProtocolPlayGamesTableViewCellDelegate.swift
//  f30
//
//  Created by David on 24/03/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import f30Model

/// Defines a delegate for a PlayGamesTableViewCell class
public protocol ProtocolPlayGamesTableViewCellDelegate {

	// MARK: - Methods
	
	func playGamesTableViewCell(cell: PlayGamesTableViewCell, itemTapped wrapper: PlayGameWrapper)
	
	func playGamesTableViewCell(cell: PlayGamesTableViewCell, editButtonTapped wrapper: PlayGameWrapper)
	
	func playGamesTableViewCell(cell: PlayGamesTableViewCell, deleteButtonTapped wrapper: PlayGameWrapper)
	
}
