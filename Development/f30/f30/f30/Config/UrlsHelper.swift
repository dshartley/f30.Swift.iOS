//
//  UrlsHelper.swift
//  f30
//
//  Created by David on 07/11/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit

/// A helper for handling Urls.strings
public final class UrlsHelper {

	// MARK: - Initializers
	
	private init () {}
	
	
	// MARK: - Static Computed Properties
	
	public static var imagesUrlRoot: String = {
		
		let result: String = NSLocalizedString("ImagesUrlRoot", tableName: "Urls", comment: "")

		return result
		
	}()
	
}
