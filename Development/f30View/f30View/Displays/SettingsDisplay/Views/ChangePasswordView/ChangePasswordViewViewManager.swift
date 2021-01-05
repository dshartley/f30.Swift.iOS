//
//  ChangePasswordViewViewManager.swift
//  f30View
//
//  Created by David on 29/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the ChangePasswordView view layer
public class ChangePasswordViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolChangePasswordViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolChangePasswordViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}


	// MARK: - Public Methods
	
	public func getFromPassword() -> String {
		
		return self.viewAccessStrategy!.getFromPassword()
		
	}
	
	public func getToPassword() -> String {
		
		return self.viewAccessStrategy!.getToPassword()
	}
	
}
