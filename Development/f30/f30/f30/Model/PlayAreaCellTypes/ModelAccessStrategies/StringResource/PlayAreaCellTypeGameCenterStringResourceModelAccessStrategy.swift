//
//  PlayAreaCellTypeGameCenterStringResourceModelAccessStrategy.swift
//  f30
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSocial
import SFSerialization
import SFNet
import f30Model

/// A strategy for accessing the PlayAreaCellType model data using a REST Web API
public class PlayAreaCellTypeGameCenterStringResourceModelAccessStrategy: ModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter)
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter,
						 tableName: String) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: tableName)
	}
	
	
	// MARK: - Private Methods

	fileprivate func runQuery(byRelativeMember relativeMemberID: String, playGameID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byID", tableName: "PlayAreaCellTypeGameCenter", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		//let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		//completionHandler(returnData, nil)
		completionHandler(data, nil)
		
	}
	
	fileprivate func getRunQueryCompletionHandler(collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) -> (([String:Any]?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			[weak self] (data, error) -> Void in
			
			guard let strongSelf = self else {
				
				// Call the completion handler
				completionHandler(data, collection, error)
				return
				
			}
			
			var collection = collection
			
			// Fill the collection with the loaded data
			collection = strongSelf.fillCollection(collection: collection, data: data![strongSelf.tableName] as! [Any])!
			
			// Call the completion handler
			completionHandler(data, collection, error)
			
		}
		
		return runQueryCompletionHandler
	}
	
	
	// MARK: - Override Methods
	
}

// MARK: - Extension ProtocolPlayAreaCellTypeGameCenterModelAccessStrategy

extension PlayAreaCellTypeGameCenterStringResourceModelAccessStrategy: ProtocolPlayAreaCellTypeGameCenterModelAccessStrategy {
	
	// MARK: - Public Methods

	public func select(byRelativeMember relativeMemberID: String, playGameID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byRelativeMember: relativeMemberID, playGameID: playGameID, collection: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
}

