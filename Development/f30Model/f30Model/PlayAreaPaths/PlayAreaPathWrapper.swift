//
//  PlayAreaPathWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape
import SFSerialization
import f30Core

/// A wrapper for a PlayAreaPath model item
public class PlayAreaPathWrapper: PathWrapperBase {
	
	// MARK: - Private Static Stored Properties
	
	
	// MARK: - Public Stored Properties

	public var playGameID:								String = ""
	public var isDisplayedYN:							Bool = false
	public var playAreaPathAbilityType: 				PlayAreaPathAbilityTypes = .ByFoot
	public fileprivate(set) var playMoves:				[String:PlayMoveWrapper]? = [String:PlayMoveWrapper]()
	
	
	// MARK: - Initializers
	
	
	// MARK: - Public Class Methods
	
	
	// MARK: - Public Override Methods
	
	public override func dispose() {
		
		super.dispose()
		
		self.playMoves = nil
		
	}
	
	
	// MARK: - Public Methods

	public func toJSON() -> DataJSONWrapper {
	
		let collection: 	PlayAreaPathCollection = PlayAreaPathCollection()
		
		// Create the model item from the wrapper
		let item: 			PlayAreaPath = collection.addItem() as! PlayAreaPath
		item.clone(fromWrapper: self)
		
		// Create DataJSONWrapper from item
		let result: 		DataJSONWrapper = item.copyToWrapper()
		
		return result
		
	}
	
	public func set(playMoveWrapper: PlayMoveWrapper) {
		
		if (playMoveWrapper.playReferenceType == .PlayAreaPathPoint) {
			
			// Set in playAreaPathPointWrapper
			self.setPlayMoveInPlayAreaPathPoint(playMoveWrapper: playMoveWrapper)
			
			return
			
		}
		
		guard (playMoveWrapper.playReferenceType == .PlayAreaPath && playMoveWrapper.playReferenceID == self.id) else { return }
		
		if (self.playMoves == nil) {
			
			self.playMoves = [String:PlayMoveWrapper]()
			
		}
		
		self.playMoves![playMoveWrapper.id] = playMoveWrapper
		
	}
	
	public func get(playReferenceType: PlayReferenceTypes, playReferenceID: String, playReferenceActionType: 			PlayReferenceActionTypes) -> PlayMoveWrapper? {
		
		var result: PlayMoveWrapper? = nil
		
		// Check playReferenceType and playReferenceID
		if (playReferenceType == .PlayAreaPath && playReferenceID == self.id) {
			
			guard (self.playMoves != nil) else { return nil }
			
			// Go through each item
			for pmw in self.playMoves!.values {
				
				// Check playReferenceActionType
				if (pmw.playReferenceActionType == playReferenceActionType) {
				
					result = pmw
					
				}
				
				if (result != nil) { return result }
				
			}
			
		} else if (playReferenceType == .PlayAreaPathPoint) {
			
			guard (self.pathPoints != nil) else { return nil }
			
			// Go through each item
			for ppw in self.pathPoints!.values {
				
				let pappw = ppw as! PlayAreaPathPointWrapper
				
				// Get playMoveWrapper from PlayAreaPathPointWrapper
				result = pappw.get(playReferenceType: playReferenceType, playReferenceID: playReferenceID, playReferenceActionType: playReferenceActionType)
				
				if (result != nil) { return result }
				
			}
			
		}

		return result
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setPlayMoveInPlayAreaPathPoint(playMoveWrapper: PlayMoveWrapper) {
		
		// Get playAreaPathPointWrapper
		let playAreaPathPointWrapper: PlayAreaPathPointWrapper? = self.pathPoints![playMoveWrapper.playReferenceID] as? PlayAreaPathPointWrapper
		
		guard (playAreaPathPointWrapper != nil) else { return }
		
		// Set playMoveWrapper
		playAreaPathPointWrapper!.set(playMoveWrapper: playMoveWrapper)
		
	}
	
}
