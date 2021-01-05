//
//  ProtocolDashboardBarViewDelegate.swift
//  f30
//
//  Created by David on 30/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import f30Core

/// Defines a delegate for a DashboardBarView class
public protocol ProtocolDashboardBarViewDelegate {
	
	// MARK: - Methods
	
	func dashboardBarView(touchesBegan sender: DashboardBarView)
	
	func dashboardBarView(avatarImageTapped sender: DashboardBarView)
	
	func dashboardBarView(playAreaButtonTapped sender: DashboardBarView)

	func dashboardBarView(playGamesButtonTapped sender: DashboardBarView)

	func dashboardBarView(playActiveChallengeButtonTapped sender: DashboardBarView)
	
	func dashboardBarView(playActiveChallengeDismissed sender: DashboardBarView)
	
	func dashboardBarView(playResultsButtonTapped sender: DashboardBarView)
	
	func dashboardBarView(playResultsDismissed sender: DashboardBarView)
	
	func dashboardBarView(menuButtonTapped sender: DashboardBarView)
	
	func dashboardBarView(menuDismissed sender: DashboardBarView)
	
}
