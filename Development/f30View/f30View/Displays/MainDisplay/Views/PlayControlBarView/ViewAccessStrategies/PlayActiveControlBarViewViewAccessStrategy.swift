//
//  PlayControlBarViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the PlayControlBarView view
public class PlayControlBarViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playControlBarView: ProtocolPlayControlBarView?

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playControlBarView: ProtocolPlayControlBarView) {
		
		self.playControlBarView = playControlBarView

	}
	
}

// MARK: - Extension ProtocolPlayControlBarViewViewAccessStrategy

extension PlayControlBarViewViewAccessStrategy: ProtocolPlayControlBarViewViewAccessStrategy {
	
	// MARK: - Methods
	
}
