//
//  PlayActiveChallengeViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the PlayActiveChallengeView view layer
public class PlayActiveChallengeViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolPlayActiveChallengeViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPlayActiveChallengeViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func displayTitle(title: String) -> Void {
		
		self.viewAccessStrategy!.displayTitle(title: title)
		
	}
	
	public func present(playChallengeObjectiveListItemView view: ProtocolPlayChallengeObjectiveListItemView) {
		
		self.viewAccessStrategy!.present(playChallengeObjectiveListItemView: view)
		
	}
	
}
