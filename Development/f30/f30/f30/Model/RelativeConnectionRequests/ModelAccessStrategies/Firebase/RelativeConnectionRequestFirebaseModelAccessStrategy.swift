//
//  RelativeConnectionRequestFirebaseModelAccessStrategy.swift
//  f30
//
//  Created by David on 04/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSocial
import f30Core
import f30Model
import FirebaseDatabase
import FirebaseStorage

/// Specifies query parameter keys
fileprivate enum QueryParameterKeys : Int {
	case fromrelativememberid
	case torelativememberid
	case requesttype
}

/// A strategy for accessing the RelativeConnectionRequest model data using Firebase
public class RelativeConnectionRequestFirebaseModelAccessStrategy: FirebaseModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "relativeConnectionRequests")
		
		self.databaseReference = Database.database().reference(withPath: self.tableName)
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byFromRelativeMemberID fromRelativeMemberID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnectionRequests_requestType\(requestType.rawValue)_byFromRelativeMember/\(fromRelativeMemberID)/"
		
		// Create database reference
		let reference: DatabaseReference = Database.database().reference(withPath: fromRelativeMemberPath)
		
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
	
	fileprivate func runQuery(byToRelativeMemberID toRelativeMemberID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 		String = "relativeConnectionRequests_requestType\(requestType.rawValue)_byToRelativeMember/\(toRelativeMemberID)/"
		
		// Create database reference
		let reference: 				DatabaseReference = Database.database().reference(withPath: toRelativeMemberPath)
		
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
	
	fileprivate func runQuery(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, requestType: RelativeConnectionRequestTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnectionRequests_requestType\(requestType.rawValue)_byFromRelativeMember/\(fromRelativeMemberID)/"

		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference(withPath: fromRelativeMemberPath)
		
		// Call Firebase query
		reference.queryOrdered(byChild: "\(QueryParameterKeys.torelativememberid)").queryEqual(toValue: toRelativeMemberID).observeSingleEvent(of: .value, with:
			{
				(snapshot) in
				
				reference.removeAllObservers()
				
				// Process the snapshot to data
				let data: [String:Any] = [self.tableName:self.toData(from: snapshot, usingTemplate: collection)]
				
				// Call completion handler
				completionHandler(data, nil)
				
		})
		
	}
	
	fileprivate func doRunQueryDelete(modelItemKey: String, requestType: String, fromRelativeMemberID: String, toRelativeMemberID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference()
		
		// Create relativeConnectionRequestsPath
		let relativeConnectionRequestsPath: 	String = "relativeConnectionRequests_requestType\(requestType)/\(modelItemKey)"
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 				String = "relativeConnectionRequests_requestType\(requestType)_byFromRelativeMember/\(fromRelativeMemberID)/\(modelItemKey)"
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 					String = "relativeConnectionRequests_requestType\(requestType)_byToRelativeMember/\(toRelativeMemberID)/\(modelItemKey)"
		
		// Create the fan-out node with nil values
		let fanoutNode: [String : Any] = [relativeConnectionRequestsPath: 	NSNull(),
										  fromRelativeMemberPath: 				NSNull(),
										  toRelativeMemberPath: 				NSNull()]
		
		// Save atomic fan-out node
		reference.updateChildValues(fanoutNode) { (error, reference) -> Void in
			
			reference.removeAllObservers()
			
			// Call completion handler
			completionHandler(nil, nil)
		}
		
	}
	
	
	// MARK: - Override Methods
	
	public override func doRunQueryInsert(modelItemKey: String, node: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let requestType: 				String = node["\(QueryParameterKeys.requesttype)"] as! String
		let fromRelativeMemberID: 			String = node["\(QueryParameterKeys.fromrelativememberid)"] as! String
		let toRelativeMemberID: 			String = node["\(QueryParameterKeys.torelativememberid)"] as! String
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference()
		
		// Create relativeConnectionRequestsPath
		let relativeConnectionRequestsPath: 	String = "relativeConnectionRequests_requestType\(requestType)/\(modelItemKey)"
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 				String = "relativeConnectionRequests_requestType\(requestType)_byFromRelativeMember/\(fromRelativeMemberID)/\(modelItemKey)"
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 					String = "relativeConnectionRequests_requestType\(requestType)_byToRelativeMember/\(toRelativeMemberID)/\(modelItemKey)"
		
		// Create the fan-out node
		let fanoutNode: [String : Any] = [relativeConnectionRequestsPath: 	node,
										  fromRelativeMemberPath: 				node,
										  toRelativeMemberPath: 				node]
		
		// Save atomic fan-out node
		reference.updateChildValues(fanoutNode) { (error, reference) -> Void in
			
			reference.removeAllObservers()
			
			// Call completion handler
			completionHandler([self.rootKey: node], nil)
		}
		
	}
	
	public override func doRunQueryUpdate(modelItemKey: String, node: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		let requestType: 				String = node["\(QueryParameterKeys.requesttype)"] as! String
		let fromRelativeMemberID: 			String = node["\(QueryParameterKeys.fromrelativememberid)"] as! String
		let toRelativeMemberID: 			String = node["\(QueryParameterKeys.torelativememberid)"] as! String
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference()
		
		// Create relativeConnectionRequestsPath
		let relativeConnectionRequestsPath: 	String = "relativeConnectionRequests_requestType\(requestType)/\(modelItemKey)"
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 				String = "relativeConnectionRequests_requestType\(requestType)_byFromRelativeMember/\(fromRelativeMemberID)/\(modelItemKey)"
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 					String = "relativeConnectionRequests_requestType\(requestType)_byToRelativeMember/\(toRelativeMemberID)/\(modelItemKey)"
		
		// Create the fan-out node
		let fanoutNode: [String : Any] = [relativeConnectionRequestsPath: 	node,
										  fromRelativeMemberPath: 				node,
										  toRelativeMemberPath: 				node]
		
		// Save atomic fan-out node
		reference.updateChildValues(fanoutNode) { (error, reference) -> Void in
			
			reference.removeAllObservers()
			
			// Call completion handler
			completionHandler([self.rootKey: node], nil)
		}
		
	}
	
	open override func runQuery(delete attributes: [String : Any], with parameters: ProtocolParametersCollection?, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get the model item key from the primary key column parameter
		let parameter:					ModelAccessParameter = parameters!.get(parameterName: self.primaryKeyColumnName) as! ModelAccessParameter
		let modelItemKey:				String = parameter.value as! String
		
		// Get requestType parameter
		let requestType: 				String = (parameters!.get(parameterName: "\(QueryParameterKeys.requesttype)") as! ModelAccessParameter).value as! String
		
		// Get fromRelativeMemberID parameter
		let fromRelativeMemberID: 			String = (parameters!.get(parameterName: "\(QueryParameterKeys.fromrelativememberid)") as! ModelAccessParameter).value as! String
		
		// Get toRelativeMemberID parameter
		let toRelativeMemberID: 			String = (parameters!.get(parameterName: "\(QueryParameterKeys.torelativememberid)") as! ModelAccessParameter).value as! String
		
		// Run the delete query
		self.doRunQueryDelete(modelItemKey: modelItemKey, requestType: requestType, fromRelativeMemberID: fromRelativeMemberID, toRelativeMemberID: toRelativeMemberID, oncomplete: completionHandler)
		
	}
	
}

// MARK: - Extension ProtocolRelativeConnectionRequestModelAccessStrategy

extension RelativeConnectionRequestFirebaseModelAccessStrategy: ProtocolRelativeConnectionRequestModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byFromRelativeMemberID: fromRelativeMemberID, requestType: requestType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byToRelativeMemberID: toRelativeMemberID, requestType: requestType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
	public func select(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, requestType: RelativeConnectionRequestTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(fromRelativeMemberID: fromRelativeMemberID, byToRelativeMemberID: toRelativeMemberID, requestType: requestType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
}
