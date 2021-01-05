//
//  PlayChallengeObjectiveListItemViewViewAccessStrategy.swift
//  f30View
//
//  Created by David on 24/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit

/// A strategy for accessing the PlayChallengeObjectiveListItemView view
public class PlayChallengeObjectiveListItemViewViewAccessStrategy {
	
	// MARK: - Private Stored Properties

	fileprivate var playChallengeObjectiveListItemView: ProtocolPlayChallengeObjectiveListItemView?

	
	// MARK: - Initializers
	
	public init() {
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup(playChallengeObjectiveListItemView: ProtocolPlayChallengeObjectiveListItemView) {

		self.playChallengeObjectiveListItemView	= playChallengeObjectiveListItemView

	}
	
}

// MARK: - Extension ProtocolPlayChallengeObjectiveListItemViewViewAccessStrategy

extension PlayChallengeObjectiveListItemViewViewAccessStrategy: ProtocolPlayChallengeObjectiveListItemViewViewAccessStrategy {
	
	// MARK: - Methods
	
	public func displayIsCompleteYN(isCompleteYN: Bool) {
		
		self.playChallengeObjectiveListItemView!.set(isCompleteYN: isCompleteYN)
		
	}

}
