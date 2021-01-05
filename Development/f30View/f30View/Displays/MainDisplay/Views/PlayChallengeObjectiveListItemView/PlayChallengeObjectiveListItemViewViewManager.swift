//
//  PlayChallengeObjectiveListItemViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the PlayChallengeObjectiveListItemView view layer
public class PlayChallengeObjectiveListItemViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolPlayChallengeObjectiveListItemViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPlayChallengeObjectiveListItemViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func displayIsCompleteYN(isCompleteYN: Bool) {
		
		self.viewAccessStrategy!.displayIsCompleteYN(isCompleteYN: isCompleteYN)
		
	}
	
}
