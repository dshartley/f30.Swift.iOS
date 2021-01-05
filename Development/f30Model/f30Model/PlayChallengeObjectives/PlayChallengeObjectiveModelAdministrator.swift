//
//  PlayChallengeObjectiveModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core

/// Manages PlayChallengeObjective data
public class PlayChallengeObjectiveModelAdministrator: ModelAdministratorBase {
	
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
	
	public func completePlayChallengeObjective(item: ProtocolModelItem, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let completePlayChallengeObjectiveCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Call the completion handler
			completionHandler(error)
			
		}
		
		// Load the data
		(self.modelAccessStrategy as! ProtocolPlayChallengeObjectiveModelAccessStrategy).completePlayChallengeObjective(item: item, oncomplete: completePlayChallengeObjectiveCompletionHandler)
		
	}
	
	public func toWrappers() -> [PlayChallengeObjectiveWrapper] {
		
		var result:             [PlayChallengeObjectiveWrapper] = [PlayChallengeObjectiveWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlayChallengeObjectiveCollection = collection as! PlayChallengeObjectiveCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlayChallengeObjectiveWrapper = (item as! PlayChallengeObjective).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlayChallengeObjectiveCollection(modelAdministrator: self,
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
