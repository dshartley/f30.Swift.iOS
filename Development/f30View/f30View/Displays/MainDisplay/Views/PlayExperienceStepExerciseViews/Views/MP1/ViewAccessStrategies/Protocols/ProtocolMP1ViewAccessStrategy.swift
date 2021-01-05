//
//  ProtocolMP1ViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a class which provides a strategy for accessing the MP1 view
public protocol ProtocolMP1ViewAccessStrategy {
	
	// MARK: - Methods
	
	func present(p1SubItem view: ProtocolP1SubItem)
	
}
