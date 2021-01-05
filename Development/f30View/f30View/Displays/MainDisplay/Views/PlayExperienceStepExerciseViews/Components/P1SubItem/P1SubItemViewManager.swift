//
//  P1SubItemViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the P1SubItem view layer
public class P1SubItemViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolP1SubItemViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolP1SubItemViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func displayContentImage(image: UIImage) {
		
		self.viewAccessStrategy!.displayContentImage(image: image)
		
	}
	
}
