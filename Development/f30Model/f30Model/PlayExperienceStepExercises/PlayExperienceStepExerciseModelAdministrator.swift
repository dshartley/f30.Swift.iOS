//
//  PlayExperienceStepExerciseModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Manages PlayExperienceStepExercise data
public class PlayExperienceStepExerciseModelAdministrator: ModelAdministratorBase {
	
	// MARK: - Public Stored Properties
	
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(modelAccessStrategy:			ProtocolModelAccessStrategy,
						 modelAdministratorProvider:	ProtocolModelAdministratorProvider,
						 storageDateFormatter:			DateFormatter) {
		super.init(modelAccessStrategy: modelAccessStrategy,
				   modelAdministratorProvider: modelAdministratorProvider,
				   storageDateFormatter: storageDateFormatter)
	}
	
	
	// MARK: - Public Methods
	
	public func toWrappers() -> [PlayExperienceStepExerciseWrapper] {
		
		var result:             [PlayExperienceStepExerciseWrapper] = [PlayExperienceStepExerciseWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlayExperienceStepExerciseCollection = collection as! PlayExperienceStepExerciseCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlayExperienceStepExerciseWrapper = (item as! PlayExperienceStepExercise).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlayExperienceStepExerciseCollection(modelAdministrator: self,
										storageDateFormatter: self.storageDateFormatter!)
	}
	
	public override func setupForeignKeys() {
		
		// No foreign keys
	}
	
	public override func setupOmittedKeys() {
		
		// Not omitted keys
	}
	
	
	// MARK: - Private Methods
	
}
