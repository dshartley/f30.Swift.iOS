//
//  ProtocolPlayExperienceStepMarkerViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a class which provides a strategy for accessing the PlayExperienceStepMarkerView view
public protocol ProtocolPlayExperienceStepMarkerViewViewAccessStrategy {
	
	// MARK: - Methods
	
	func display(playExperienceStepName: String)
	
	func displayThumbnailImage(image: UIImage)
	
	func displayIsCompleteYN(isCompleteYN: Bool)
	
	func displayIsActiveYN(isActiveYN: Bool)
	
}
