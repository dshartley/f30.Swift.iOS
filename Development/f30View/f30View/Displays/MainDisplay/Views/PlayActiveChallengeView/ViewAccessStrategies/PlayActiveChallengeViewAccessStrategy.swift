//
//  PlayActiveChallengeViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the PlayActiveChallengeView view
public class PlayActiveChallengeViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playActiveChallengeView: 	ProtocolPlayActiveChallengeView?
	fileprivate var titleLabel: 				UILabel?
	
	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playActiveChallengeView: ProtocolPlayActiveChallengeView,
					  titleLabel: UILabel) {
		
		self.playActiveChallengeView 	= playActiveChallengeView
		self.titleLabel 				= titleLabel
		
	}
	
}

// MARK: - Extension ProtocolPlayActiveChallengeViewViewAccessStrategy

extension PlayActiveChallengeViewViewAccessStrategy: ProtocolPlayActiveChallengeViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func displayTitle(title: String) -> Void {
		
		self.titleLabel!.text = title
		
	}
	
	public func present(playChallengeObjectiveListItemView view: ProtocolPlayChallengeObjectiveListItemView) {

		self.playActiveChallengeView!.present(playChallengeObjectiveListItemView: view)
		
	}
	
}
