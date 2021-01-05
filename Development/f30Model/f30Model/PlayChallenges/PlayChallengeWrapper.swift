//
//  PlayChallengeWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFModel
import f30Core

/// A wrapper for a PlayChallenge model item
public class PlayChallengeWrapper {
	
	// MARK: - Private Static Stored Properties
	

	// MARK: - Public Stored Properties
	
	public var id:											String = ""
	public var relativeMemberID:							String = ""
	public var playGameID:									String = ""
	public var playMoveID:									String = ""
	public var playChallengeTypeID:							String = ""
	public fileprivate(set) var playChallengeTypeWrapper:	PlayChallengeTypeWrapper? = nil
	public fileprivate(set) var playChallengeObjectives:	[String:PlayChallengeObjectiveWrapper]? = [String:PlayChallengeObjectiveWrapper]()
	public var isActiveYN:									Bool = false
	public var isCompleteYN:								Bool = false
	public var dateActive:									Date = Date()
	public var status: 										ModelItemStatusTypes = .new
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	public class func find(byID id: String, wrappers: [PlayChallengeWrapper]) -> PlayChallengeWrapper? {
		
		for item in wrappers {
			
			if (item.id == id) {
				
				return item
			}
			
		}
		
		return nil
		
	}

	
	// MARK: - Public Methods
	
	public func dispose() {
		
		self.playChallengeTypeWrapper 	= nil
		self.playChallengeObjectives 	= nil
		
	}

	public func set(playChallengeTypeWrapper: PlayChallengeTypeWrapper) {
		
		self.playChallengeTypeWrapper 	= playChallengeTypeWrapper
		
		// Set properties from the playChallengeTypeWrapper
		self.playChallengeTypeID 		= playChallengeTypeWrapper.id
		
	}
	
	public func set(playChallengeObjectiveWrapper: PlayChallengeObjectiveWrapper) {
		
		if (self.playChallengeObjectives == nil) {
			
			self.playChallengeObjectives = [String:PlayChallengeObjectiveWrapper]()
			
		}
		
		self.playChallengeObjectives![playChallengeObjectiveWrapper.id] = playChallengeObjectiveWrapper
		
	}
	
	public func remove(playChallengeObjectiveWrapper id: String) {
		
		guard (self.playChallengeObjectives != nil) else { return }
		
		self.playChallengeObjectives!.removeValue(forKey: id)
		
	}

	public func clearPlayChallengeObjectives() {
		
		guard (self.playChallengeObjectives != nil) else { return }
		
		// Go through each item
		for pcow in self.playChallengeObjectives!.values {
			
			pcow.dispose()
			
		}
		
		self.playChallengeObjectives = nil
		
	}
	
}
