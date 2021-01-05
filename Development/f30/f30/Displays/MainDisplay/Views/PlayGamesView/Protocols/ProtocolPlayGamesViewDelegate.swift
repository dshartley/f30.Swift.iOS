//
//  ProtocolPlayGamesViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Defines a delegate for a PlayGamesView class
public protocol ProtocolPlayGamesViewDelegate: class {
	
	// MARK: - Methods

	func playGamesView(isNotConnected error: Error?)
	
	func playGamesView(operationFailed error: Error?)
	
	func playGamesView(presentPlayGameEditView sender: ProtocolPlayGamesView, for wrapper: PlayGameWrapper)
	
	func playGamesView(sender: ProtocolPlayGamesView, playGameSelected wrapper: PlayGameWrapper)
	
	func playGamesView(sender: ProtocolPlayGamesView, playGameDeleted wrapper: PlayGameWrapper, activePlayGame: PlayGameWrapper)
	
}
