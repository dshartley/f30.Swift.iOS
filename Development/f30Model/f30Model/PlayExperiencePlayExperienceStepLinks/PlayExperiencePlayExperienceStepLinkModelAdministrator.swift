//
//  PlayExperiencePlayExperienceStepLinkModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Manages PlayExperiencePlayExperienceStepLink data
public class PlayExperiencePlayExperienceStepLinkModelAdministrator: ModelAdministratorBase {
	
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

	public func toWrappers() -> [PlayExperiencePlayExperienceStepLinkWrapper] {
		
		var result:             [PlayExperiencePlayExperienceStepLinkWrapper] = [PlayExperiencePlayExperienceStepLinkWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlayExperiencePlayExperienceStepLinkCollection = collection as! PlayExperiencePlayExperienceStepLinkCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlayExperiencePlayExperienceStepLinkWrapper = (item as! PlayExperiencePlayExperienceStepLink).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlayExperiencePlayExperienceStepLinkCollection(modelAdministrator: self,
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
