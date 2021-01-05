//
//  ProtocolPlayChallengeCompleteViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Defines a delegate for a PlayChallengeCompleteView class
public protocol ProtocolPlayChallengeCompleteViewDelegate: class {
	
	// MARK: - Methods

	func playChallengeCompleteView(sender: ProtocolPlayChallengeCompleteView, closeButtonTapped wrapper: PlayChallengeWrapper, oncomplete completionhandler: ((Error?) -> Void)?)
	
}
