//
//  BasicPlayExperienceViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the BasicPlayExperienceView view
public class BasicPlayExperienceViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playExperienceView: 	ProtocolPlayExperienceView?
	fileprivate var titleLabel: 			UILabel?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playExperienceView: 	ProtocolPlayExperienceView,
					  titleLabel: 			UILabel) {

		self.playExperienceView 	= playExperienceView
		self.titleLabel 			= titleLabel
		
	}
	
}

// MARK: - Extension ProtocolBasicPlayExperienceViewViewAccessStrategy

extension BasicPlayExperienceViewViewAccessStrategy: ProtocolBasicPlayExperienceViewViewAccessStrategy {
	
	// MARK: - Methods
	
}

// MARK: - Extension ProtocolPlayExperienceViewViewAccessStrategy

extension BasicPlayExperienceViewViewAccessStrategy: ProtocolPlayExperienceViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func displayTitle(title: String) -> Void {
		
		self.titleLabel!.text = title
		
	}
	
	public func present(playExperienceStepMarkerView view: ProtocolPlayExperienceStepMarkerView) {
		
		self.playExperienceView!.present(playExperienceStepMarkerView: view)
		
	}
	
}
