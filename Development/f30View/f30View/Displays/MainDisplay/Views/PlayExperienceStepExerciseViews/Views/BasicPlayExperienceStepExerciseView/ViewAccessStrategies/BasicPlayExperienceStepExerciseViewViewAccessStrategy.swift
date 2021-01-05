//
//  BasicPlayExperienceStepExerciseViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFSerialization

/// A strategy for accessing the BasicPlayExperienceStepExerciseView view
public class BasicPlayExperienceStepExerciseViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var textLabel: 							UILabel?
	fileprivate var playExperienceStepExerciseView: 	ProtocolPlayExperienceStepExerciseView?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playExperienceStepExerciseView: ProtocolPlayExperienceStepExerciseView,
					  textLabel: UILabel) {

		self.playExperienceStepExerciseView 	= playExperienceStepExerciseView
		self.textLabel 							= textLabel

	}
	
}

// MARK: - Extension ProtocolBasicPlayExperienceStepExerciseViewViewAccessStrategy

extension BasicPlayExperienceStepExerciseViewViewAccessStrategy: ProtocolBasicPlayExperienceStepExerciseViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func displayText(text: String) -> Void {
		
		self.textLabel!.text = text
		
	}
	
	public func present(img1 view: ProtocolImg1) {
		
		if let v = self.playExperienceStepExerciseView! as? ProtocolMC1 {
			
			v.present(img1: view)
			
		}

	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseViewViewAccessStrategy

extension BasicPlayExperienceStepExerciseViewViewAccessStrategy: ProtocolPlayExperienceStepExerciseViewViewAccessStrategy {
	
	// MARK: - Methods
	
}
