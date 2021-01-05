//
//  PlayAreaCellModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel

/// Manages PlayAreaCell data
public class PlayAreaCellModelAdministrator: ModelAdministratorBase {
	
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

	public func select(byCellCoordRange relativeMemberID: String, playGameID: String, playAreaID: String, fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int, loadRelationalTablesYN: Bool, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
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
		(self.modelAccessStrategy as! ProtocolPlayAreaCellModelAccessStrategy).select(byCellCoordRange: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID, fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow, loadRelationalTablesYN: loadRelationalTablesYN, collection: self.collection!, oncomplete: selectCompletionHandler)

	}
	
	public func select(byIsSpecialYN isSpecialYN: Bool, relativeMemberID: String, playGameID: String, playAreaID: String, loadRelationalTablesYN: Bool, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
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
		(self.modelAccessStrategy as! ProtocolPlayAreaCellModelAccessStrategy).select(byIsSpecialYN: isSpecialYN,  relativeMemberID: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID, loadRelationalTablesYN: loadRelationalTablesYN, collection: self.collection!, oncomplete: selectCompletionHandler)
		
	}
	
	public func toWrappers() -> [PlayAreaCellWrapper] {
		
		var result:             [PlayAreaCellWrapper] = [PlayAreaCellWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlayAreaCellCollection = collection as! PlayAreaCellCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlayAreaCellWrapper = (item as! PlayAreaCell).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlayAreaCellCollection(modelAdministrator: self,
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
