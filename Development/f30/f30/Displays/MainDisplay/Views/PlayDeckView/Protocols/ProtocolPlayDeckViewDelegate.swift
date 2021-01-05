//
//  ProtocolPlayDeckViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFGridScape

/// Defines a delegate for a PlayDeckView class
public protocol ProtocolPlayDeckViewDelegate: class {
	
	// MARK: - Methods

	func playDeckView(touchesBegan sender: PlayDeckView)
	
	func playDeckView(swapCellButtonTapped sender: PlayDeckView)
	
	func playDeckView(swapTileButtonTapped sender: PlayDeckView)
	
	func playDeckView(toGridScapeManager sender: PlayDeckView) -> GridScapeManager
	
	func playDeckView(sender: PlayDeckView, didDrop cellView: ProtocolGridCellView)
	
	func playDeckView(sender: PlayDeckView, didDrop tileView: ProtocolGridTileView)
	
}
