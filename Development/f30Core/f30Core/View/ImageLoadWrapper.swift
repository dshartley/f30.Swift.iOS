//
//  ImageLoadWrapper.swift
//  f30Core
//
//  Created by David on 14/07/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

public enum ImageLoadTypes {
	case PlayExperienceContentImage
	case PlayExperienceThumbnailImage
	case PlayExperienceStepContentImage
	case PlayExperienceStepThumbnailImage
	case PlayExperienceStepExerciseContentImage
}

/// A wrapper for a ImageLoad
public class ImageLoadWrapper {
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Stored Properties
	
	public var type: 		ImageLoadTypes = .PlayExperienceContentImage
	public var key:			String?
	public var fileName:	String?
	public var container:	Any?
	public var params:		[String:Any] = [String:Any]()
	
	
	// MARK: - Initializers
	
	public init() {
	}
	
	
	// MARK: - Public Methods
	
}

