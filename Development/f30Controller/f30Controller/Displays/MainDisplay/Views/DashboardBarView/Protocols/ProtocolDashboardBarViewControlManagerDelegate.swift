//
//  ProtocolDashboardBarViewControlManagerDelegate.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a delegate for a DashboardBarViewControlManager class
public protocol ProtocolDashboardBarViewControlManagerDelegate: class {
	
	// MARK: - Methods
	
	func dashboardBarViewControlManager(isNotConnected error: Error?)
	
}
