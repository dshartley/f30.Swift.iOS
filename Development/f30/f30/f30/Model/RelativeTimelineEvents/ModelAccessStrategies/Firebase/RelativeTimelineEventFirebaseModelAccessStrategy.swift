//
//  RelativeTimelineEventFirebaseModelAccessStrategy.swift
//  f30
//
//  Created by David on 04/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSocial
import f30Model
import FirebaseDatabase
import FirebaseStorage

/// Specifies query parameter keys
fileprivate enum QueryParameterKeys : Int {
	case forrelativememberid
}

/// A strategy for accessing the RelativeTimelineEvent model data using Firebase
public class RelativeTimelineEventFirebaseModelAccessStrategy: FirebaseModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "relativeTimelineEvents")
		
		self.databaseReference = Database.database().reference(withPath: self.tableName)
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func doRunQueryInsert(modelItemKey: String, node: [String:Any], forRelativeMemberIDs: [String], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create database reference
		let reference: 				DatabaseReference = Database.database().reference()

		var node = node
		
		// Create the fan-out node
		var fanoutNode: 			[String : Any] = [:]
		
		var forRelativeMemberPath: 	String = ""

		// Go through each forUserProfileID
		for id in forRelativeMemberIDs {
			
			// Create forUserProfilePath
			forRelativeMemberPath = "relativeTimelineEvents_byForRelativeMember/\(id)/\(modelItemKey)"
			
			// Set forRelativeMemberID in the node
			node["\(QueryParameterKeys.forrelativememberid)"] = id
			
			fanoutNode[forRelativeMemberPath] = node
			
		}

		// Save atomic fan-out node
		reference.updateChildValues(fanoutNode) { (error, reference) -> Void in

			reference.removeAllObservers()

			// Call completion handler
			completionHandler([self.rootKey: node], nil)
		}
		
	}
	
	fileprivate func runQuery(byForRelativeMemberID forRelativeMemberID: String, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create forRelativeMemberPath
		let forRelativeMemberPath: 		String = "relativeTimelineEvents_byForRelativeMember/\(forRelativeMemberID)/"
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference(withPath: forRelativeMemberPath)
		
		// Call Firebase query
		reference.observeSingleEvent(of: .value, with:
			{
				(snapshot) in
				
				reference.removeAllObservers()
				
				// Process the snapshot to data
				let data: [String:Any] = [self.tableName:self.toData(from: snapshot, usingTemplate: collection)]
				
				// Call completion handler
				completionHandler(data, nil)
				
		})
		
	}
	
}

// MARK: - Extension ProtocolRelativeTimelineEventModelAccessStrategy

extension RelativeTimelineEventFirebaseModelAccessStrategy: ProtocolRelativeTimelineEventModelAccessStrategy {

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
			(data, error) -> Void in

			// Update the status of the item
			item.status = ModelItemStatusTypes.unmodified
			
			// Call the completion handler
			completionHandler(item.id, nil)
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
			
		// Not implemented
	}
	
	public func select(byRelativeInteractionID relativeInteractionID: String,
					   applicationID: String,
					   collection: ProtocolModelItemCollection,
					   oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Not implemented
		
	}
	
}
