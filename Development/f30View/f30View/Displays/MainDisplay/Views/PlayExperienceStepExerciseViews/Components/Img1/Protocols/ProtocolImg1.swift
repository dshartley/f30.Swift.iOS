//
//  ProtocolImg1.swift
//  f30View
//
//  Created by David on 16/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Model

/// Defines a class which is a Img1 view
public protocol ProtocolImg1 {
	
	// MARK: - Stored Properties

	var wrapper: 		Img1Wrapper? { get }
	var isSelected: 	Bool { get }
	
	
	// MARK: - Computed Properties
	
	var givenAnswer: 	String? { get set }
	
	
	// MARK: - Methods

}
