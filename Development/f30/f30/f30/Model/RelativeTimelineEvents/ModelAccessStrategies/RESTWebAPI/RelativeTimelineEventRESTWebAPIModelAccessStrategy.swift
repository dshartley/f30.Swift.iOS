//
//  RelativeTimelineEventsRESTWebAPIModelAccessStrategy.swift
//  f30
//
//  Created by David on 04/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import SFSocial
import SFSerialization
import SFNet
import f30Model
import FirebaseDatabase
import FirebaseStorage

/// A strategy for accessing the RelativeTimelineEvent model data using a REST Web API
public class RelativeTimelineEventsRESTWebAPIModelAccessStrategy: RESTWebAPIModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "RelativeTimelineEvents")

	}
	
	
	// MARK: - Private Methods
	
	fileprivate func doRunQueryInsert(modelItemKey: String, node: [String:Any], forRelativeMemberIDs: [String], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// TODO:
		
		// Call completion handler
		completionHandler([self.rootKey: node], nil)
		
	}
	
	fileprivate func runQuery(byForRelativeMemberID forRelativeMemberID: String,
							  applicationID: String,
							  currentRelativeMemberID: String,
							  scopeType: RelativeTimelineEventScopeTypes,
							  relativeTimelineEventTypes: [RelativeTimelineEventTypes],
							  previousRelativeTimelineEventID: String,
							  numberOfItemsToLoad: Int,
							  selectItemsAfterPreviousYN: Bool,
							  into collection: ProtocolModelItemCollection,
							  oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeTimelineEventsDummyDataYN")) {
				
				self.selectDummy(byForRelativeMemberID: forRelativeMemberID,
								 applicationID: applicationID,
								 currentRelativeMemberID: currentRelativeMemberID,
								 scopeType: scopeType,
								 relativeTimelineEventTypes: relativeTimelineEventTypes,
								 previousRelativeTimelineEventID: previousRelativeTimelineEventID,
								 numberOfItemsToLoad: numberOfItemsToLoad,
								 selectItemsAfterPreviousYN: selectItemsAfterPreviousYN,
								 into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeTimelineEventDataParameterKeys.ApplicationID)", value: applicationID)
		
		// CurrentRelativeMemberID
		dataWrapper.setParameterValue(key: "\(RelativeTimelineEventDataParameterKeys.CurrentRelativeMemberID)", value: currentRelativeMemberID)
		
		// PreviousRelativeTimelineEventID
		dataWrapper.setParameterValue(key: "\(RelativeTimelineEventDataParameterKeys.PreviousRelativeTimelineEventID)", value: previousRelativeTimelineEventID)
		
		// SelectItemsAfterPreviousYN
		dataWrapper.setParameterValue(key: "\(RelativeTimelineEventDataParameterKeys.SelectItemsAfterPreviousYN)", value: "\(selectItemsAfterPreviousYN)")
		
		// RelativeTimelineEventTypes
		dataWrapper.setParameterValue(key: "\(RelativeTimelineEventDataParameterKeys.RelativeTimelineEventTypes)", value: self.join(array: relativeTimelineEventTypes))
		
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
		var urlString: 				String = NSLocalizedString("RelativeTimelineEventsSelectByForRelativeMemberIDPreviousRelativeTimelineEventIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString,
											   forRelativeMemberID,
											   String(scopeType.rawValue),
											   String(numberOfItemsToLoad))
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func runQuery(byRelativeInteractionID relativeInteractionID: String,
							  applicationID: String,
							  into collection: ProtocolModelItemCollection,
							  oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "LoadRelativeTimelineEventsDummyDataYN")) {
				
				self.selectDummy(byRelativeInteractionID: relativeInteractionID,
								 applicationID: applicationID,
								 into: collection, oncomplete: completionHandler)
				
				return
				
			}
			
		#endif
		
		// Create the dataWrapper
		let dataWrapper:			DataJSONWrapper = DataJSONWrapper()
		dataWrapper.setParameterValue(key: "\(RelativeTimelineEventDataParameterKeys.ApplicationID)", value: applicationID)
		
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
		var urlString: 				String = NSLocalizedString("RelativeTimelineEventsSelectByRelativeInteractionIDUrl", tableName: "RESTWebAPIConfig", comment: "")
		urlString 					= String(format: urlString, relativeInteractionID)
		
		// Call the REST Api
		restApiHelper.call(urlString: urlString, httpMethod: .POST, data: dataWrapper)
		
	}
	
	fileprivate func join(array: [RelativeTimelineEventTypes]) -> String {
		
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
	
	
	// MARK: - Dummy Data Methods
	
	fileprivate func selectDummy(byForRelativeMemberID forRelativeMemberID: String,
								 applicationID: String,
								 currentRelativeMemberID: String,
								 scopeType: RelativeTimelineEventScopeTypes,
								 relativeTimelineEventTypes: [RelativeTimelineEventTypes],
								 previousRelativeTimelineEventID: String?,
								 numberOfItemsToLoad: Int,
								 selectItemsAfterPreviousYN: Bool,
								 into collection: ProtocolModelItemCollection,
								 oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		var responseString	= NSLocalizedString("byForRelativeMemberID_previousRelativeTimelineEventID", tableName: "RelativeTimelineEventsDummyRESTWebAPIResponse", comment: "")
		
		// Dummy data for a refresh load, ie selectItemsAfterPreviousYN = false
		if (!selectItemsAfterPreviousYN) {
			
			responseString	= NSLocalizedString("byForRelativeMemberID_previousRelativeTimelineEventID_selectItemsAfterPreviousYN_false", tableName: "RelativeTimelineEventsDummyRESTWebAPIResponse", comment: "")
			
		}
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}

	fileprivate func selectDummy(byRelativeInteractionID relativeInteractionID: String,
								 applicationID: String,
								 into collection: ProtocolModelItemCollection,
								 oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let responseString	= NSLocalizedString("byRelativeInteractionID", tableName: "RelativeTimelineEventsDummyRESTWebAPIResponse", comment: "")
		
		// Convert the response to JSON dictionary
		let data:			[String:Any]? = JSONHelper.stringToJSON(jsonString: responseString) as? [String:Any]
		
		// Process the data
		let returnData:		[String:Any]? = self.processRESTWebAPIResponse(responseData: data!)
		
		// Call the completion handler
		completionHandler(returnData, nil)
		
	}
	
}

