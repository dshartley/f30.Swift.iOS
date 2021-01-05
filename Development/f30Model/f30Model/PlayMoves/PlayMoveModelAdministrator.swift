//
//  PlayMoveModelAdministrator.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import f30Core
import SFSerialization

/// Manages PlayMove data
public class PlayMoveModelAdministrator: ModelAdministratorBase {
	
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

	public func select(byPlayTileID playTileID: String, playGameID: String, loadRelationalTablesYN: Bool, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
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
		(self.modelAccessStrategy as! ProtocolPlayMoveModelAccessStrategy).select(byPlayTileID: playTileID, playGameID: playGameID, collection: self.collection!, oncomplete: selectCompletionHandler)
		
	}

	public func select(byPlayTokenID playTokenID: String, playGameID: String, loadRelationalTablesYN: Bool, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {
		
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
		(self.modelAccessStrategy as! ProtocolPlayMoveModelAccessStrategy).select(byPlayTokenID: playTokenID, playGameID: playGameID, collection: self.collection!, oncomplete: selectCompletionHandler)
		
	}

	public func select(byPlayTokenID playTokenID: String, playGameID: String, playAreaPathWrapper: PlayAreaPathWrapper, loadRelationalTablesYN: Bool, oncomplete completionHandler:@escaping ([Any]?, Error?) -> Void) {

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
		
		// Get playAreaPathData
		let playAreaPathData: String = self.getPlayAreaPathData(from: playAreaPathWrapper)
		
		// Load the data
		(self.modelAccessStrategy as! ProtocolPlayMoveModelAccessStrategy).select(byPlayTokenID: playTokenID, playGameID: playGameID, playAreaPathData: playAreaPathData, collection: self.collection!, oncomplete: selectCompletionHandler)
		
	}
	
	
	public func toWrappers() -> [PlayMoveWrapper] {
		
		var result:             [PlayMoveWrapper] = [PlayMoveWrapper]()
		
		if let collection = self.collection {
			
			let collection:     PlayMoveCollection = collection as! PlayMoveCollection
			
			// Go through each item
			for item in collection.items! {
				
				// Include items that are not deleted or obsolete
				if (item.status != .deleted && item.status != .obsolete) {
					
					// Get item wrapper
					let wrapper: PlayMoveWrapper = (item as! PlayMove).toWrapper()
					
					result.append(wrapper)
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Override Methods
	
	public override func newCollection() -> ProtocolModelItemCollection? {
		
		return PlayMoveCollection(modelAdministrator: self,
										storageDateFormatter: self.storageDateFormatter!)
	}
	
	public override func setupForeignKeys() {
		
		// No foreign keys
	}
	
	public override func setupOmittedKeys() {
		
		// Not omitted keys
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func getPlayAreaPathData(from wrapper: PlayAreaPathWrapper) -> String {
	
		// Create dataWrapper
		let dataWrapper: 					DataJSONWrapper = DataJSONWrapper()
		
		// Create playAreaPathsWrapper
		let playAreaPathsWrapper: 			DataJSONWrapper = DataJSONWrapper()
		playAreaPathsWrapper.ID 			= "PlayAreaPaths"
		
		dataWrapper.Items.append(playAreaPathsWrapper)
		
		// Serialize PlayAreaPathWrapper to DataJSONWrapper
		let papdjw: 						DataJSONWrapper = wrapper.toJSON()
		
		playAreaPathsWrapper.Items.append(papdjw)
		
		// Create playAreaPathPointsWrapper
		let playAreaPathPointsWrapper: 		DataJSONWrapper = DataJSONWrapper()
		playAreaPathPointsWrapper.ID 		= "PlayAreaPathPoints"
		
		dataWrapper.Items.append(playAreaPathPointsWrapper)
		
		// Go through each item
		for pappw in wrapper.pathPoints!.values {
			
			let pappw 						= pappw as! PlayAreaPathPointWrapper
			
			// Serialize PlayAreaPathPointWrapper to DataJSONWrapper
			let pappdjw: 					DataJSONWrapper = pappw.toJSON()
			
			playAreaPathPointsWrapper.Items.append(pappdjw)
			
		}
		
		// Get dataString
		let dataString: 				String = JSONHelper.SerializeDataJSONWrapper(dataWrapper: dataWrapper)!
		
		return dataString
		
	}
	
}
