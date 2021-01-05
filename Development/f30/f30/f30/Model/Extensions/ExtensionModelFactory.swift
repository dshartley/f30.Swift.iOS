//
//  ExtensionModelFactory.swift
//  f30
//
//  Created by David on 09/03/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import SFModel
import SFSocial

// MARK: - Extension Social

extension ModelFactory {

	// MARK: - Public Class Computed Properties
	
	fileprivate static var _socialModelManager: SocialModelManager?
	
	public class var socialModelManager: SocialModelManager {
		get {
			if (_socialModelManager == nil) {
				_socialModelManager = SocialModelManager(storageDateFormatter: ModelFactory.storageDateFormatter)
			}
			
			return _socialModelManager!
		}
	}
	
	
	// MARK: - Public Class Methods
	
	
	// MARK: - RelativeMember
	
	public class var getRelativeMemberModelAdministrator: RelativeMemberModelAdministrator {
		get {
			if (self.socialModelManager.getRelativeMemberModelAdministrator == nil) {
				self.setupRelativeMemberModelAdministrator(modelManager: self.socialModelManager)
			}
			
			return self.socialModelManager.getRelativeMemberModelAdministrator!
		}
	}
	
	public class func setupRelativeMemberModelAdministrator(modelManager: SocialModelManager) {
		
		// Connection string
		let connectionString: String = ""
		
		// RESTWebAPI
		let modelAccessStrategy: ProtocolModelAccessStrategy = RelativeMemberRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		// Firebase loadAvatarImageStrategy
		let loadAvatarImageStrategy: ProtocolRelativeMemberLoadAvatarImageStrategy = RelativeMemberFirebaseLoadAvatarImageStrategy()
		
		socialModelManager.setupRelativeMemberModelAdministrator(modelAccessStrategy: modelAccessStrategy,
																 loadAvatarImageStrategy: loadAvatarImageStrategy)
	}
	
	
	// MARK: - RelativeConnection
	
	public class var getRelativeConnectionModelAdministrator: RelativeConnectionModelAdministrator {
		get {
			if (self.socialModelManager.getRelativeConnectionModelAdministrator == nil) {
				self.setupRelativeConnectionModelAdministrator(modelManager: self.socialModelManager)
			}
			
			return self.socialModelManager.getRelativeConnectionModelAdministrator!
		}
	}
	
	public class func setupRelativeConnectionModelAdministrator(modelManager: SocialModelManager) {
		
		// Connection string
		let connectionString: String = ""
		
		// RESTWebAPI
		let modelAccessStrategy: ProtocolModelAccessStrategy = RelativeConnectionRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		socialModelManager.setupRelativeConnectionModelAdministrator(modelAccessStrategy: modelAccessStrategy)
	}
	
	
	// MARK: - RelativeConnectionRequest
	
	public class var getRelativeConnectionRequestModelAdministrator: RelativeConnectionRequestModelAdministrator {
		get {
			if (self.socialModelManager.getRelativeConnectionRequestModelAdministrator == nil) {
				self.setupRelativeConnectionRequestModelAdministrator(modelManager: self.socialModelManager)
			}
			
			return self.socialModelManager.getRelativeConnectionRequestModelAdministrator!
		}
	}
	
	public class func setupRelativeConnectionRequestModelAdministrator(modelManager: SocialModelManager) {
		
		// Connection string
		let connectionString: String = ""
		
		// RESTWebAPI
		let modelAccessStrategy: ProtocolModelAccessStrategy = RelativeConnectionRequestRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		socialModelManager.setupRelativeConnectionRequestModelAdministrator(modelAccessStrategy: modelAccessStrategy)
	}
	
	
	// MARK: - RelativeInteraction
	
	public class var getRelativeInteractionModelAdministrator: RelativeInteractionModelAdministrator {
		get {
			if (self.socialModelManager.getRelativeInteractionModelAdministrator == nil) {
				self.setupRelativeInteractionModelAdministrator(modelManager: self.socialModelManager)
			}
			
			return self.socialModelManager.getRelativeInteractionModelAdministrator!
		}
	}
	
	public class func setupRelativeInteractionModelAdministrator(modelManager: SocialModelManager) {
		
		// Connection string
		let connectionString: String = ""
		
		// RESTWebAPI
		let modelAccessStrategy: ProtocolModelAccessStrategy = RelativeInteractionRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		
		socialModelManager.setupRelativeInteractionModelAdministrator(modelAccessStrategy: modelAccessStrategy)
	}
	
	
	// MARK: - RelativeTimelineEvent
	
	public class var getRelativeTimelineEventModelAdministrator: RelativeTimelineEventModelAdministrator {
		get {
			if (self.socialModelManager.getRelativeTimelineEventModelAdministrator == nil) {
				self.setupRelativeTimelineEventModelAdministrator(modelManager: self.socialModelManager)
			}
			
			return self.socialModelManager.getRelativeTimelineEventModelAdministrator!
		}
	}
	
	public class func setupRelativeTimelineEventModelAdministrator(modelManager: SocialModelManager) {
		
		// Connection string
		let connectionString: String = ""
		
		// RESTWebAPI
		let modelAccessStrategy: ProtocolModelAccessStrategy = RelativeTimelineEventsRESTWebAPIModelAccessStrategy(connectionString: connectionString, storageDateFormatter: ModelFactory.storageDateFormatter)
		
		socialModelManager.setupRelativeTimelineEventModelAdministrator(modelAccessStrategy: modelAccessStrategy)
	}
	
}
