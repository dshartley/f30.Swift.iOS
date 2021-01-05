//
//  PlayAreaPathModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFGridScape

/// Manages PlayAreaPath data
public class PlayAreaPathModelAdministrator: ModelAdministratorBase {
	
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

	public func select(byFromCellCoord fromCellCoord: CellCoord, toCellCoord: CellCoord, playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, playGameID: String, loadRelationalTablesYN: Bool, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
		self.setupCollection()
		
		// Create completion handler
		let selectCompletionHandler: (([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) =
		{
			(data, collection, error) -> Void in
			
			if (data != nil && error == nil) {
				
				// Load relational tables
				if (loadRelationalTablesYN) { self.doLoadRelationalTables(data: data!) }
				
			}
			
			self.doAfterLoad()
			
			// Call the completion handler
			completionHandler(self.collection!.dataDocument, error)
		}
		
		// Load the data
		(self.modelAccessStrategy as! ProtocolPlayAreaPathModelAccessStrategy).select(byFromCellCoord: fromCellCoord, toCellCoord: toCellCoord, playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, playGameID: playGameID, loadRelationalTablesYN: loadRelationalTablesYN, collection: self.collection!, oncomplete: selectCompletionHandler)
		
	}
	
	public func toWrappers() -> [PlayAreaPathWrapper] {
		
		var result:             [PlayAreaPathWrapper] = [PlayAreaPathWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlayAreaPathCollection = collection as! PlayAreaPathCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlayAreaPathWrapper = (item as! PlayAreaPath).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlayAreaPathCollection(modelAdministrator: self,
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
