//
//  ProtocolPlayExperienceCompleteView.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core
import f30Model

/// Defines a class which is a PlayExperienceCompleteView
public protocol ProtocolPlayExperienceCompleteView {
	
	// MARK: - Stored Properties

	var sequencedViewWrapper: SequencedViewWrapper? { get }
	
	
	// MARK: - Methods
	
	func set(playExperienceWrapper:	PlayExperienceWrapper, sequencedViewWrapper: SequencedViewWrapper, onclose onCloseCompletionhandler: ((SequencedViewWrapper, Error?) -> Void)?)
	
}
