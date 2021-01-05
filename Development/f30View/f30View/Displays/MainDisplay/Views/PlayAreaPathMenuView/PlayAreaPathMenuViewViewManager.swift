//
//  PlayAreaPathMenuViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the PlayAreaPathMenuView view layer
public class PlayAreaPathMenuViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolPlayAreaPathMenuViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPlayAreaPathMenuViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
}
