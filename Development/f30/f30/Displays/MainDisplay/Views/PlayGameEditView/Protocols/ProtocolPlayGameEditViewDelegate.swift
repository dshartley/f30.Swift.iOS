//
//  ProtocolPlayGameEditViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Defines a delegate for a PlayGameEditView class
public protocol ProtocolPlayGameEditViewDelegate: class {
	
	// MARK: - Methods

	func playGameEditView(sender: ProtocolPlayGameEditView, backButtonTapped wrapper: PlayGameWrapper)
	
	func playGameEditView(sender: ProtocolPlayGameEditView, doneButtonTapped wrapper: PlayGameWrapper)

	func playGameEditView(sender: ProtocolPlayGameEditView, willSelectLanguage wrapper: PlayGameWrapper, source: UIView)
	
}
