//
//  PlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Manages PlayExperienceStepPlayExperienceStepExerciseLink data
public class PlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator: ModelAdministratorBase {
	
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

	public func toWrappers() -> [PlayExperienceStepPlayExperienceStepExerciseLinkWrapper] {
		
		var result:             [PlayExperienceStepPlayExperienceStepExerciseLinkWrapper] = [PlayExperienceStepPlayExperienceStepExerciseLinkWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlayExperienceStepPlayExperienceStepExerciseLinkCollection = collection as! PlayExperienceStepPlayExperienceStepExerciseLinkCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlayExperienceStepPlayExperienceStepExerciseLinkWrapper = (item as! PlayExperienceStepPlayExperienceStepExerciseLink).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlayExperienceStepPlayExperienceStepExerciseLinkCollection(modelAdministrator: self,
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
