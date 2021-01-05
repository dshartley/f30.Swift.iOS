//
//  ProtocolPlayChallengeObjectiveCompleteView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core
import f30Model

/// Defines a class which is a PlayChallengeObjectiveCompleteView
public protocol ProtocolPlayChallengeObjectiveCompleteView {
	
	// MARK: - Stored Properties

	var sequencedViewWrapper: SequencedViewWrapper? { get }
	
	
	// MARK: - Methods
	
	func set(playChallengeObjectiveWrapper:	PlayChallengeObjectiveWrapper, sequencedViewWrapper: SequencedViewWrapper, onclose onCloseCompletionhandler: ((SequencedViewWrapper, Error?) -> Void)?)
	
}
