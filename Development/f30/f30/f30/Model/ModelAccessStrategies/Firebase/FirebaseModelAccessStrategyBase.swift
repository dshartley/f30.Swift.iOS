//
//  FirebaseModelAccessStrategyBase.swift
//  Smart.Foundation
//
//  Created by David on 30/07/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFCore
import SFModel
import FirebaseDatabase

/// A base class for strategies for accessing model data using Firebase
open class FirebaseModelAccessStrategyBase: ModelAccessStrategyBase {
	
	// MARK: - Public Stored Properties
	
	public var databaseReference: DatabaseReference? = nil
	
	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter)
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter,
						 tableName: String) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: tableName)
	}

	
	// MARK: - Public Methods
	
	public func toData(from snapshot: DataSnapshot, usingTemplate collection: ProtocolModelItemCollection) -> [Any] {
		
		// Get a model item to use for iterating property keys
		let modelItem: ProtocolModelItem = collection.getNewItem()!
		
		var result = [Any]()
			
		// Go through each node
		for node in snapshot.children {
			
			let node				= node as! DataSnapshot
			
			// Get the node properties
			let properties			= node.value as! [String: AnyObject]
			
			// Create the item
			var item				= [String: Any]()
			
			// Iterate through the property keys
			for key in modelItem.getPropertyKeys() {
				
				// Put the property in the item
				item[key] = properties[key]

			}
			
			// Add the item to the array
			result.append(item)
		}

		return result
	}
	

	// MARK: - Open [Overridable] Methods
	
	open func getChildAutoId() -> String {
		
		// Get database reference to new child
		let childReference:		DatabaseReference = self.databaseReference!.childByAutoId()
		
		// Get the key of the child
		let key:				String = childReference.key
		
		return key
		
	}
	
	open func doRunQueryInsert(modelItemKey: String, node: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get database reference to child
		let childReference = self.databaseReference!.child(modelItemKey)
		
		// Save node to child
		childReference.setValue(node) { (error, reference) -> Void in
			
			childReference.removeAllObservers()
			
			// Call completion handler
			completionHandler([self.rootKey: node], nil)
		}
		
	}

	open func doRunQueryUpdate(modelItemKey: String, node: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get database reference to child
		let childReference = self.databaseReference!.child(modelItemKey)
		
		// Save node to child
		childReference.updateChildValues(node) { (error, reference) -> Void in
			
			childReference.removeAllObservers()
			
			// Call completion handler
			completionHandler([self.rootKey: node], nil)
		}
		
	}
	
	open func doRunQueryDelete(modelItemKey: String, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get database reference to child
		let childReference = self.databaseReference!.child(modelItemKey)
		
		// Remove the child
		childReference.removeValue{(error, reference) -> Void in
			
			childReference.removeAllObservers()
			
			// Call completion handler
			completionHandler(nil, nil)
		}
		
	}
	
	open func getRunQueryCompletionHandler(collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) -> (([String:Any]?, Error?) -> Void) {
		
		// Create completion handler
		let runQueryCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			[weak self] (data, error) -> Void in
			
			guard let strongSelf = self else {
				
				// Call the completion handler
				completionHandler(data, collection, error)
				return
				
			}
			
			var collection = collection
			
			// Fill the collection with the loaded data
			collection = strongSelf.fillCollection(collection: collection, data: data![strongSelf.tableName] as! [Any])!
			
			// Call the completion handler
			completionHandler(data, collection, error)
			
		}
		
		return runQueryCompletionHandler
	}

	
	// MARK: - Override Methods
	
	open override func runQuery(insert attributes: [String : Any], with parameters: inout ProtocolParametersCollection?, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get the key of the new child
		let modelItemKey: 		String = self.getChildAutoId()
		
		// Store the new key in the primary key column parameter
		let parameter: 			ModelAccessParameter = parameters!.get(parameterName: self.primaryKeyColumnName) as! ModelAccessParameter
		parameter.value 		= modelItemKey
		
		// Create the node
		let node:				[String:Any] = self.createNode(with: parameters, collection: collection)
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
				
				// Call completion handler
				completionHandler([self.rootKey: node], nil)
				
				return
				
			}
			
		#endif
		
		// Run the insert query
		self.doRunQueryInsert(modelItemKey: modelItemKey, node: node, oncomplete: completionHandler)
		
		// Call completion handler
		//completionHandler([self.rootKey: node], nil)
	}
	
	open override func runQuery(update attributes: [String : Any], with parameters: ProtocolParametersCollection?, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get the key from the primary key column parameter
		let parameter: 			ModelAccessParameter = parameters!.get(parameterName: self.primaryKeyColumnName) as! ModelAccessParameter
		let modelItemKey: 		String = parameter.value as! String
		
		// Create the node
		let node:				[String:Any] = self.createNode(with: parameters, collection: collection)
		
		#if DEBUG
			
			if (ApplicationFlags.flag(key: "SaveDummyDataYN")) {
				
				// Call completion handler
				completionHandler([self.rootKey: node], nil)
				
				return
				
			}
			
		#endif
		
		// Run the update query
		self.doRunQueryUpdate(modelItemKey: modelItemKey, node: node, oncomplete: completionHandler)
		
	}
	
	open override func runQuery(delete attributes: [String : Any], with parameters: ProtocolParametersCollection?, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get the model item key from the primary key column parameter
		let parameter:			ModelAccessParameter	= parameters!.get(parameterName: self.primaryKeyColumnName) as! ModelAccessParameter
		let modelItemKey:		String					= parameter.value as! String
		
		// Run the delete query
		self.doRunQueryDelete(modelItemKey: modelItemKey, oncomplete: completionHandler)
		
	}
	
	open override func runQuery(select attributes: [String : Any], with parameters: ProtocolParametersCollection?, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Get a model item to use for iterating property keys
		let modelItem: ProtocolModelItem = collection.getNewItem()!
		
		var data:	[String:Any] = [String:Any]()
		var items:	[Any] = [Any]()
		
		// Call Firebase query
		databaseReference!.queryOrdered(byChild: self.primaryKeyColumnName).observeSingleEvent(of: .value, with: { snapshot in
			
			self.databaseReference!.removeAllObservers()
			
			// Go through each node
			for node in snapshot.children {
				
				let node				= node as! DataSnapshot
				
				// Get the node properties
				let properties			= node.value as! [String: AnyObject]
				
				// Create the item
				var item				= [String: Any]()
				
				// Iterate through the property keys
				for key in modelItem.getPropertyKeys() {
					
					// Put the property in the item
					item[key] = properties[key]
				}
				
				// Add the item to the items array
				items.append(item)
			}
			
			// Add the items array to the data
			data[self.tableName] = items
			
			// Call completion handler
			completionHandler(data, nil)
		})
	}
	
	open override func runQuery(selectCount attributes: [String : Any], with parameters: ProtocolParametersCollection?, into collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {

		// Call Firebase query
		databaseReference!.observeSingleEvent(of: .value, with: { snapshot in
		
			self.databaseReference!.removeAllObservers()
			
			let count: Int = Int(snapshot.childrenCount)
			
			// Call completion handler
			completionHandler(["count":count], nil)
		})
		
	}
}
