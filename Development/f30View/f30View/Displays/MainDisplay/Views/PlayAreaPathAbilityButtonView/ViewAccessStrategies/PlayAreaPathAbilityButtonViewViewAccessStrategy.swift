//
//  PlayAreaPathAbilityButtonViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the PlayAreaPathAbilityButtonView view
public class PlayAreaPathAbilityButtonViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playAreaPathAbilityButtonView: ProtocolPlayAreaPathAbilityButtonView?

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playAreaPathAbilityButtonView: ProtocolPlayAreaPathAbilityButtonView) {

		self.playAreaPathAbilityButtonView = playAreaPathAbilityButtonView

	}
	
}

// MARK: - Extension ProtocolPlayAreaPathAbilityButtonViewViewAccessStrategy

extension PlayAreaPathAbilityButtonViewViewAccessStrategy: ProtocolPlayAreaPathAbilityButtonViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func displayIsEngagedYN(isEngagedYN: Bool) {
		
		self.playAreaPathAbilityButtonView!.set(isEngagedYN: isEngagedYN)
		
	}

}
