//
//  BasicPlayExperienceStepViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A strategy for accessing the BasicPlayExperienceStepView view
public class BasicPlayExperienceStepViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playExperienceStepView: 	ProtocolPlayExperienceStepView?

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playExperienceStepView: ProtocolPlayExperienceStepView) {

		self.playExperienceStepView 	= playExperienceStepView

	}
	
}

// MARK: - Extension ProtocolBasicPlayExperienceStepViewViewAccessStrategy

extension BasicPlayExperienceStepViewViewAccessStrategy: ProtocolBasicPlayExperienceStepViewViewAccessStrategy {
	
	// MARK: - Methods

}

// MARK: - Extension ProtocolPlayExperienceStepViewViewAccessStrategy

extension BasicPlayExperienceStepViewViewAccessStrategy: ProtocolPlayExperienceStepViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func present(playExperienceStepExerciseView view: ProtocolPlayExperienceStepExerciseView) {
		
		self.playExperienceStepView!.present(playExperienceStepExerciseView: view)
		
	}
	
}
