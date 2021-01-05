//
//  ProtocolLanguagePopoverViewViewControllerDelegate.swift
//  f30
//
//  Created by David on 25/02/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import UIKit

/// Defines a delegate for a LanguagePopoverViewViewController class
public protocol ProtocolLanguagePopoverViewViewControllerDelegate: class {
	
	// MARK: - Methods
	
	func languagePopoverViewViewController(sender: LanguagePopoverViewViewController, languageSelected languageID: String)
	
}
