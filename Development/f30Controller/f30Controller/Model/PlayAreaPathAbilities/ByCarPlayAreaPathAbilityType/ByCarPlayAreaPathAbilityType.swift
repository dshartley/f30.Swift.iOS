//
//  ByCarPlayAreaPathAbilityType.swift
//  f30Controller
//
//  Created by David on 03/08/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import f30Model
import f30Core
import SFGridScape

/// A PlayAreaPathAbilityType class
public class ByCarPlayAreaPathAbilityType {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public fileprivate(set) var type: PlayAreaPathAbilityTypes = .ByCar
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolPlayAreaPathAbilityType

extension ByCarPlayAreaPathAbilityType: ProtocolPlayAreaPathAbilityType {
	
	// MARK: - Methods
	
	
	// MARK: - Public Class Methods
	
	public class func setup(wrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) {
		
		// Get canStartYN
		wrapper.canStartYN 		= ByCarPlayAreaPathAbilityType.canStart(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
		// Get canGoYN
		wrapper.canGoYN 		= ByCarPlayAreaPathAbilityType.canGo(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
		// Get canStopYN
		wrapper.canStopYN 		= ByCarPlayAreaPathAbilityType.canStop(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
		// Get distanceCanGo
		wrapper.distanceCanGo	= ByCarPlayAreaPathAbilityType.distanceCanGo(for: playAreaTokenWrapper, at: playAreaCellWrapper)
		
	}
	
	public class func isEnabled(for playAreaTokenWrapper: PlayAreaTokenWrapper) -> Bool {
		
		return true
		
	}
	
	public class func canStart(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool {
		
		var result: Bool = false

		let caw: 	CellAttributesWrapper = playAreaCellWrapper.cellAttributesWrapper
		let ctaw: 	CellAttributesWrapper? = playAreaCellWrapper.cellTypeWrapper?.cellAttributesWrapper
		
		// Check 'road' attribute
		if (caw.get(attribute: "road") != nil || ctaw?.get(attribute: "road") != nil) {

			result = true
			
		}
		
		return result
		
	}
	
	public class func canGo(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool {
		
		var result: Bool = false
		
		let caw: 	CellAttributesWrapper = playAreaCellWrapper.cellAttributesWrapper
		let ctaw: 	CellAttributesWrapper? = playAreaCellWrapper.cellTypeWrapper?.cellAttributesWrapper
		
		// Check 'road' attribute
		if (caw.get(attribute: "road") != nil || ctaw?.get(attribute: "road") != nil) {
			
			result = true
			
		}
		
		return result
		
	}
	
	public class func canStop(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Bool {
		
		var result: Bool = false
		
		let caw: 	CellAttributesWrapper = playAreaCellWrapper.cellAttributesWrapper
		let ctaw: 	CellAttributesWrapper? = playAreaCellWrapper.cellTypeWrapper?.cellAttributesWrapper
		
		// Check 'road' attribute
		if (caw.get(attribute: "road") != nil || ctaw?.get(attribute: "road") != nil) {
			
			result = true
			
		}
		
		return result
		
	}
	
	public class func distanceCanGo(for playAreaTokenWrapper: PlayAreaTokenWrapper, at playAreaCellWrapper: PlayAreaCellWrapper) -> Int {
		
		return 100
		
	}
	
}

