//
//  PlayAreaPathAbilityButtonViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the PlayAreaPathAbilityButtonView view layer
public class PlayAreaPathAbilityButtonViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolPlayAreaPathAbilityButtonViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPlayAreaPathAbilityButtonViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func displayIsEngagedYN(isEngagedYN: Bool) {
		
		self.viewAccessStrategy!.displayIsEngagedYN(isEngagedYN: isEngagedYN)
		
	}
	
}
