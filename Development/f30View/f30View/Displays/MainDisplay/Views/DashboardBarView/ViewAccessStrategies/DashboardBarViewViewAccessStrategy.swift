//
//  DashboardBarViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the DashboardBarView view
public class DashboardBarViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var textTextField: 			UITextField!
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(textTextField: UITextField) {
		
		self.textTextField = textTextField
		
	}
	
}

// MARK: - Extension ProtocolDashboardBarViewViewAccessStrategy

extension DashboardBarViewViewAccessStrategy: ProtocolDashboardBarViewViewAccessStrategy {
	
	// MARK: - Methods
	
}
