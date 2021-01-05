//
//  PlayExperienceStepMarkerViewViewManager.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView

/// Manages the PlayExperienceStepMarkerView view layer
public class PlayExperienceStepMarkerViewViewManager: ViewManagerBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate var viewAccessStrategy: ProtocolPlayExperienceStepMarkerViewViewAccessStrategy?
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public init(viewAccessStrategy: ProtocolPlayExperienceStepMarkerViewViewAccessStrategy) {
		super.init()
		
		self.viewAccessStrategy = viewAccessStrategy
	}
	
	
	// MARK: - Public Methods
	
	public func display(playExperienceStepName: String) {
		
		self.viewAccessStrategy!.display(playExperienceStepName: playExperienceStepName)

	}
	
	public func displayThumbnailImage(image: UIImage) {
		
		self.viewAccessStrategy!.displayThumbnailImage(image: image)
		
	}
	
	public func displayIsCompleteYN(isCompleteYN: Bool) {
		
		self.viewAccessStrategy!.displayIsCompleteYN(isCompleteYN: isCompleteYN)
		
	}
	
	public func displayIsActiveYN(isActiveYN: Bool) {
		
		self.viewAccessStrategy!.displayIsActiveYN(isActiveYN: isActiveYN)
		
	}
	
}
