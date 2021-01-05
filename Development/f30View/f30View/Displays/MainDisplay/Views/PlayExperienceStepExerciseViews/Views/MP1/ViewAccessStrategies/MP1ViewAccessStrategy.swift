//
//  MP1ViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A strategy for accessing the MP1 view
public class MP1ViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playExperienceStepExerciseView: 	ProtocolPlayExperienceStepExerciseView?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playExperienceStepExerciseView: ProtocolPlayExperienceStepExerciseView) {

		self.playExperienceStepExerciseView 	= playExperienceStepExerciseView

	}
	
}

// MARK: - Extension ProtocolMP1ViewAccessStrategy

extension MP1ViewAccessStrategy: ProtocolMP1ViewAccessStrategy {
	
	// MARK: - Methods
	
	public func present(p1SubItem view: ProtocolP1SubItem) {
		
		if let v = self.playExperienceStepExerciseView! as? ProtocolMP1 {
		
			v.present(p1SubItem: view)
			
		}
		
	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseViewViewAccessStrategy

extension MP1ViewAccessStrategy: ProtocolPlayExperienceStepExerciseViewViewAccessStrategy {
	
	// MARK: - Methods
	
}
