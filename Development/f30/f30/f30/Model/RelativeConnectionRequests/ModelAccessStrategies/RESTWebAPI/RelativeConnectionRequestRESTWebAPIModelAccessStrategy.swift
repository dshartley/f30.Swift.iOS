//
//  RelativeConnectionRequestRESTWebAPIModelAccessStrategy.swift
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

/// A strategy for accessing the RelativeConnectionRequest model data using a REST Web API
public class RelativeConnectionRequestRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "RelativeConnectionRequests")
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionRequestsDummyDataYN")) {
				
				self.selectDummy(byFromRelativeMemberID: fromRelativeMemberID, applicationID: applicationID, requestType: requestType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionRequestDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionRequestsSelectByFromRelativeMemberID", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   fromRelativeMemberID,
											   String(requestType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionRequestsDummyDataYN")) {
				
				self.selectDummy(byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, requestType: requestType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionRequestDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionRequestsSelectByToRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   toRelativeMemberID,
											   String(requestType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionRequestsDummyDataYN")) {
				
				self.selectDummy(fromRelativeMemberID: fromRelativeMemberID, byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, requestType: requestType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionRequestDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionRequestsSelectByFromRelativeMemberIDToRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   fromRelativeMemberID,
											   toRelativeMemberID,
											   String(requestType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
		
	
	// MARK: - Override Methods
	
	
	// MARK: - Dummy Data Methods
	
	fileprivate func selectDummy(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byFromRelativeMemberID", tableName: "RelativeConnectionRequestsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}

	fileprivate func selectDummy(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byToRelativeMemberID", tableName: "RelativeConnectionRequestsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {

		let responseString	= NSLocalizedString("fromRelativeMemberID_byToRelativeMemberID", tableName: "RelativeConnectionRequestsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
}

// MARK: - Extension ProtocolRelativeConnectionRequestModelAccessStrategy

extension RelativeConnectionRequestRESTWebAPIModelAccessStrategy: ProtocolRelativeConnectionRequestModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)

		// Run the query
		self.runQuery(byFromRelativeMemberID: fromRelativeMemberID, applicationID: applicationID, requestType: requestType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, requestType: requestType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(fromRelativeMemberID: fromRelativeMemberID, byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, requestType: requestType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
}
