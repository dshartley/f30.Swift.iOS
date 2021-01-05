//
//  PlayExperienceStepMarkerViewControlManager.swift
//  f30Controller
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFCore
import SFController
import f30View
import f30Model
import f30Core

/// Manages the PlayExperienceStepMarkerView control layer
public class PlayExperienceStepMarkerViewControlManager: ControlManagerBase {
	
	// MARK: - Public Stored Properties
	
	public weak var delegate:								ProtocolPlayExperienceStepMarkerViewControlManagerDelegate?
	public var viewManager:									PlayExperienceStepMarkerViewViewManager?
	public fileprivate(set) var playExperienceWrapper:	PlayExperienceWrapper?
	public fileprivate(set) var playExperienceStepWrapper:	PlayExperienceStepWrapper?
	
	
	// MARK: - Private Stored Properties

	
	// MARK: - Initializers
	
	public override init() {
		super.init()
	}
	
	public init(modelManager: ModelManager, viewManager: PlayExperienceStepMarkerViewViewManager) {
		super.init(modelManager: modelManager)
		
		self.viewManager				= viewManager
	}
	
	
	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper) {
		
		self.playExperienceWrapper 		= playExperienceWrapper
		self.playExperienceStepWrapper 	= playExperienceStepWrapper
		
		// Get title
		let title: String = self.playExperienceStepWrapper!.playExperienceStepContentData!.get(key: "\(PlayExperienceStepContentDataKeys.Title)") ?? ""
		
		print("title=" + title)
		
		self.viewManager!.display(playExperienceStepName: title)
		
		// Get thumbnailImage
		if let thumbnailImageData = self.playExperienceStepWrapper!.thumbnailImageData {
			
			let thumbnailImage: UIImage = UIImage(data: thumbnailImageData)!
			
			self.viewManager!.displayThumbnailImage(image: thumbnailImage)
			
		}
		
		// isCompleteYN
		self.viewManager!.displayIsCompleteYN(isCompleteYN: self.playExperienceStepWrapper!.isCompleteYN)
		
		// isActiveYN
		self.viewManager!.displayIsActiveYN(isActiveYN: self.playExperienceStepWrapper!.isActiveYN)
		
	}
	
	
	// MARK: - Override Methods
	
	
	// MARK: - Private Methods
	
}
