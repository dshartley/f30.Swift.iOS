//
//  ProtocolPlayExperienceCompleteViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Defines a delegate for a PlayExperienceCompleteView class
public protocol ProtocolPlayExperienceCompleteViewDelegate: class {
	
	// MARK: - Methods

	func playExperienceCompleteView(sender: ProtocolPlayExperienceCompleteView, closeButtonTapped wrapper: PlayExperienceWrapper, oncomplete completionhandler: ((Error?) -> Void)?)
	
}
