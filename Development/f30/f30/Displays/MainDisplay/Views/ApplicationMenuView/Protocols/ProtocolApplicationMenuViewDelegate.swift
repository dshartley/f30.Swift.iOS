//
//  ProtocolApplicationMenuViewDelegate.swift
//  f30
//
//  Created by David on 29/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Core

/// Defines a delegate for a ApplicationMenuView class
public protocol ProtocolApplicationMenuViewDelegate {

	// MARK: - Methods
	
	func applicationMenuView(willDismiss sender: ApplicationMenuView)
	
	func applicationMenuView(didDismiss sender: ApplicationMenuView)
	
	func applicationMenuView(settingsButtonTapped sender: ApplicationMenuView)
	
	func applicationMenuView(signOutButtonTapped sender: ApplicationMenuView)
	
}
