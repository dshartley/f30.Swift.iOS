//
//  PlaySubsetModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel

/// Manages PlaySubset data
public class PlaySubsetModelAdministrator: ModelAdministratorBase {
	
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

	public func select(byRelativeMember relativeMemberID: String, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
		self.setupCollection()
		
		// Create completion handler
		let selectCompletionHandler: (([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) =
		{
			(data, collection, error) -> Void in
			
			self.doAfterLoad()
			
			// Call the completion handler
			completionHandler(self.collection!.dataDocument, error)
			
		}
		
		// Load the data
		(self.modelAccessStrategy as! ProtocolPlaySubsetModelAccessStrategy).select(byRelativeMember: relativeMemberID, collection: self.collection!, oncomplete: selectCompletionHandler)

	}
	
	public func toWrappers() -> [PlaySubsetWrapper] {
		
		var result:             [PlaySubsetWrapper] = [PlaySubsetWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlaySubsetCollection = collection as! PlaySubsetCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlaySubsetWrapper = (item as! PlaySubset).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}


	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlaySubsetCollection(modelAdministrator: self,
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
