//
//  OnCompleteDataWrapperBase.swift
//  f30Model
//
//  Created by David on 05/02/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import Foundation
import f30Core
import SFSerialization

/// A base class for classes which are a wrapper for a OnCompleteData model item
open class OnCompleteDataWrapperBase {
	
	// MARK: - Private Stored Properties
	
	fileprivate let pointsKey: 				String = "\(DataItemDataJSONWrapperKeys.Points)"
	
	
	// MARK: - Public Stored Properties

	public var wrapper: 					DataJSONWrapper?
	public fileprivate(set) var points:		[String:Int] = [String:Int]()
	
	
	// MARK: - Public Computed Properties
	
	public var numberOfPoints: Int {
		get {
			return self.points["1"] ?? 0
		}
		set(value) {
			self.points["1"] = value
		}
	}

	public var numberOfExperiencePoints: Int {
		get {
			return self.points["2"] ?? 0
		}
		set(value) {
			self.points["2"] = value
		}
	}
	
	public var numberOfFeathers: Int {
		get {
			return self.points["3"] ?? 0
		}
		set(value) {
			self.points["3"] = value
		}
	}
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	public init(onCompleteData: String) {

		self.set(onCompleteData: onCompleteData)
		
	}
	
	
	// MARK: - Public Methods

	public func doSerializePointsToWrapper() {
		
		guard (self.wrapper != nil) else { return }
		
		// Get pointsWrapper
		var pointsWrapper: 			DataJSONWrapper? = self.wrapper!.getItem(id: pointsKey)
		
		if (pointsWrapper == nil) {
			
			// Create pointsWrapper
			pointsWrapper 			= DataJSONWrapper()
			pointsWrapper!.ID 		= pointsKey
			self.wrapper!.Items.append(pointsWrapper!)
			
		}
		
		pointsWrapper!.Params.removeAll()
		
		// Go through each item
		for (key, value) in self.points {
			
			pointsWrapper!.setParameterValue(key: key, value: "\(value)")
			
		}
		
	}
	
	public func doDeserializePointsToWrapper() {
		
		guard (self.wrapper != nil) else { return }
		
		self.points = [String:Int]()
		
		// Get pointsWrapper
		let pointsWrapper: 			DataJSONWrapper? = self.wrapper!.getItem(id: pointsKey)
		
		guard (pointsWrapper != nil) else { return }
		
		// Go through each item
		for param in pointsWrapper!.Params {
			
			self.points[param.Key] 	= Int(param.Value) ?? 0
			
		}
		
	}
	
	public func appendPoints(from onCompleteDataWrapper: OnCompleteDataWrapperBase) {
	
		// Go through each item
		for (key, value) in onCompleteDataWrapper.points {
			
			// Get currentValue
			let currentValue: 	Int = self.points[key] ?? 0
			
			self.points[key] 	= (currentValue + value)
			
		}
		
	}
	
	
	// MARK: - Open [Overridable] Methods

	open func set(onCompleteData: String) {
		
		//guard (onCompleteData.count > 0) else { return }
		
		// Get DataJSONWrapper from onCompleteData
		self.wrapper = (onCompleteData.count > 0) ? JSONHelper.DeserializeDataJSONWrapper(dataString: onCompleteData) : DataJSONWrapper()
		
		guard (self.wrapper != nil) else { return }
		
		// Deserialize points
		self.doDeserializePointsToWrapper()

	}
	
	open func serialize() -> String {
		
		var 	result: String = ""
		
		guard (self.wrapper != nil) else { return result }
		
		// Serialize points
		self.doSerializePointsToWrapper()
		
		result 	= JSONHelper.SerializeDataJSONWrapper(dataWrapper: self.wrapper!) ?? ""
		
		return result
		
	}
	
	
	// MARK: - Private Methods
	
}
