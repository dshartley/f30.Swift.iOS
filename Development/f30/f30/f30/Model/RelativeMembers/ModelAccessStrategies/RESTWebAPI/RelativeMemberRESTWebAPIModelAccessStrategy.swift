//
//  RelativeMemberRESTWebAPIModelAccessStrategy.swift
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
import f30Core
import f30Model

/// A strategy for accessing the RelativeMember model data using a REST Web API
public class RelativeMemberRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "RelativeMembers")
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byUserProfileID userProfileID: String, applicationID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN")) {
				
				self.selectDummy(byUserProfileID: userProfileID, applicationID: applicationID, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeMembersSelectByUserProfileIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   userProfileID)
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}

	fileprivate func runQuery(byEmail email: String, applicationID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN")) {
				
				self.selectDummy(byEmail: email, applicationID: applicationID, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.ApplicationID)", value: applicationID)
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.Email)", value: email)
		
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
		let urlString: 				String = NSLocalizedString("RelativeMembersSelectByEmailUrl", tableName: "RESTWebAPIConfig", comment: "")
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byEmail email: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, currentRelativeMemberID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN")) {
				
				self.selectDummy(byEmail: email, applicationID: applicationID, connectionContractType: connectionContractType, currentRelativeMemberID: currentRelativeMemberID, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.ApplicationID)", value: applicationID)
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.Email)", value: email)
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.CurrentRelativeMemberID)", value: currentRelativeMemberID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeMembersSelectByEmailConnectionContractTypeCurrentRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   String(connectionContractType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byID id: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, currentRelativeMemberID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN")) {
				
				self.selectDummy(byID: id, applicationID: applicationID, connectionContractType: connectionContractType, currentRelativeMemberID: currentRelativeMemberID, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.ApplicationID)", value: applicationID)
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.CurrentRelativeMemberID)", value: currentRelativeMemberID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeMembersSelectByIDConnectionContractTypeCurrentRelativeMemberIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   id,
											   String(connectionContractType.rawValue))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
		
	fileprivate func runQuery(byFindText findText: String, applicationID: String, currentRelativeMemberID: String?, scopeType: RelativeMemberScopeTypes, previousRelativeMemberID: String, numberOfItemsToLoad: Int, selectItemsAfterPreviousYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN")) {
				
				self.selectDummy(byFindText: findText, applicationID: applicationID, currentRelativeMemberID: currentRelativeMemberID, scopeType: scopeType, previousRelativeMemberID: previousRelativeMemberID, numberOfItemsToLoad: numberOfItemsToLoad, selectItemsAfterPreviousYN: selectItemsAfterPreviousYN, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.ApplicationID)", value: applicationID)
		
		// FindText
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.FindText)", value: findText)
		
		// CurrentRelativeMemberID
		if (currentRelativeMemberID != nil) {
			
			dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.CurrentRelativeMemberID)", value: currentRelativeMemberID!)
			
		}
		
		// PreviousRelativeMemberID
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.PreviousRelativeMemberID)", value: previousRelativeMemberID)

		// SelectItemsAfterPreviousYN
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.SelectItemsAfterPreviousYN)", value: "\(selectItemsAfterPreviousYN)")
		
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
		var urlString: 				String = NSLocalizedString("RelativeMembersSelectByFindTextUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   String(scopeType.rawValue),
											   String(numberOfItemsToLoad))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byAspects aspectTypes: [RelativeMemberQueryAspectTypes], applicationID: String, maxResults: Int, currentRelativeMemberID: String?, scopeType: RelativeMemberScopeTypes, previousRelativeMemberID: String, numberOfItemsToLoad: Int, selectItemsAfterPreviousYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN")) {
				
				self.selectDummy(byAspects: aspectTypes, applicationID: applicationID, maxResults: maxResults, currentRelativeMemberID: currentRelativeMemberID, scopeType: scopeType, previousRelativeMemberID: previousRelativeMemberID, numberOfItemsToLoad: numberOfItemsToLoad, selectItemsAfterPreviousYN: selectItemsAfterPreviousYN, into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.ApplicationID)", value: applicationID)
		
		// AspectTypes
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.AspectTypes)", value: self.join(array: aspectTypes))
		
		// CurrentRelativeMemberID
		if (currentRelativeMemberID != nil) {
			
			dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.CurrentRelativeMemberID)", value: currentRelativeMemberID!)
			
		}
		
		// PreviousRelativeMemberID
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.PreviousRelativeMemberID)", value: previousRelativeMemberID)
		
		// SelectItemsAfterPreviousYN
		dataWrapper.setParameterValue(key: "\(RelativeMemberDataParameterKeys.SelectItemsAfterPreviousYN)", value: "\(selectItemsAfterPreviousYN)")
		
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
		var urlString: 				String = NSLocalizedString("RelativeMembersSelectByAspectsUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   String(maxResults),
											   String(scopeType.rawValue),
											   String(numberOfItemsToLoad))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func join(array: [RelativeMemberQueryAspectTypes]) -> String {
		
		var result = ""
		
		for item in array {
			
			// Add separator
			if (result.count > 0) {
				
				result += ","
				
			}
			
			result += "\(item.rawValue)"
		}
		
		return result
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Dummy Data Methods
	
	fileprivate func selectDummy(byUserProfileID userProfileID: String, applicationID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byUserProfileID", tableName: "RelativeMembersDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byEmail email: String, applicationID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byEmail", tableName: "RelativeMembersDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byEmail email: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, currentRelativeMemberID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byEmail_connectionContractType_" + "\(connectionContractType.rawValue)" + "_currentRelativeMemberID", tableName: "RelativeMembersDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byID id: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, currentRelativeMemberID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byID_connectionContractType_" + "\(connectionContractType.rawValue)" + "_currentRelativeMemberID", tableName: "RelativeMembersDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
	fileprivate func selectDummy(byFindText findText: String, applicationID: String, currentRelativeMemberID: String?, scopeType: RelativeMemberScopeTypes, previousRelativeMemberID: String, numberOfItemsToLoad: Int, selectItemsAfterPreviousYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byFindText_scopeType_previousRelativeMemberID", tableName: "RelativeMembersDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}

	fileprivate func selectDummy(byAspects aspectTypes: [RelativeMemberQueryAspectTypes], applicationID: String, maxResults: Int, currentRelativeMemberID: String?, scopeType: RelativeMemberScopeTypes, previousRelativeMemberID: String, numberOfItemsToLoad: Int, selectItemsAfterPreviousYN: Bool, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byAspects_aspectTypes_scopeType_previousRelativeMemberID", tableName: "RelativeMembersDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
}

// MARK: - Extension ProtocolRelativeMemberModelAccessStrategy

extension RelativeMemberRESTWebAPIModelAccessStrategy: ProtocolRelativeMemberModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byUserProfileID userProfileID: String, applicationID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byUserProfileID: userProfileID, applicationID: applicationID, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byEmail email: String, applicationID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byEmail: email, applicationID: applicationID, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byEmail email: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, currentRelativeMemberID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byEmail: email, applicationID: applicationID, connectionContractType: connectionContractType, currentRelativeMemberID: currentRelativeMemberID, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byID id: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, currentRelativeMemberID: String, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byID: id, applicationID: applicationID, connectionContractType: connectionContractType, currentRelativeMemberID: currentRelativeMemberID, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byFindText findText: String, applicationID: String, currentRelativeMemberID: String?, scopeType: RelativeMemberScopeTypes, previousRelativeMemberID: String, numberOfItemsToLoad: Int, selectItemsAfterPreviousYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byFindText: findText,
					  applicationID: applicationID,
					  currentRelativeMemberID: currentRelativeMemberID,
					  scopeType: scopeType,
					  previousRelativeMemberID: previousRelativeMemberID,
					  numberOfItemsToLoad: numberOfItemsToLoad,
					  selectItemsAfterPreviousYN: selectItemsAfterPreviousYN,
					  into: collection, oncomplete: runQueryCompletionHandler)
		
	}

	public func select(byAspects aspectTypes: [RelativeMemberQueryAspectTypes], applicationID: String, maxResults: Int, currentRelativeMemberID: String?, scopeType: RelativeMemberScopeTypes, previousRelativeMemberID: String, numberOfItemsToLoad: Int, selectItemsAfterPreviousYN: Bool, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byAspects: aspectTypes,
					  applicationID: applicationID,
					  maxResults: maxResults,
					  currentRelativeMemberID: currentRelativeMemberID,
					  scopeType: scopeType,
					  previousRelativeMemberID: previousRelativeMemberID,
					  numberOfItemsToLoad: numberOfItemsToLoad,
					  selectItemsAfterPreviousYN: selectItemsAfterPreviousYN,
					  into: collection, oncomplete: runQueryCompletionHandler)
		
	}

}

