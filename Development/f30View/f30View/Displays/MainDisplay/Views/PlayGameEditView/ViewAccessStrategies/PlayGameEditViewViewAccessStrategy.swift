//
//  PlayGameEditViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the PlayGameEditView view
public class PlayGameEditViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var gameImageImageView: 			UIImageView?
	fileprivate var gameNameTextField: 				UITextField?
	fileprivate var languageFlagImageImageView: 	UIImageView?
	fileprivate var languageNameLabel: 				UILabel?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(	gameImageImageView: UIImageView,
						gameNameTextField: UITextField,
						languageFlagImageImageView: UIImageView,
						languageNameLabel: UILabel) {
		
		self.gameImageImageView 			= gameImageImageView
		self.gameNameTextField 				= gameNameTextField
		self.languageFlagImageImageView 	= languageFlagImageImageView
		self.languageNameLabel 				= languageNameLabel
		
	}
	
}

// MARK: - Extension ProtocolPlayGameEditViewViewAccessStrategy

extension PlayGameEditViewViewAccessStrategy: ProtocolPlayGameEditViewViewAccessStrategy {
	
	// MARK: - Methods
	
}
