//
//  RelativeConnectionFirebaseModelAccessStrategy.swift
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
	case fromRelativeMemberid
	case toRelativeMemberid
	case connectioncontracttype
}

/// A strategy for accessing the RelativeConnection model data using Firebase
public class RelativeConnectionFirebaseModelAccessStrategy: FirebaseModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "relativeConnections")
		
		self.databaseReference = Database.database().reference(withPath: self.tableName)
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func runQuery(byFromRelativeMemberID fromRelativeMemberID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnections_connectionContractType\(connectionContractType.rawValue)_byFromRelativeMember/\(fromRelativeMemberID)/"
		
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

	fileprivate func runQuery(byToRelativeMemberID toRelativeMemberID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 		String = "relativeConnections_connectionContractType\(connectionContractType.rawValue)_byToRelativeMember/\(toRelativeMemberID)/"
		
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

	fileprivate func runQuery(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnections_connectionContractType\(connectionContractType.rawValue)_byFromRelativeMember/\(fromRelativeMemberID)/"
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference(withPath: fromRelativeMemberPath)
		
		// Call Firebase query
		reference.queryOrdered(byChild: "\(QueryParameterKeys.toRelativeMemberid)").queryEqual(toValue: toRelativeMemberID).observeSingleEvent(of: .value, with:
			{
				(snapshot) in
				
				reference.removeAllObservers()
				
				// Process the snapshot to data
				let data: [String:Any] = [self.tableName:self.toData(from: snapshot, usingTemplate: collection)]
				
				// Call completion handler
				completionHandler(data, nil)
				
		})
		
	}
	
	fileprivate func doRunQueryDelete(modelItemKey: String, connectionContractType: String, fromRelativeMemberID: String, toRelativeMemberID: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference()
		
		// Create relativeConnectionsPath
		let relativeConnectionsPath: 	String = "relativeConnections_connectionContractType\(connectionContractType)/\(modelItemKey)"
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnections_connectionContractType\(connectionContractType)_byFromRelativeMember/\(fromRelativeMemberID)/\(modelItemKey)"
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 			String = "relativeConnections_connectionContractType\(connectionContractType)_byToRelativeMember/\(toRelativeMemberID)/\(modelItemKey)"
		
		// Create the fan-out node with nil values
		let fanoutNode: [String : Any] = [relativeConnectionsPath: 	NSNull(),
										  fromRelativeMemberPath: 		NSNull(),
										  toRelativeMemberPath: 		NSNull()]
		
		// Save atomic fan-out node
		reference.updateChildValues(fanoutNode) { (error, reference) -> Void in
			
			reference.removeAllObservers()
			
			// Call completion handler
			completionHandler(nil, nil)
		}
		
	}
	
	fileprivate func runQuery(byWithRelativeMemberID withRelativeMemberID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnections_connectionContractType\(connectionContractType.rawValue)_byFromRelativeMember/\(withRelativeMemberID)/"

		// Create toRelativeMemberPath
		let toRelativeMemberPath: 			String = "relativeConnections_connectionContractType\(connectionContractType.rawValue)_byToRelativeMember/\(withRelativeMemberID)/"
		
		// Create database reference
		let fromRelativeMemberReference: 	DatabaseReference = Database.database().reference(withPath: fromRelativeMemberPath)
		let toRelativeMemberReference: 	DatabaseReference = Database.database().reference(withPath: toRelativeMemberPath)
		
		// Call Firebase query
		fromRelativeMemberReference.observeSingleEvent(of: .value, with:
			{
				(fromRelativeMemberSnapshot) in
				
				fromRelativeMemberReference.removeAllObservers()
				
				// Process the snapshot to data
				let fromRelativeMemberData: [Any] = self.toData(from: fromRelativeMemberSnapshot, usingTemplate: collection)
				
				// Retrieve snapshot for toRelativeMembers
				toRelativeMemberReference.observeSingleEvent(of: .value, with:
					{
						(toRelativeMemberSnapshot) in
						
						toRelativeMemberReference.removeAllObservers()
						
						// Process the snapshot to data
						let toRelativeMemberData: [Any] = self.toData(from: toRelativeMemberSnapshot, usingTemplate: collection)
						
						// Merge the data to return
						var items: [Any] = [Any]()
						items.append(contentsOf: fromRelativeMemberData)
						items.append(contentsOf: toRelativeMemberData)
						
						let data: [String:Any] = [self.tableName:items]
						
						// Call completion handler
						completionHandler(data, nil)
						
					})
		
		})
		
	}

	fileprivate func runQuery(forRelativeMemberID: String, byWithRelativeMemberID withRelativeMemberID: String, connectionContractType: RelativeConnectionContractTypes, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnections_connectionContractType\(connectionContractType.rawValue)_byFromRelativeMember/\(forRelativeMemberID)/"
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 			String = "relativeConnections_connectionContractType\(connectionContractType.rawValue)_byToRelativeMember/\(forRelativeMemberID)/"
		
		// Create database reference
		let fromRelativeMemberReference: 	DatabaseReference = Database.database().reference(withPath: fromRelativeMemberPath)
		let toRelativeMemberReference: 	DatabaseReference = Database.database().reference(withPath: toRelativeMemberPath)
		
		// Call Firebase query
		fromRelativeMemberReference.queryOrdered(byChild: "\(QueryParameterKeys.toRelativeMemberid)").queryEqual(toValue: withRelativeMemberID).observeSingleEvent(of: .value, with:
			{
				(fromRelativeMemberSnapshot) in
				
				fromRelativeMemberReference.removeAllObservers()
				
				// Process the snapshot to data
				let fromRelativeMemberData: [Any] = self.toData(from: fromRelativeMemberSnapshot, usingTemplate: collection)
				
				// Retrieve snapshot for toRelativeMembers
				toRelativeMemberReference.queryOrdered(byChild: "\(QueryParameterKeys.fromRelativeMemberid)").queryEqual(toValue: withRelativeMemberID).observeSingleEvent(of: .value, with:
					{
						(toRelativeMemberSnapshot) in
						
						toRelativeMemberReference.removeAllObservers()
						
						// Process the snapshot to data
						let toRelativeMemberData: [Any] = self.toData(from: toRelativeMemberSnapshot, usingTemplate: collection)
						
						// Merge the data to return
						var items: [Any] = [Any]()
						items.append(contentsOf: fromRelativeMemberData)
						items.append(contentsOf: toRelativeMemberData)
						
						let data: [String:Any] = [self.tableName:items]
						
						// Call completion handler
						completionHandler(data, nil)
						
				})
				
		})
		
	}
	
	
	// MARK: - Override Methods
	
	public override func doRunQueryInsert(modelItemKey: String, node: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {

		let connectionContractType: 	String = node["\(QueryParameterKeys.connectioncontracttype)"] as! String
		let fromRelativeMemberID: 		String = node["\(QueryParameterKeys.fromRelativeMemberid)"] as! String
		let toRelativeMemberID: 		String = node["\(QueryParameterKeys.toRelativeMemberid)"] as! String
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference()
		
		// Create relativeConnectionsPath
		let relativeConnectionsPath: 	String = "relativeConnections_connectionContractType\(connectionContractType)/\(modelItemKey)"
		
		// Create fromRelativeMemberPath
		let fromRelativeMemberPath: 		String = "relativeConnections_connectionContractType\(connectionContractType)_byFromRelativeMember/\(fromRelativeMemberID)/\(modelItemKey)"
		
		// Create toRelativeMemberPath
		let toRelativeMemberPath: 			String = "relativeConnections_connectionContractType\(connectionContractType)_byToRelativeMember/\(toRelativeMemberID)/\(modelItemKey)"
		
		// Create the fan-out node
		let fanoutNode: [String : Any] = [relativeConnectionsPath: 	node,
										  fromRelativeMemberPath: 	node,
										  toRelativeMemberPath: 	node]

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
		
		// Get connectionContractType parameter
		let connectionContractType: 	String = (parameters!.get(parameterName: "\(QueryParameterKeys.connectioncontracttype)") as! ModelAccessParameter).value as! String

		// Get fromRelativeMemberID parameter
		let fromRelativeMemberID: 			String = (parameters!.get(parameterName: "\(QueryParameterKeys.fromRelativeMemberid)") as! ModelAccessParameter).value as! String
		
		// Get toRelativeMemberID parameter
		let toRelativeMemberID: 			String = (parameters!.get(parameterName: "\(QueryParameterKeys.toRelativeMemberid)") as! ModelAccessParameter).value as! String
		
		// Run the delete query
		self.doRunQueryDelete(modelItemKey: modelItemKey, connectionContractType: connectionContractType, fromRelativeMemberID: fromRelativeMemberID, toRelativeMemberID: toRelativeMemberID, oncomplete: completionHandler)
	}
	
}

// MARK: - Extension ProtocolRelativeConnectionModelAccessStrategy

extension RelativeConnectionFirebaseModelAccessStrategy: ProtocolRelativeConnectionModelAccessStrategy {

	// MARK: - Public Methods
	
	public func select(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
        
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
        
        // Run the query
		self.runQuery(byFromRelativeMemberID: fromRelativeMemberID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
        
    }

	public func select(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byToRelativeMemberID: toRelativeMemberID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}

	public func select(fromRelativeMemberID: String, byToRelativeMemberID toRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler: @escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(fromRelativeMemberID: fromRelativeMemberID, byToRelativeMemberID: toRelativeMemberID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}

	public func select(byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(byWithRelativeMemberID: withRelativeMemberID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}

	public func select(forRelativeMemberID: String, byWithRelativeMemberID withRelativeMemberID: String, applicationID: String, connectionContractType: RelativeConnectionContractTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) = self.getRunQueryCompletionHandler(collection: collection, oncomplete: completionHandler)
		
		// Run the query
		self.runQuery(forRelativeMemberID: forRelativeMemberID, byWithRelativeMemberID: withRelativeMemberID, connectionContractType: connectionContractType, into: collection, oncomplete: runQueryCompletionHandler)
		
	}
	
}
