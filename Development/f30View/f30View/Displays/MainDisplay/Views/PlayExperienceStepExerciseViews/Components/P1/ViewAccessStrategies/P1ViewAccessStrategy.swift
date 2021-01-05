//
//  P1ViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the P1 view
public class P1ViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var contentImageView:	UIImageView?

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(contentImageView: UIImageView) {

		self.contentImageView = contentImageView

	}
	
}

// MARK: - Extension ProtocolP1ViewAccessStrategy

extension P1ViewAccessStrategy: ProtocolP1ViewAccessStrategy {
	
	// MARK: - Methods
	
	public func displayContentImage(image: UIImage) {
		
		self.contentImageView!.image = image
		
	}
	
}
