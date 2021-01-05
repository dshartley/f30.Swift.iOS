//
//  PlayAreaViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// A strategy for accessing the PlayAreaView view
public class PlayAreaViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playAreaView: ProtocolPlayAreaView?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playAreaView: ProtocolPlayAreaView) {

		self.playAreaView = playAreaView
		
	}
	
}

// MARK: - Extension ProtocolPlayAreaViewViewAccessStrategy

extension PlayAreaViewViewAccessStrategy: ProtocolPlayAreaViewViewAccessStrategy {
	
	// MARK: - Methods
	
}

