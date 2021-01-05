//
//  P1SubItemViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the P1SubItem view
public class P1SubItemViewAccessStrategy {
	
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

// MARK: - Extension ProtocolP1SubItemViewAccessStrategy

extension P1SubItemViewAccessStrategy: ProtocolP1SubItemViewAccessStrategy {
	
	// MARK: - Methods
	
	public func displayContentImage(image: UIImage) {
		
		self.contentImageView!.image = image
		
	}
	
}
