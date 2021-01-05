//
//  PlayAreaPathPointWrapper.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape
import SFSerialization
import f30Core

/// A wrapper for a PlayAreaPathPoint model item
public class PlayAreaPathPointWrapper: PathPointWrapperBase {
	
	// MARK: - Private Static Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var playGameID:						String = ""
	public fileprivate(set) var playMoves:		[String:PlayMoveWrapper]? = [String:PlayMoveWrapper]()
	
	
	// MARK: - Initializers
	

	// MARK: - Public Class Methods
	
	
	// MARK: - Public Override Methods
	
	public override func dispose() {
		
		super.dispose()
		
		self.playMoves = nil
		
	}
	
	
	// MARK: - Public Methods
	
	public func toJSON() -> DataJSONWrapper {
		
		let collection: 	PlayAreaPathPointCollection = PlayAreaPathPointCollection()
		
		// Create the model item from the wrapper
		let item: 			PlayAreaPathPoint = collection.addItem() as! PlayAreaPathPoint
		item.clone(fromWrapper: self)
		
		// Create DataJSONWrapper from item
		let result: 		DataJSONWrapper = item.copyToWrapper()
		
		return result
		
	}
	
	public func set(playMoveWrapper: PlayMoveWrapper) {
		
		guard (playMoveWrapper.playReferenceType == .PlayAreaPathPoint && playMoveWrapper.playReferenceID == self.id) else { return }
		
		if (self.playMoves == nil) {
			
			self.playMoves = [String:PlayMoveWrapper]()
			
		}
		
		self.playMoves![playMoveWrapper.id] = playMoveWrapper
		
	}
	
	public func get(playReferenceType: PlayReferenceTypes, playReferenceID: String, playReferenceActionType: 			PlayReferenceActionTypes) -> PlayMoveWrapper? {
		
		var result: PlayMoveWrapper? = nil
		
		// Check playReferenceType and playReferenceID
		if (playReferenceType == .PlayAreaPathPoint && playReferenceID == self.id) {
			
			guard (self.playMoves != nil) else { return nil }
			
			// Go through each item
			for pmw in self.playMoves!.values {
				
				// Check playReferenceActionType
				if (pmw.playReferenceActionType == playReferenceActionType) {
					
					result = pmw
					
				}
				
				if (result != nil) { return result }
				
			}
			
		}
		
		return result
		
	}
	
}
