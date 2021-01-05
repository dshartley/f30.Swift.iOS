//
//  RelativeInteractionRESTWebAPIModelAccessStrategy.swift
//  f30
//
//  Created by David on 08/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSocial
import SFSerialization
import SFNet
import f30Core
import f30Model

/// A strategy for accessing the RelativeInteraction model data using a REST Web API
public class RelativeInteractionRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "RelativeInteractions")

	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeInteractionsDummyDataYN")) {
				
				self.selectDummy(byFromRelativeMemberID: fromRelativeMemberID, applicationID: applicationID, interactionType: interactionType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeInteractionDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeInteractionsSelectByFromRelativeMemberID", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   fromRelativeMemberID,
											   String(interactionType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeInteractionsDummyDataYN")) {
				
				self.selectDummy(byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, interactionType: interactionType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeInteractionDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeInteractionsSelectByToRelativeMemberID", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   toRelativeMemberID,
											   String(interactionType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Dummy Data Methods
	
	fileprivate func selectDummy(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byFromRelativeMemberID", tableName: "RelativeInteractionsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byToRelativeMemberID", tableName: "RelativeInteractionsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
}

// MARK: - Extension ProtocolRelativeInteractionModelAccessStrategy

extension RelativeInteractionRESTWebAPIModelAccessStrategy: ProtocolRelativeInteractionModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byFromRelativeMemberID: fromRelativeMemberID, applicationID: applicationID, interactionType: interactionType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, interactionType: interactionType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
}
