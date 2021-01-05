//
//  ProtocolPlayChallengeObjectiveCompleteViewDelegate.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Model
import f30View

/// Defines a delegate for a PlayChallengeObjectiveCompleteView class
public protocol ProtocolPlayChallengeObjectiveCompleteViewDelegate: class {
	
	// MARK: - Methods

	func playChallengeObjectiveCompleteView(sender: ProtocolPlayChallengeObjectiveCompleteView, closeButtonTapped wrapper: PlayChallengeObjectiveWrapper, oncomplete completionhandler: ((Error?) -> Void)?)
	
}
