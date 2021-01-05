//
//  RelativeConnectionRESTWebAPIModelAccessStrategy.swift
//  f30
//
//  Created by David on 03/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSocial
import SFSerialization
import SFNet
import f30Core
import f30Model

/// A strategy for accessing the RelativeConnection model data using a REST Web API
public class RelativeConnectionRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {

	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "RelativeConnections")
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionsDummyDataYN")) {
				
				self.selectDummy(byFromRelativeMemberID: fromRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: completionHandler)
				
				return
				
			}

		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionsSelectByFromRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   fromRelativeMemberID,
											   String(connectionContractType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionsDummyDataYN")) {
				
				self.selectDummy(byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionsSelectByToRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   toRelativeMemberID,
											   String(connectionContractType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionsDummyDataYN")) {
				
				self.selectDummy(fromRelativeMemberID: fromRelativeMemberID, byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionsSelectByFromRelativeMemberIDToRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   fromRelativeMemberID,
											   toRelativeMemberID,
											   String(connectionContractType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionsDummyDataYN")) {
				
				self.selectDummy(byWithRelativeMemberID: withRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionsSelectByWithRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   withRelativeMemberID,
											   String(connectionContractType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(forRelativeMemberID: String, byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeConnectionsDummyDataYN")) {
				
				self.selectDummy(forRelativeMemberID: forRelativeMemberID, byWithRelativeMemberID: withRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeConnectionDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeConnectionsSelectByForRelativeMemberIDWithRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   forRelativeMemberID,
											   withRelativeMemberID,
											   String(connectionContractType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	
	// MARK: - Override Methods
	

	// MARK: - Dummy Data Methods
	
	fileprivate func selectDummy(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byFromRelativeMemberID", tableName: "RelativeConnectionsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}

	fileprivate func selectDummy(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byToRelativeMemberID", tableName: "RelativeConnectionsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]

		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("fromRelativeMemberID_byToRelativeMemberID", tableName: "RelativeConnectionsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byWithRelativeMemberID", tableName: "RelativeConnectionsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(forRelativeMemberID: String, byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("forRelativeMemberID_byWithRelativeMemberID", tableName: "RelativeConnectionsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
}

// MARK: - Extension ProtocolRelativeConnectionModelAccessStrategy

extension RelativeConnectionRESTWebAPIModelAccessStrategy: ProtocolRelativeConnectionModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byFromRelativeMemberID: fromRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(fromRelativeMemberID: fromRelativeMemberID, byToRelativeMemberID: toRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byWithRelativeMemberID: withRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(forRelativeMemberID: String, byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(forRelativeMemberID: forRelativeMemberID, byWithRelativeMemberID: withRelativeMemberID, applicationID: applicationID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
}
