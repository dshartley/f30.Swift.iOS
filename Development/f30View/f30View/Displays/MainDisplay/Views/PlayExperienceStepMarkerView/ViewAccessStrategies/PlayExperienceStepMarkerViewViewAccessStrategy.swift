//
//  PlayExperienceStepMarkerViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the PlayExperienceStepMarkerView view
public class PlayExperienceStepMarkerViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playExperienceStepMarkerView: 		ProtocolPlayExperienceStepMarkerView?
	fileprivate var playExperienceStepNameLabel: 		UILabel?
	fileprivate var thumbnailImageView: 				UIImageView?

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playExperienceStepMarkerView: ProtocolPlayExperienceStepMarkerView,
					  playExperienceStepNameLabel: UILabel,
					  thumbnailImageView: UIImageView) {

		self.playExperienceStepMarkerView	= playExperienceStepMarkerView
		self.playExperienceStepNameLabel 	= playExperienceStepNameLabel
		self.thumbnailImageView				= thumbnailImageView

	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepMarkerViewViewAccessStrategy

extension PlayExperienceStepMarkerViewViewAccessStrategy: ProtocolPlayExperienceStepMarkerViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func display(playExperienceStepName: String) {
		
		self.playExperienceStepNameLabel!.text = playExperienceStepName
		
	}
	
	public func displayThumbnailImage(image: UIImage) {
		
		self.thumbnailImageView!.image = image
		
	}
	
	public func displayIsCompleteYN(isCompleteYN: Bool) {
		
		self.playExperienceStepMarkerView!.set(isCompleteYN: isCompleteYN)
		
	}
	
	public func displayIsActiveYN(isActiveYN: Bool) {

		self.playExperienceStepMarkerView!.set(isActiveYN: isActiveYN)
		
	}
	
}
