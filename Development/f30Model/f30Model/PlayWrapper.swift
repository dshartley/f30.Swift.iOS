//
//  PlayWrapper.swift
//  f30Model
//
//  Created by David on 24/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape

/// A wrapper for Play model items
public class PlayWrapper {

	// MARK: - Private Static Stored Properties
	
	fileprivate static var _current:			PlayWrapper? = nil
	
	
	// MARK: - Public Stored Properties
	
	public var id:					    		String = ""
	public fileprivate(set) var playResult:		PlayResultWrapper = PlayResultWrapper()
	public var playSubsets:						[String:PlaySubsetWrapper]? = nil
	public var playMoves:						[String:PlayMoveWrapper]? = nil
	public var playChallengeTypes:				[String:PlayChallengeTypeWrapper]? = nil
	public var playChallengeObjectiveTypes:		[String:PlayChallengeObjectiveTypeWrapper]? = nil
	public var playChallenges:					[String:PlayChallengeWrapper]? = nil
	public var playGames:						[String:PlayGameWrapper]? = nil
	public var playAreaTokens:					[String:PlayAreaTokenWrapper]? = nil
	public var playAreaCellTypes:				[String:PlayAreaCellTypeWrapper]? = nil
	public var playAreaCells:					[String:PlayAreaCellWrapper]? = nil
	public var playAreaTileTypes:				[String:PlayAreaTileTypeWrapper]? = nil
	public var playAreaTiles:					[String:PlayAreaTileWrapper]? = nil
	public var playAreaPaths: 					[String:PlayAreaPathWrapper]? = nil
	public var playExperiences: 				[String:PlayExperienceWrapper]? = nil
	public var playExperienceSteps: 			[String:PlayExperienceStepWrapper]? = nil
	public var playExperienceStepExercises: 	[String:PlayExperienceStepExerciseWrapper]? = nil
	public var playExperiencePlayExperienceStepLinks:			[String:PlayExperiencePlayExperienceStepLinkWrapper]? = nil
	public var playExperienceStepPlayExperienceStepExerciseLinks:	[String:PlayExperienceStepPlayExperienceStepExerciseLinkWrapper]? = nil
	
	
	// MARK: - Public Class Computed Properties
	
	public class var current: PlayWrapper? {
		get {
			if (PlayWrapper._current == nil) {
				
				PlayWrapper._current = PlayWrapper()
				
			}
			
			return PlayWrapper._current
		}
		set(value) {
			PlayWrapper._current = value
		}
	}
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Class Methods
	
	
	// MARK: - Public Methods
	
	public func set(wrappers: [String:Any]) {
	
		self.doSetPlaySubsets(wrappers: wrappers)
		self.doSetPlayMoves(wrappers: wrappers)
		self.doSetPlayChallengeTypes(wrappers: wrappers)
		self.doSetPlayChallengeObjectiveTypes(wrappers: wrappers)
		self.doSetPlayChallenges(wrappers: wrappers)
		self.doSetPlayChallengeObjectives(wrappers: wrappers)
		self.doSetPlayGames(wrappers: wrappers)
		self.doSetPlayGameData(wrappers: wrappers)
		self.doSetPlayAreaTokens(wrappers: wrappers)
		self.doSetPlayAreaCellTypes(wrappers: wrappers)
		self.doSetPlayAreaCells(wrappers: wrappers)
		self.doSetPlayAreaTileTypes(wrappers: wrappers)
		self.doSetPlayAreaTiles(wrappers: wrappers)
		self.doSetPlayAreaTileData(wrappers: wrappers)
		self.doSetPlayAreaPaths(wrappers: wrappers)
		self.doSetPlayAreaPathPoints(wrappers: wrappers)
		self.doSetPlayExperiencePlayExperienceStepLinks(wrappers: wrappers)
		self.doSetPlayExperienceStepPlayExperienceStepExerciseLinks(wrappers: wrappers)
		self.doSetPlayExperiences(wrappers: wrappers)
		self.doSetPlayExperienceSteps(wrappers: wrappers)
		self.doSetPlayExperienceStepExercises(wrappers: wrappers)
		self.doSetPlayMovesToPlayReference()
		
	}

