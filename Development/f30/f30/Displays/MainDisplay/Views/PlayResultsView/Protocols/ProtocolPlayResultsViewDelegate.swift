//
//  ProtocolPlayResultsViewDelegate.swift
//  f30
//
//  Created by David on 29/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Core

/// Defines a delegate for a PlayResultsView class
public protocol ProtocolPlayResultsViewDelegate {

	// MARK: - Methods
	
	func playResultsView(willDismiss sender: PlayResultsView)
	
	func playResultsView(didDismiss sender: PlayResultsView)
	
}
