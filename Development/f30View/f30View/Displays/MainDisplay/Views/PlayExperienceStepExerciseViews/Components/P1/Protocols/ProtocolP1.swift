//
//  ProtocolP1.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a P1 view
public protocol ProtocolP1 {
	
	// MARK: - Stored Properties

	var wrapper: 		P1Wrapper? { get }
	var isSelected: 	Bool { get }
	
	
	// MARK: - Computed Properties
	
	var givenAnswer: 	String? { get set }
	
	
	// MARK: - Methods

}
