//
//  RelativeInteractionFirebaseModelAccessStrategy.swift
//  f30
//
//  Created by David on 04/01/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSocial
import f30Model
import f30Core
import FirebaseDatabase
import FirebaseStorage

/// Specifies query parameter keys
fileprivate enum QueryParameterKeys : Int {
	case fromuserprofileid
	case touserprofileid
	case interactiontype
}

/// A strategy for accessing the RelativeInteraction model data using Firebase
public class RelativeInteractionFirebaseModelAccessStrategy: FirebaseModelAccessStrategyBase {
	
	// MARK: - Initializers
	
	private override init() {
		super.init()
	}
	
	public override init(connectionString: String,
						 storageDateFormatter: DateFormatter) {
		super.init(connectionString: connectionString,
				   storageDateFormatter: storageDateFormatter,
				   tableName: "relativeInteractions")
		
		self.databaseReference = Database.database().reference(withPath: self.tableName)
	}
	
	
	// MARK: - Private Methods
	
	
	// MARK: - Override Methods
	
	public override func doRunQueryInsert(modelItemKey: String, node: [String:Any], oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create database reference
		let reference: 					DatabaseReference = Database.database().reference()

		// Create the fan-out node
		var fanoutNode: 				[String : Any] = [:]
		
		let fromUserProfileID: 			String? = node["\(QueryParameterKeys.fromuserprofileid)"] as? String
		
		if (fromUserProfileID != nil && !fromUserProfileID!.isEmpty) {
			
			// Create fromUserProfilePath
			let fromUserProfilePath: 	String = "relativeInteractions_byFromUserProfile/\(fromUserProfileID!)/\(modelItemKey)"
			
			fanoutNode[fromUserProfilePath] = node
			
		}
		
		let toUserProfileID: 			String? = node["\(QueryParameterKeys.touserprofileid)"] as? String
		
		if (toUserProfileID != nil && !toUserProfileID!.isEmpty) {
			
			// Create toUserProfilePath
			let toUserProfilePath: 		String = "relativeInteractions_byToUserProfile/\(toUserProfileID!)/\(modelItemKey)"
			
			fanoutNode[toUserProfilePath] = node
			
		}
		
		// Save atomic fan-out node
		reference.updateChildValues(fanoutNode) { (error, reference) -> Void in

			reference.removeAllObservers()

			// Call completion handler
			completionHandler([self.rootKey: node], nil)
		}
		
	}
	
}

// MARK: - Extension ProtocolRelativeInteractionModelAccessStrategy

extension RelativeInteractionFirebaseModelAccessStrategy: ProtocolRelativeInteractionModelAccessStrategy {
	
	// MARK: - Public Methods
	
	public func select(byFromRelativeMemberID fromRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Not implemented
		
	}
	
	public func select(byToRelativeMemberID toRelativeMemberID: String, applicationID: String, interactionType: RelativeInteractionTypes, collection: ProtocolModelItemCollection, oncomplete completionHandler:@escaping ([String:Any]?, ProtocolModelItemCollection?, Error?) -> Void) {
		
		// Not implemented
		
	}
}
