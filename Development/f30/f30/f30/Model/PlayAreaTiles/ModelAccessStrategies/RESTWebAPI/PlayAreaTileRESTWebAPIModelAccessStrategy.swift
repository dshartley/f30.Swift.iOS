//
//  PlayAreaTileRESTWebAPIModelAccessStrategy.swift
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

/// A strategy for accessing the PlayAreaTile model data using a REST Web API
public class PlayAreaTileRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "PlayAreaTiles")
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byID ID: String, loadRelationalTablesYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadPlayAreaTilesDummyDataYN")) {
				
				self.selectDummy(byID: ID, loadRelationalTablesYN: loadRelationalTablesYN, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.LoadRelationalTablesYN)", value: "\(loadRelationalTablesYN)")
		
		// Create processResponse completion handler
		let processResponseCompletionHandler: (([String:Any]?, URLResponse?, Error?) -> Void) =
		{
			(data, response, error) -> Void in	// [weak self]
			
			// Call the completion handler
			completionHandler(data, error)
		}
		
		// Create processResponse
		let processResponse: 		((NSMutableData?, URLResponse?, Error?) -> Void) = self.getProcessResponse(oncomplete: processResponseCompletionHandler)
		
		// Create restApiHelper
		let restApiHelper: 			RESTApiHelper = RESTApiHelper(processResponse: processResponse, mode: RESTApiHelperMode.CompletionHandler)
		
		// Get the Url
		var urlString: 				String = NSLocalizedString("PlayAreaTilesSelectByIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString, ID)
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byCellCoordRange relativeMemberID: String, playGameID: String, playAreaID: String, fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadPlayAreaTilesDummyDataYN")) {
				
				self.selectDummy(byCellCoordRange: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID, fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow, loadRelationalTablesYN: loadRelationalTablesYN, collection: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.FromColumn)", value: "\(fromColumn)")
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.FromRow)", value: "\(fromRow)")
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.ToColumn)", value: "\(toColumn)")
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.ToRow)", value: "\(toRow)")
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.LoadRelationalTablesYN)", value: "\(loadRelationalTablesYN)")
		
		// Create processResponse completion handler
		let processResponseCompletionHandler: (([String:Any]?, URLResponse?, Error?) -> Void) =
		{
			(data, response, error) -> Void in	// [weak self]
			
			// Call the completion handler
			completionHandler(data, error)
		}
		
		// Create processResponse
		let processResponse: 		((NSMutableData?, URLResponse?, Error?) -> Void) = self.getProcessResponse(oncomplete: processResponseCompletionHandler)
		
		// Create restApiHelper
		let restApiHelper: 			RESTApiHelper = RESTApiHelper(processResponse: processResponse, mode: RESTApiHelperMode.CompletionHandler)
		
		// Get the Url
		var urlString: 				String = NSLocalizedString("PlayAreaTilesSelectByCellCoordRangePlayGameID", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   relativeMemberID,
											   playGameID)
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byIsSpecialYN isSpecialYN: Bool, relativeMemberID: String, playGameID: String, playAreaID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadPlayAreaTilesDummyDataYN")) {
				
				self.selectDummy(byIsSpecialYN: isSpecialYN, relativeMemberID: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID, loadRelationalTablesYN: loadRelationalTablesYN, collection: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.IsSpecialYN)", value: "\(BoolHelper.toInt(value: isSpecialYN))")
		dataWrapper.setParameterValue(key: "\(PlayAreaTileDataParameterKeys.LoadRelationalTablesYN)", value: "\(loadRelationalTablesYN)")
		
		// Create processResponse completion handler
		let processResponseCompletionHandler: (([String:Any]?, URLResponse?, Error?) -> Void) =
		{
			(data, response, error) -> Void in	// [weak self]
			
			// Call the completion handler
			completionHandler(data, error)
		}
		
		// Create processResponse
		let processResponse: 		((NSMutableData?, URLResponse?, Error?) -> Void) = self.getProcessResponse(oncomplete: processResponseCompletionHandler)
		
		// Create restApiHelper
		let restApiHelper: 			RESTApiHelper = RESTApiHelper(processResponse: processResponse, mode: RESTApiHelperMode.CompletionHandler)
		
		// Get the Url
		var urlString: 				String = NSLocalizedString("PlayAreaTilesSelectbyIsSpecialYNPlayGameID", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   relativeMemberID,
											   playGameID)
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Dummy Data Methods
	
	fileprivate func selectDummy(byID ID: String, loadRelationalTablesYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byID", tableName: "PlayAreaTilesDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byCellCoordRange relativeMemberID: String, playGameID: String, playAreaID: String, fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byCellCoordRange_playGameID", tableName: "PlayAreaTilesDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byIsSpecialYN isSpecialYN: Bool, relativeMemberID: String, playGameID: String, playAreaID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byIsSpecialYN_playGameID", tableName: "PlayAreaTilesDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
}

// MARK: - Extension ProtocolPlayAreaTileModelAccessStrategy

extension PlayAreaTileRESTWebAPIModelAccessStrategy: ProtocolPlayAreaTileModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byID ID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byID: ID, loadRelationalTablesYN: loadRelationalTablesYN, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byCellCoordRange relativeMemberID: String, playGameID: String, playAreaID: String, fromColumn: Int, fromRow: Int, toColumn: Int, toRow: Int, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byCellCoordRange: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID, fromColumn: fromColumn, fromRow: fromRow, toColumn: toColumn, toRow: toRow, loadRelationalTablesYN: loadRelationalTablesYN, collection: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byIsSpecialYN isSpecialYN: Bool, relativeMemberID: String, playGameID: String, playAreaID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byIsSpecialYN: isSpecialYN, relativeMemberID: relativeMemberID, playGameID: playGameID, playAreaID: playAreaID, loadRelationalTablesYN: loadRelationalTablesYN, collection: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
}