// MARK: - Extension ProtocolRelativeTimelineEventModelAccessStrategy

extension RelativeTimelineEventsRESTWebAPIModelAccessStrategy: ProtocolRelativeTimelineEventModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func insert(item: ProtocolModelItem, forRelativeMemberIDs: [String], oncomplete completionHandler:@escaping (String, Error?) -> Void) {
		
		var item: 			ProtocolModelItem = item
		
		// Get the key of the new child
		let modelItemKey: 	String = self.getChildAutoId()
		
		item.id = modelItemKey
		
		// Get the query parameters
		let parameters: 	ProtocolParametersCollection? = self.buildParameters(item: item, outputParametersYN: false)
		
		// Create the node
		let node:			[String:Any] = self.createNode(with: parameters, collection: item.collection!)
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(data, error) -> Void in	// [weak self]
			
			// Update the status of the item
			item.status = ModelItemStatusTypes.unmodified
			
			// Call the completion handler
			completionHandler(item.id, error)
		}
		
		// Run the insert query
		self.doRunQueryInsert(modelItemKey: modelItemKey, node: node, forRelativeMemberIDs: forRelativeMemberIDs, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byForRelativeMemberID forRelativeMemberID: String,
					   applicationID: String,
					   currentRelativeMemberID: String,
					   scopeType: RelativeTimelineEventScopeTypes,
					   relativeTimelineEventTypes: [RelativeTimelineEventTypes],
					   previousRelativeTimelineEventID: String,
					   numberOfItemsToLoad: Int,
					   selectItemsAfterPreviousYN: Bool,
					   collection: ProtocolModelItemCollection,
					   oncomplete completionHandler: @escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byForRelativeMemberID: forRelativeMemberID,
					  applicationID: applicationID,
					  currentRelativeMemberID: currentRelativeMemberID,
					  scopeType: scopeType,
					  relativeTimelineEventTypes: relativeTimelineEventTypes,
					  previousRelativeTimelineEventID: previousRelativeTimelineEventID,
					  numberOfItemsToLoad: numberOfItemsToLoad,
					  selectItemsAfterPreviousYN: selectItemsAfterPreviousYN,
					  into: collection,
					  oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byRelativeInteractionID relativeInteractionID: String,
				applicationID: String,
				collection: ProtocolModelItemCollection,
				oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byRelativeInteractionID: relativeInteractionID,
					  applicationID: applicationID,
					  into: collection,
					  oncomplete: runQueryCompletionHandler)
		
	}
	
}
