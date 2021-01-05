//
//  PlayAreaPathRESTWebAPIModelAccessStrategy.swift
//  f30
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFGridScape
import SFSocial
import SFSerialization
import SFNet
import f30Model

/// A strategy for accessing the PlayAreaPath model data using a REST Web API
public class PlayAreaPathRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "PlayAreaPaths")
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byFromCellCoord fromCellCoord: CellCoord, toCellCoord: CellCoord, playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, playGameID: String, loadRelationalTablesYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadPlayAreaPathsDummyDataYN")) {
				
				self.selectDummy(byFromCellCoord: fromCellCoord, toCellCoord: toCellCoord, playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, playGameID: playGameID, loadRelationalTablesYN: loadRelationalTablesYN, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.FromColumn)", value: "\(fromCellCoord.column)")
		dataWrapper.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.FromRow)", value: "\(fromCellCoord.row)")
		dataWrapper.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.ToColumn)", value: "\(toCellCoord.column)")
		dataWrapper.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.ToRow)", value: "\(toCellCoord.row)")
		dataWrapper.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.PlayAreaPathAbilityType)", value: "\(playAreaPathAbilityWrapper.playAreaPathAbilityType.type.rawValue)")
		dataWrapper.setParameterValue(key: "\(PlayAreaPathDataParameterKeys.LoadRelationalTablesYN)", value: "\(loadRelationalTablesYN)")
		
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
		var urlString: 				String = NSLocalizedString("PlayAreaPathsSelectByFromCellCoordToCellCoordPlayGameIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   playGameID)
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Dummy Data Methods
	
	fileprivate func selectDummy(byFromCellCoord fromCellCoord: CellCoord, toCellCoord: CellCoord, playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, playGameID: String, loadRelationalTablesYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let defaultKey: 		String = "byFromCellCoord"
		let key: 				String = defaultKey + "_\(fromCellCoord.column)_\(fromCellCoord.row)_toCellCoord_\(toCellCoord.column)_\(toCellCoord.row)_type_\(playAreaPathAbilityWrapper.playAreaPathAbilityType.type)"
		
		
		// DEBUG:
		
		//let key: String = "byFromCellCoord_0_0_toCellCoord_3_0_type_ByFoot"
		
		// Get string for key
		var responseString: 	String	= NSLocalizedString(key, tableName: "PlayAreaPathsDummyRESTWebAPIResponse", comment: "")
		
		// If not found then use defaultKey
		if (responseString == key) {
			
			responseString 		= NSLocalizedString(defaultKey, tableName: "PlayAreaPathsDummyRESTWebAPIResponse", comment: "")
			
		}
		
		// Convert the response to JSON dictionary
		let data:				[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		guard (data != nil) else {
			
			// Call the completion handler
			completionHandler(nil, nil)
			
			return
			
		}
		
		// Process the data
		let returnData:			[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
}

// MARK: - Extension ProtocolPlayAreaPathModelAccessStrategy

extension PlayAreaPathRESTWebAPIModelAccessStrategy: ProtocolPlayAreaPathModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byFromCellCoord fromCellCoord: CellCoord, toCellCoord: CellCoord, playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, playGameID: String, loadRelationalTablesYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String : Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byFromCellCoord: fromCellCoord, toCellCoord: toCellCoord, playAreaPathAbilityWrapper: playAreaPathAbilityWrapper, playGameID: playGameID, loadRelationalTablesYN: loadRelationalTablesYN, into: collection, oncomplete: runQueryCompletionHandler)

		
	}
	
}

