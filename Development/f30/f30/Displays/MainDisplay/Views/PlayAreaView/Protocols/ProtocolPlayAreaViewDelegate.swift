//
//  ProtocolPlayAreaViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30View
import SFGridScape

/// Defines a delegate for a PlayAreaView class
public protocol ProtocolPlayAreaViewDelegate: class {
	
	// MARK: - Methods

	func playAreaView(scrollingBegan sender: PlayAreaView)
	
	func playAreaView(touchesBegan sender: PlayAreaView, on view: UIView?)
	
	func playAreaView(tapped cellView: ProtocolGridCellView, at indicatedPoint: CGPoint)
	
	func playAreaView(tapped tileView: ProtocolGridTileView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint)

	func playAreaView(tapped tokenView: ProtocolGridTokenView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint)
	
}