	public func clear() {
		
		self.playResult = PlayResultWrapper()
		self.playSubsets = nil
		self.playMoves = nil
		self.playChallengeTypes = nil
		self.playChallengeObjectiveTypes = nil
		self.playChallenges = nil
		self.playGames = nil
		self.playAreaTokens = nil
		self.playAreaCellTypes = nil
		self.playAreaCells = nil
		self.playAreaTileTypes = nil
		self.playAreaPaths = nil
		self.playExperiences = nil
		self.playExperienceSteps = nil
		self.playExperienceStepExercises = nil
		self.playExperiencePlayExperienceStepLinks = nil
		self.playExperienceStepPlayExperienceStepExerciseLinks = nil
	}
	
	
	// MARK: - Public Methods; PlaySubsets
	
	public func get(byID: String) -> PlaySubsetWrapper? {
		
		guard (PlayWrapper.current!.playSubsets != nil) else { return nil }
		
		// Go through each item
		for (_, value) in PlayWrapper.current!.playSubsets! {
			
			if (value.id == byID) {
				
				return value
				
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods; PlayGames
	
	public func clear(playGame wrapper: PlayGameWrapper) {
		
		self.doClear(playGame: wrapper)
		
		// Remove PlayGame
		//self.playGames?.removeValue(forKey: wrapper.id)
		
		self.clear()
		
	}
	
	
	// MARK: - Public Methods; PlayAreaCellTypes
	
	public func get(byIsSpecialYN: Bool) -> [String:PlayAreaCellTypeWrapper] {
		
		var result: [String:PlayAreaCellTypeWrapper] = [String:PlayAreaCellTypeWrapper]()
	
		// Go through each item
		for (key, value) in self.playAreaCellTypes! {
			
			// Check isSpecialYN
			if (value.isSpecialYN == byIsSpecialYN) {
				
				result[key] = value
				
			}
			
		}
		
		return result

	}

	public func get(byID: String) -> PlayAreaCellTypeWrapper? {
		
		guard (PlayWrapper.current!.playAreaCellTypes != nil) else { return nil }
		
		// Go through each item
		for (_, value) in PlayWrapper.current!.playAreaCellTypes! {
			
			if (value.id == byID) {
				
				return value
				
			}
			
		}
		
		return nil
		
	}
	
	public func get(byName: String) -> PlayAreaCellTypeWrapper? {
		
		guard (PlayWrapper.current!.playAreaCellTypes != nil) else { return nil }
		
		// Go through each item
		for (_, value) in PlayWrapper.current!.playAreaCellTypes! {
			
			if (value.name == byName) {
				
				return value
				
			}
			
		}
		
		return nil
		
	}

	
	// MARK: - Public Methods; PlayAreaTileTypes
	
	public func get(byID: String) -> PlayAreaTileTypeWrapper? {
		
		guard (PlayWrapper.current!.playAreaTileTypes != nil) else { return nil }
		
		// Go through each item
		for (_, value) in PlayWrapper.current!.playAreaTileTypes! {
			
			if (value.id == byID) {
				
				return value
				
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Public Methods; PlayChallenges
	
	public func get(byIsActiveYN: Bool) -> [String:PlayChallengeWrapper] {
		
		var result: [String:PlayChallengeWrapper] = [String:PlayChallengeWrapper]()
		
		guard (self.playChallenges != nil) else { return result }
		
		// Go through each item
		for (key, value) in self.playChallenges! {
			
			// Check isActiveYN
			if (value.isActiveYN == byIsActiveYN) {
				
				result[key] = value
				
			}
			
		}
		
		return result
		
	}
	
	public func clear(playChallengesByIsActiveYN isActiveYN: Bool) {
		
		guard (self.playChallenges != nil) else { return }
		
		// Go through each item
		for pcw in self.playChallenges!.values {
			
			if (pcw.isActiveYN == isActiveYN) {
				
				self.doClear(playChallenge: pcw)
				
				self.playChallenges!.removeValue(forKey: pcw.id)
				
			}
			
		}
		
	}
	
	
	// MARK: - Public Methods; PlayAreaPaths
	
	public func get(byIsDisplayedYN: Bool) -> [String:PlayAreaPathWrapper] {
		
		var result: [String:PlayAreaPathWrapper] = [String:PlayAreaPathWrapper]()
		
		guard (self.playAreaPaths != nil) else { return result }
		
		// Go through each item
		for (key, value) in self.playAreaPaths! {
			
			// Check isDisplayedYN
			if (value.isDisplayedYN == byIsDisplayedYN) {
				
				result[key] = value
				
			}
			
		}
		
		return result
		
	}

	public func get(forPlayAreaPathPointWrappers playAreaPathPointWrappers: [String:PlayAreaPathPointWrapper]) -> [String:PlayAreaPathWrapper] {
		
		var result: [String:PlayAreaPathWrapper] = [String:PlayAreaPathWrapper]()
		
		guard (self.playAreaPaths != nil) else { return result }
		
		// Go through each item
		for pappw in playAreaPathPointWrappers.values {
		
			guard (!result.keys.contains(pappw.pathID)) else { continue }
			
			// Get PlayAreaPathWrapper
			let papw: PlayAreaPathWrapper? = self.playAreaPaths![pappw.pathID]
			
			if (papw != nil) {
				
				result[papw!.id] = papw
				
			}
			
		}
		
		return result
		
	}
	
	public func get(byID: String) -> [String:PlayAreaPathWrapper] {
		
		var result: [String:PlayAreaPathWrapper] = [String:PlayAreaPathWrapper]()
		
		guard (self.playAreaPaths != nil) else { return result }
		
		// Go through each item
		for papw in self.playAreaPaths!.values {
			
			if (papw.id == byID) {
			
				result[papw.id] = papw
				
				return result
				
			}
			
		}
		
		return result
		
	}

	public func get(byPlayAreaPathPointID: String) -> [String:PlayAreaPathWrapper] {
		
		var result: [String:PlayAreaPathWrapper] = [String:PlayAreaPathWrapper]()
		
		guard (self.playAreaPaths != nil) else { return result }
		
		// Go through each item
		for papw in self.playAreaPaths!.values {
			
			// Get pathPointWrapper
			let ppw: PathPointWrapperBase? = papw.pathPoints?[byPlayAreaPathPointID]
			
			if (ppw != nil) {
				
				result[papw.id] = papw
				
				return result
				
			}
			
		}
		
		return result
		
	}
	
	public func clearPlayAreaPaths() {
	
		guard (self.playAreaPaths != nil) else { return }
		
		// Go through each item
		for papw in self.playAreaPaths! {
			
			// Clear PlayAreaPath
			self.doClear(playAreaPath: papw.value)
			
			// Remove PlayAreaPath
			self.playAreaPaths?.removeValue(forKey: papw.key)
			
		}
		
	}
	
	
	// MARK: - Public Methods; PlayAreaPathPoints
	
	public func get(byCellCoordRange: CellCoordRange, isDisplayedYN: Bool) -> [String:PlayAreaPathPointWrapper] {
		
		var result: [String:PlayAreaPathPointWrapper] = [String:PlayAreaPathPointWrapper]()
		
		guard (self.playAreaPaths != nil) else { return result }
		
		// Go through each item
		for papw in self.playAreaPaths!.values {
			
			// Check isDisplayedYN
			if (papw.isDisplayedYN != isDisplayedYN) { continue }
			
			guard (papw.pathPoints != nil) else { continue }
			
			// Go through each item
			for pappw in papw.pathPoints!.values {
				
				let pappw = pappw as! PlayAreaPathPointWrapper
				
				// Get cellCoord
				let cellCoord: CellCoord = CellCoord(column: pappw.column, row: pappw.row)
				
				// Check cellCoord
				if (byCellCoordRange.contains(cellCoord: cellCoord)) {
					
					result[pappw.id] = pappw
					
				}
				
			}
			
		}
		
		return result
	}
	
	
	// MARK: - Public Methods; PlayExperienceSteps
	
	public func get(byID: String) -> PlayExperienceStepWrapper? {
		
		guard (PlayWrapper.current!.playExperienceSteps != nil) else { return nil }
		
		// Go through each item
		for (_, value) in PlayWrapper.current!.playExperienceSteps! {
			
			if (value.id == byID) {
				
				return value
				
			}
			
		}
		
		return nil
		
	}
	

	// MARK: - Public Methods; PlayExperienceStepExercises
	
	public func get(byID: String) -> PlayExperienceStepExerciseWrapper? {
		
		guard (PlayWrapper.current!.playExperienceStepExercises != nil) else { return nil }
		
		// Go through each item
		for (_, value) in PlayWrapper.current!.playExperienceStepExercises! {
			
			if (value.id == byID) {
				
				return value
				
			}
			
		}
		
		return nil
		
	}
	
	
	// MARK: - Private Methods

	// MARK: - Private Methods; PlaySubsets
	
	fileprivate func doSetPlaySubsets(wrappers: [String:Any]) {
		
		if (self.playSubsets == nil) {
			
			self.playSubsets = [String:PlaySubsetWrapper]()
			
		}
		
		// Get playSubsetWrappers
		if let playSubsetWrappers = wrappers["PlaySubsets"] as? [PlaySubsetWrapper] {
			
			// Go through each item
			for psw in playSubsetWrappers {
				
				// Add to dictionary
				self.playSubsets![psw.id] = psw
				
			}
			
		}
		
	}

	
	// MARK: - Private Methods; PlayMoves
	
	fileprivate func doSetPlayMoves(wrappers: [String:Any]) {
		
		if (self.playMoves == nil) {
			
			self.playMoves = [String:PlayMoveWrapper]()
			
		}
		
		// Get playMoveWrappers
		if let playMoveWrappers = wrappers["PlayMoves"] as? [PlayMoveWrapper] {
			
			// Go through each item
			for pmw in playMoveWrappers {
				
				// Add to dictionary
				self.playMoves![pmw.id] = pmw
				
			}
			
		}
		
	}
	
	fileprivate func doClear(playMove wrapper: PlayMoveWrapper) {
		
		if (wrapper.playChallenge != nil) {
			
			// Clear PlayChallenge
			self.doClear(playChallenge: wrapper.playChallenge!)
			
			// Remove PlayChallenge
			self.playChallenges?.removeValue(forKey: wrapper.playChallenge!.id)
			
		}
		
	}
	
	fileprivate func doSetPlayMovesToPlayReference() {
		
		// Get playMoveWrappers
		if let playMoveWrappers = self.playMoves?.values {
			
			// Go through each item
			for pmw in playMoveWrappers {
				
				// Check playReferenceType
				switch pmw.playReferenceType {
					
				case .PlayAreaTile:
					
					// TODO:
					print("PlayAreaTile")
					
					//					// Get PlayAreaTileWrapper
					//					if let patw = self.playAreaTiles?[pmw.playReferenceID] {
					//
					//						// TODO:
					//						//patw.set(playMoveWrapper: pmw)
					//
					//					}
					
				case .PlayAreaToken:
					
					// TODO:
					print("PlayAreaToken")
					
				case .PlayAreaPath:
					
					// TODO:
					print("PlayAreaPath")
					
				case .PlayAreaPathPoint:
					
					// TODO:
					print("PlayAreaPathPoint")
					
				}
				
			}
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayChallengeTypes
	
	fileprivate func doSetPlayChallengeTypes(wrappers: [String:Any]) {
		
		if (self.playChallengeTypes == nil) {
			
			self.playChallengeTypes = [String:PlayChallengeTypeWrapper]()
			
		}
		
		// Get playChallengeTypeWrappers
		if let playChallengeTypeWrappers = wrappers["PlayChallengeTypes"] as? [PlayChallengeTypeWrapper] {
			
			// Go through each item
			for pctw in playChallengeTypeWrappers {
				
				// Add to dictionary
				self.playChallengeTypes![pctw.id] = pctw
				
			}
			
		}
		
	}
	
	fileprivate func doClear(playChallengeType wrapper: PlayChallengeTypeWrapper) {
		
		
	}

	
	// MARK: - Private Methods; PlayChallenges
	
	fileprivate func doSetPlayChallenges(wrappers: [String:Any]) {
		
		if (self.playChallenges == nil) {
			
			self.playChallenges = [String:PlayChallengeWrapper]()
			
		}
		
		// Get playChallengeWrappers
		if let playChallengeWrappers = wrappers["PlayChallenges"] as? [PlayChallengeWrapper] {
			
			// Go through each item
			for pcw in playChallengeWrappers {
				
				// Add to dictionary
				self.playChallenges![pcw.id] = pcw
				
				// Get PlayChallengeTypeWrapper
				if let pctw = self.playChallengeTypes?[pcw.playChallengeTypeID] {
					
					pcw.set(playChallengeTypeWrapper: pctw)
					
				}
				
				// Get PlayMoveWrapper
				if let pmw = self.playMoves?[pcw.playMoveID] {
					
					pmw.set(playChallengeWrapper: pcw)
					
				}
				
			}
			
		}
		
	}
	
	fileprivate func doClear(playChallenge wrapper: PlayChallengeWrapper) {
		
		wrapper.dispose()
		
	}
	
	
	// MARK: - Private Methods; PlayChallengeObjectiveTypes
	
	fileprivate func doSetPlayChallengeObjectiveTypes(wrappers: [String:Any]) {
		
		if (self.playChallengeObjectiveTypes == nil) {
			
			self.playChallengeObjectiveTypes = [String:PlayChallengeObjectiveTypeWrapper]()
			
		}
		
		// Get playChallengeObjectiveTypeWrappers
		if let playChallengeObjectiveTypeWrappers = wrappers["PlayChallengeObjectiveTypes"] as? [PlayChallengeObjectiveTypeWrapper] {
			
			// Go through each item
			for pcotw in playChallengeObjectiveTypeWrappers {
				
				// Add to dictionary
				self.playChallengeObjectiveTypes![pcotw.id] = pcotw
				
			}
			
		}
		
	}
	
	fileprivate func doClear(playChallengeObjectiveType wrapper: PlayChallengeObjectiveTypeWrapper) {
		
		
	}

	
	// MARK: - Private Methods; PlayChallengeObjectives
	
	fileprivate func doSetPlayChallengeObjectives(wrappers: [String:Any]) {
		
		// Get playChallengeObjectiveWrappers
		if let playChallengeObjectiveWrappers = wrappers["PlayChallengeObjectives"] as? [PlayChallengeObjectiveWrapper] {
			
			// Go through each item
			for pcow in playChallengeObjectiveWrappers {
				
				// Get PlayChallengeObjectiveTypeWrapper
				if let pcotw = self.playChallengeObjectiveTypes?[pcow.playChallengeObjectiveTypeID] {
					
					pcow.set(playChallengeObjectiveTypeWrapper: pcotw)
					
				}
				
				// Get PlayChallengeWrapper
				if let pcw = self.playChallenges?[pcow.playChallengeID] {
					
					pcw.set(playChallengeObjectiveWrapper: pcow)
					
				}
				
			}
			
		}
		
	}

	
	// MARK: - Private Methods; PlayGames
	
	fileprivate func doSetPlayGames(wrappers: [String:Any]) {
		
		if (self.playGames == nil) {
			
			self.playGames = [String:PlayGameWrapper]()
			
		}
		
		// Get playGameWrappers
		if let playGameWrappers = wrappers["PlayGames"] as? [PlayGameWrapper] {
			
			// Go through each item
			for pgw in playGameWrappers {
				
				// Add to dictionary
				self.playGames![pgw.id] = pgw
				
			}
			
		}
		
	}
	
	fileprivate func doClear(playGame wrapper: PlayGameWrapper) {
		
		// Go through each item
		for patw in self.playAreaTokens! {
			
			// Clear PlayAreaToken
			self.doClear(playAreaToken: patw.value)
			
			// Remove PlayAreaToken
			self.playAreaTokens?.removeValue(forKey: patw.key)
			
		}
		
		// Go through each item
		for pacw in self.playAreaCells! {
			
			// Clear PlayAreaCell
			self.doClear(playAreaCell: pacw.value)
			
			// Remove PlayAreaCell
			self.playAreaCells?.removeValue(forKey: pacw.key)
			
		}
		
		// Go through each item
		for pactw in self.playAreaCellTypes! {
			
			// Clear PlayAreaCellType
			self.doClear(playAreaCellType: pactw.value)
			
			// Remove PlayAreaCellType
			self.playAreaCellTypes?.removeValue(forKey: pactw.key)
			
		}
		
		// Go through each item
		for pattw in self.playAreaTileTypes! {
			
			// Clear PlayAreaTileType
			self.doClear(playAreaTileType: pattw.value)
			
			// Remove PlayAreaTileType
			self.playAreaTileTypes?.removeValue(forKey: pattw.key)
			
		}
		
		// Go through each item
		for pmw in self.playMoves! {
			
			// Clear PlayMove
			self.doClear(playMove: pmw.value)
			
			// Remove PlayMove
			self.playMoves?.removeValue(forKey: pmw.key)
			
		}
		
		// Go through each item
		for papw in self.playAreaPaths! {
			
			// Clear PlayAreaPath
			self.doClear(playAreaPath: papw.value)
			
			// Remove PlayAreaPath
			self.playAreaPaths?.removeValue(forKey: papw.key)
			
		}
		
	}

	
	// MARK: - Private Methods; PlayGameData
	
	fileprivate func doSetPlayGameData(wrappers: [String:Any]) {
		
		// Get playGameDataWrappers
		if let playGameDataWrappers = wrappers["PlayGameData"] as? [PlayGameDataWrapper] {
			
			// Go through each item
			for pgdw in playGameDataWrappers {
				
				// Get PlayGameWrapper
				if let pgw = self.playGames?[pgdw.playGameID] {
					
					pgw.set(playGameDataWrapper: pgdw)
					
				}
				
			}
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayAreaTokens
	
	fileprivate func doSetPlayAreaTokens(wrappers: [String:Any]) {
		
		if (self.playAreaTokens == nil) {
			
			self.playAreaTokens = [String:PlayAreaTokenWrapper]()
			
		}
		
		// Get playAreaTokenWrappers
		if let playAreaTokenWrappers = wrappers["PlayAreaTokens"] as? [PlayAreaTokenWrapper] {
			
			// Go through each item
			for patw in playAreaTokenWrappers {
				
				// Add to dictionary
				self.playAreaTokens![patw.id] = patw
				
			}
			
		}
		
	}

	fileprivate func doClear(playAreaToken wrapper: PlayAreaTokenWrapper) {
		
	}
	
	
	// MARK: - Private Methods; PlayAreaCellTypes
	
	fileprivate func doSetPlayAreaCellTypes(wrappers: [String:Any]) {
		
		if (self.playAreaCellTypes == nil) {
			
			self.playAreaCellTypes = [String:PlayAreaCellTypeWrapper]()
			
		}
		
		// Get playAreaCellTypeWrappers
		if let playAreaCellTypeWrappers = wrappers["PlayAreaCellTypes"] as? [PlayAreaCellTypeWrapper] {
			
			// Go through each item
			for pactw in playAreaCellTypeWrappers {
				
				// Add to dictionary
				self.playAreaCellTypes![pactw.id] = pactw
				
			}
			
		}
		
	}
	
	fileprivate func doClear(playAreaCellType wrapper: PlayAreaCellTypeWrapper) {
		
		
	}

	
	// MARK: - Private Methods; PlayAreaCells
	
	fileprivate func doSetPlayAreaCells(wrappers: [String:Any]) {
		
		if (self.playAreaCells == nil) {
			
			self.playAreaCells = [String:PlayAreaCellWrapper]()
			
		}
		
		// Get playAreaCellWrappers
		if let playAreaCellWrappers = wrappers["PlayAreaCells"] as? [PlayAreaCellWrapper] {
			
			// Go through each item
			for pacw in playAreaCellWrappers {
				
				// Add to dictionary
				self.playAreaCells![pacw.id] = pacw
				
				// Get PlayAreaCellTypeWrapper
				if let pactw = self.playAreaCellTypes?[pacw.cellTypeID] {
					
					pacw.set(cellTypeWrapper: pactw)
					
				}

			}
			
		}
		
	}
	
	fileprivate func doClear(playAreaCell wrapper: PlayAreaCellWrapper) {
		
	}
	
	
	// MARK: - Private Methods; PlayAreaTileTypes
	
	fileprivate func doSetPlayAreaTileTypes(wrappers: [String:Any]) {
		
		if (self.playAreaTileTypes == nil) {
			
			self.playAreaTileTypes = [String:PlayAreaTileTypeWrapper]()
			
		}
		
		// Get playAreaTileTypeWrappers
		if let playAreaTileTypeWrappers = wrappers["PlayAreaTileTypes"] as? [PlayAreaTileTypeWrapper] {
			
			// Go through each item
			for pattw in playAreaTileTypeWrappers {
				
				// Add to dictionary
				self.playAreaTileTypes![pattw.id] = pattw
				
			}
			
		}
		
	}
	
	fileprivate func doClear(playAreaTileType wrapper: PlayAreaTileTypeWrapper) {
		
		
	}
	
	
	// MARK: - Private Methods; PlayAreaTiles
	
	fileprivate func doSetPlayAreaTiles(wrappers: [String:Any]) {
		
		if (self.playAreaTiles == nil) {
			
			self.playAreaTiles = [String:PlayAreaTileWrapper]()
			
		}
		
		// Get playAreaTileWrappers
		if let playAreaTileWrappers = wrappers["PlayAreaTiles"] as? [PlayAreaTileWrapper] {
			
			// Go through each item
			for patw in playAreaTileWrappers {
				
				// Add to dictionary
				self.playAreaTiles![patw.id] = patw
				
				// Get PlayAreaTileTypeWrapper
				if let pattw = self.playAreaTileTypes?[patw.tileTypeID] {
					
					patw.set(tileTypeWrapper: pattw)
					
				}
				
			}
			
		}
		
	}

	
	// MARK: - Private Methods; PlayAreaTileData
	
	fileprivate func doSetPlayAreaTileData(wrappers: [String:Any]) {
		
		// Get playAreaTileDataWrappers
		if let playAreaTileDataWrappers = wrappers["PlayAreaTileData"] as? [PlayAreaTileDataWrapper] {
			
			// Go through each item
			for patdw in playAreaTileDataWrappers {
				
				// Get PlayAreaTileWrapper
				if let patw = self.playAreaTiles?[patdw.playAreaTileID] {
					
					patw.set(playAreaTileDataWrapper: patdw)

				}
				
			}
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayExperiences
	
	fileprivate func doSetPlayExperiences(wrappers: [String:Any]) {
		
		if (self.playExperiences == nil) {
			
			self.playExperiences = [String:PlayExperienceWrapper]()
			
		}

		// PlayExperiences
		if let playExperienceWrappers = wrappers["PlayExperiences"] as? [PlayExperienceWrapper] {

			// Go through each item
			for pew in playExperienceWrappers {
				
				// Add to dictionary
				self.playExperiences![pew.id] = pew
				
			}
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayExperienceSteps
	
	fileprivate func doSetPlayExperienceSteps(wrappers: [String:Any]) {
		
		if (self.playExperienceSteps == nil) {
			
			self.playExperienceSteps = [String:PlayExperienceStepWrapper]()
			
		}
		
		// Get playExperienceStepWrappers
		if let playExperienceStepWrappers = wrappers["PlayExperienceSteps"] as? [PlayExperienceStepWrapper] {
			
			// Go through each item
			for pesw in playExperienceStepWrappers {
				
				// Check existingItem
				if let existingItem = self.playExperienceSteps![pesw.id] {
					
					// Clone to existingItem
					existingItem.clone(fromWrapper: pesw)
					
				} else {
					
					// Add to dictionary
					self.playExperienceSteps![pesw.id] = pesw
					
				}
				
				// Check playExperiencePlayExperienceStepLinks
				if (self.playExperiencePlayExperienceStepLinks == nil) { continue }
				
				// Go through each item
				for pepeslw in self.playExperiencePlayExperienceStepLinks!.values {
					
					// Check playExperienceStepID
					if (pepeslw.playExperienceStepID != pesw.id) { continue }
					
					// Get PlayExperienceWrapper
					if let pew = self.playExperiences?[pepeslw.playExperienceID] {
						
						pew.set(playExperiencePlayExperienceStepLinkWrapper: pepeslw)
						
					}
					
				}

			}
			
		}
		
	}

	
	// MARK: - Private Methods; PlayExperiencePlayExperienceStepLinks
	
	fileprivate func doSetPlayExperiencePlayExperienceStepLinks(wrappers: [String:Any]) {
		
		if (self.playExperiencePlayExperienceStepLinks == nil) {
			
			self.playExperiencePlayExperienceStepLinks = [String:PlayExperiencePlayExperienceStepLinkWrapper]()
			
		}
		
		// Get playExperiencePlayExperienceStepLinkWrappers
		if let playExperiencePlayExperienceStepLinkWrappers = wrappers["PlayExperiencePlayExperienceStepLinks"] as? [PlayExperiencePlayExperienceStepLinkWrapper] {
			
			// Go through each item
			for pepeslw in playExperiencePlayExperienceStepLinkWrappers {

				// Add to dictionary
				self.playExperiencePlayExperienceStepLinks![pepeslw.id] = pepeslw

			}
			
		}
		
	}

	
	// MARK: - Private Methods; PlayExperienceStepExercises
	
	fileprivate func doSetPlayExperienceStepExercises(wrappers: [String:Any]) {
		
		if (self.playExperienceStepExercises == nil) {
			
			self.playExperienceStepExercises = [String:PlayExperienceStepExerciseWrapper]()
			
		}
		
		// Get playExperienceStepExerciseWrappers
		if let playExperienceStepExerciseWrappers = wrappers["PlayExperienceStepExercises"] as? [PlayExperienceStepExerciseWrapper] {
			
			// Go through each item
			for pesew in playExperienceStepExerciseWrappers {
				
				// Add to dictionary
				self.playExperienceStepExercises![pesew.id] = pesew
				
				// Check playExperienceStepPlayExperienceStepExerciseLinks
				if (self.playExperienceStepPlayExperienceStepExerciseLinks == nil) { continue }
				
				// Go through each item
				for pespeselw in self.playExperienceStepPlayExperienceStepExerciseLinks!.values {
					
					// Check playExperienceStepExerciseID
					if (pespeselw.playExperienceStepExerciseID != pesew.id) { continue }
					
					// Get PlayExperienceStepWrapper
					if let pesw = self.playExperienceSteps?[pespeselw.playExperienceStepID] {
						
						pesw.set(playExperienceStepPlayExperienceStepExerciseLinkWrapper: pespeselw)
						
					}
					
				}
				
			}
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayExperienceStepPlayExperienceStepExerciseLinks
	
	fileprivate func doSetPlayExperienceStepPlayExperienceStepExerciseLinks(wrappers: [String:Any]) {
		
		if (self.playExperienceStepPlayExperienceStepExerciseLinks == nil) {
			
			self.playExperienceStepPlayExperienceStepExerciseLinks = [String:PlayExperienceStepPlayExperienceStepExerciseLinkWrapper]()
			
		}
		
		// Get playExperienceStepPlayExperienceStepExerciseLinks
		if let playExperienceStepPlayExperienceStepExerciseLinks = wrappers["PlayExperienceStepPlayExperienceStepExerciseLinks"] as? [PlayExperienceStepPlayExperienceStepExerciseLinkWrapper] {
			
			// Go through each item
			for pespeselw in playExperienceStepPlayExperienceStepExerciseLinks {
				
				// Add to dictionary
				self.playExperienceStepPlayExperienceStepExerciseLinks![pespeselw.id] = pespeselw
				
			}
			
		}
		
	}

	
	// MARK: - Private Methods; PlayAreaPaths
	
	fileprivate func doSetPlayAreaPaths(wrappers: [String:Any]) {
		
		if (self.playAreaPaths == nil) {
			
			self.playAreaPaths = [String:PlayAreaPathWrapper]()
			
		}
		
		// Get playAreaPathWrappers
		if let playAreaPathWrappers = wrappers["PlayAreaPaths"] as? [PlayAreaPathWrapper] {
			
			self.clearPlayAreaPaths()
			
			// Go through each item
			for papw in playAreaPathWrappers {
				
				// Add to dictionary
				self.playAreaPaths![papw.id] = papw
				
			}
			
		}
		
	}

	fileprivate func doClear(playAreaPath wrapper: PlayAreaPathWrapper) {
		
		
		
	}
	
	
	// MARK: - Private Methods; PlayAreaPathPoints
	
	fileprivate func doSetPlayAreaPathPoints(wrappers: [String:Any]) {
		
		// Get playAreaPathPointWrappers
		if let playAreaPathPointWrappers = wrappers["PlayAreaPathPoints"] as? [PlayAreaPathPointWrapper] {
			
			// Go through each item
			for pappw in playAreaPathPointWrappers {
				
				// Get PlayAreaPathWrapper
				if let papw = self.playAreaPaths?[pappw.pathID] {
					
					papw.set(pathPointWrapper: pappw)
					
				}
				
			}
			
		}
		
	}
	
}
