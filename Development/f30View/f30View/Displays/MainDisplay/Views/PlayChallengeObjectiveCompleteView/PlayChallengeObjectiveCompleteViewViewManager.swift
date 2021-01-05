//
//  PlayChallengeObjectiveCompleteViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the PlayChallengeObjectiveCompleteView view layer
public class PlayChallengeObjectiveCompleteViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolPlayChallengeObjectiveCompleteViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPlayChallengeObjectiveCompleteViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
}
