//
//  DashboardBarView.swift
//  f30
//
//  Created by David on 30/08/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import f30Core
import SFView

/// Specifies dummy options
public enum DummyOptions: Int {
	case option1	= 1
	case option2	= 2
}

public enum DashboardBarTabItems: Int {
	case playArea
	case playGames
	case none
}

/// A view class for a DashboardBarView
public class DashboardBarView: UIView {

	// MARK: - Private Stored Properties

	fileprivate var selectedColor: 										UIColor = UIColor(red: (52 / 255), green: (152 / 255), blue: (219 / 255), alpha: 1) // Blue
	fileprivate var unselectedColor: 									UIColor = UIColor(red: (170 / 255), green: (170 / 255), blue: (170 / 255), alpha: 1) // Light grey
	fileprivate var unselectedAlpha: 									CGFloat = 0.5
	fileprivate var selectedDashboardBarTabItem:						DashboardBarTabItems = DashboardBarTabItems.none
	fileprivate var playResultsButtonIsSelectedYN: 						Bool = false
	fileprivate var menuButtonIsSelectedYN: 							Bool = false
	
	
	// MARK: - Public Stored Properties
	
	public var delegate:												ProtocolDashboardBarViewDelegate?
	
	@IBOutlet var contentView:											UIView!
	@IBOutlet weak var playAreaButtonView: 								UIView!
	@IBOutlet weak var playAreaButtonLabel:								UILabel!
	@IBOutlet weak var playAreaButtonSelectedImageView: 				UIImageView!
	@IBOutlet weak var playAreaButtonUnselectedImageView: 				UIImageView!
	@IBOutlet weak var playGamesButtonView: 							UIView!
	@IBOutlet weak var playGamesButtonLabel:							UILabel!
	@IBOutlet weak var playGamesButtonSelectedImageView: 				UIImageView!
	@IBOutlet weak var playGamesButtonUnselectedImageView: 				UIImageView!
	@IBOutlet weak var playResultsButtonView: 							UIView!
	@IBOutlet weak var playResultsButtonSelectedImageView: 				UIImageView!
	@IBOutlet weak var playResultsButtonUnselectedImageView: 			UIImageView!
	@IBOutlet weak var menuButtonView: 									UIView!
	@IBOutlet weak var menuButtonSelectedImageView: 					UIImageView!
	@IBOutlet weak var menuButtonUnselectedImageView: 					UIImageView!
	@IBOutlet weak var avatarImageFrameView: 							UIView!
	@IBOutlet weak var avatarImageView: 								UIImageView!
	
	
	// MARK: - Initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setup()
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setup()
	}
	
	
	// MARK: - Override Methods
	
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
	
		// Notify the delegate
		self.delegate?.dashboardBarView(touchesBegan: self)
		
	}
	
	
	// MARK: - Public Methods
	
	public func setup() {

		self.setupContentView()
		self.setupPlayAreaButtonView()
		self.setupPlayGamesButtonView()
		self.setupPlayResultsButtonView()
		self.setupMenuButtonView()
		self.setupAvatarImageView()
		
		self.doSetDashboardBarButtonsNoAnimation()
		
		self.displayAvatar()
		
	}

	public func set(dashboardBarTabItem: DashboardBarTabItems, animateYN: Bool) {
		
		self.selectedDashboardBarTabItem = dashboardBarTabItem
		
		if (animateYN) {
			
			self.doSetDashboardBarButtonsAnimation()
			
		} else {
			
			self.doSetDashboardBarButtonsNoAnimation()
			
		}
		
	}
	
	public func set(playResultsButtonIsSelectedYN: Bool, animateYN: Bool) {
		
		self.playResultsButtonIsSelectedYN = playResultsButtonIsSelectedYN
		
		if (animateYN) {
			
			self.doSetPlayResultsButtonAnimation()
			
		} else {
			
			self.doSetPlayResultsButton(isSelectedYN: self.playResultsButtonIsSelectedYN)
			
		}
		
	}
	
	public func set(menuButtonIsSelectedYN: Bool, animateYN: Bool) {
		
		self.menuButtonIsSelectedYN = menuButtonIsSelectedYN
		
		if (animateYN) {
			
			self.doSetMenuButtonAnimation()
			
		} else {
			
			self.doSetMenuButton(isSelectedYN: self.menuButtonIsSelectedYN)
			
		}
		
	}
	
	public func set(displayAvatarYN: Bool) {
		
		// avatar
		if (displayAvatarYN) { self.displayAvatar() }
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("DashboardBarView", owner: self, options: nil)
		
		addSubview(contentView)
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
		
	}

	fileprivate func setupAvatarImageView() {
		
		UIViewHelper.makeCircle(view: self.avatarImageFrameView)
	
		let avatarBlankImage: UIImage = UIImage(named: "Avatar")!
		
		self.avatarImageView.image = avatarBlankImage
		
	}
	
	fileprivate func setupPlayAreaButtonView() {
		
		// Nb: Hidden
		
		//self.playAreaButtonView.alpha = 0

	}
	
	fileprivate func setupPlayGamesButtonView() {

		// Nb: Hidden
		
		//self.playGamesButtonView.alpha = 0
		
	}
	
	fileprivate func setupPlayResultsButtonView() {
		
	}
	
	fileprivate func setupMenuButtonView() {

	}
	
	fileprivate func doSetDashboardBarButtonsAnimation() {
		
		UIView.animate(withDuration: 0.3, animations: {
			
			self.doSetPlayAreaButton(isSelectedYN: (self.selectedDashboardBarTabItem == .playArea))
			self.doSetPlayGamesButton(isSelectedYN: (self.selectedDashboardBarTabItem == .playGames))
			self.doSetMenuButton(isSelectedYN: self.menuButtonIsSelectedYN)
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetDashboardBarButtonsNoAnimation() {
		
		self.doSetPlayAreaButton(isSelectedYN: (self.selectedDashboardBarTabItem == .playArea))
		self.doSetPlayGamesButton(isSelectedYN: (self.selectedDashboardBarTabItem == .playGames))
		self.doSetPlayResultsButton(isSelectedYN: self.playResultsButtonIsSelectedYN)
		self.doSetMenuButton(isSelectedYN: self.menuButtonIsSelectedYN)
		
	}

	fileprivate func doSetPlayAreaButton(isSelectedYN: Bool) {
		
		if (isSelectedYN) {
			
			self.playAreaButtonSelectedImageView.alpha 		= 1
			self.playAreaButtonUnselectedImageView.alpha 	= 0
			self.playAreaButtonLabel.textColor 				= self.selectedColor
			
		} else {
			
			self.playAreaButtonSelectedImageView.alpha 		= 0
			self.playAreaButtonUnselectedImageView.alpha 	= 1
			self.playAreaButtonLabel.textColor 				= self.unselectedColor
			
		}
		
	}

	fileprivate func doSetPlayGamesButton(isSelectedYN: Bool) {
		
		if (isSelectedYN) {
			
			self.playGamesButtonSelectedImageView.alpha 	= 1
			self.playGamesButtonUnselectedImageView.alpha 	= 0
			self.playGamesButtonLabel.textColor 			= self.selectedColor
			
		} else {
			
			self.playGamesButtonSelectedImageView.alpha 	= 0
			self.playGamesButtonUnselectedImageView.alpha 	= 1
			self.playGamesButtonLabel.textColor 			= self.unselectedColor
			
		}
		
	}
	
	fileprivate func doSetPlayResultsButtonAnimation() {
		
		UIView.animate(withDuration: 0.3, animations: {
			
			self.doSetPlayResultsButton(isSelectedYN: self.playResultsButtonIsSelectedYN)
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetPlayResultsButton(isSelectedYN: Bool) {
		
		if (isSelectedYN) {
			
			self.playResultsButtonSelectedImageView.alpha 	= 1
			self.playResultsButtonUnselectedImageView.alpha = 0
			
		} else {
			
			self.playResultsButtonSelectedImageView.alpha 	= 0
			self.playResultsButtonUnselectedImageView.alpha = 1
			
		}
		
	}
	
	fileprivate func doSetMenuButtonAnimation() {
		
		UIView.animate(withDuration: 0.3, animations: {
			
			self.doSetMenuButton(isSelectedYN: self.menuButtonIsSelectedYN)
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetMenuButton(isSelectedYN: Bool) {
		
		if (isSelectedYN) {
			
			self.menuButtonSelectedImageView.alpha 		= 1
			self.menuButtonUnselectedImageView.alpha 	= 0
			
		} else {

			self.menuButtonSelectedImageView.alpha 		= 0
			self.menuButtonUnselectedImageView.alpha 	= 1
			
		}
		
	}

	fileprivate func onAvatarImageTapped() {
		
		self.deselectMenus()
		
		// Notify the delegate
		self.delegate?.dashboardBarView(avatarImageTapped: self)
		
	}
	
	fileprivate func onPlayAreaButtonTapped() {
		
		self.deselectMenus()
		
		// Check selectedDashboardBarTabItem
		guard (self.selectedDashboardBarTabItem != .playArea) else {
			
			return
		}
		
		self.selectedDashboardBarTabItem = .playArea
		
		self.doSetDashboardBarButtonsNoAnimation()
		
		// Notify the delegate
		self.delegate?.dashboardBarView(playAreaButtonTapped: self)
		
	}

	fileprivate func onPlayGamesButtonTapped() {
		
		self.deselectMenus()
		
		// Check selectedDashboardBarTabItem
		guard (self.selectedDashboardBarTabItem != .playGames) else {
			
			return
		}
		
		self.selectedDashboardBarTabItem = .playGames
		
		self.doSetDashboardBarButtonsNoAnimation()
		
		// Notify the delegate
		self.delegate?.dashboardBarView(playGamesButtonTapped: self)
		
	}
	
	fileprivate func onPlayResultsDismissed() {
		
		self.playResultsButtonIsSelectedYN = false
		
		self.doSetPlayResultsButtonAnimation()
		
		// Notify the delegate
		self.delegate?.dashboardBarView(playResultsDismissed: self)
		
	}
	
	fileprivate func onPlayResultsButtonTapped() {
		
		// Check menuButtonIsSelectedYN
		if (self.menuButtonIsSelectedYN) {
			
			self.onMenuDismissed()

		}
		
		self.playResultsButtonIsSelectedYN = !self.playResultsButtonIsSelectedYN
		
		self.doSetPlayResultsButtonAnimation()
		
		// Notify the delegate
		self.delegate?.dashboardBarView(playResultsButtonTapped: self)
		
	}
	
	fileprivate func onMenuDismissed() {
		
		self.menuButtonIsSelectedYN = false
		
		self.doSetMenuButtonAnimation()
		
		// Notify the delegate
		self.delegate?.dashboardBarView(menuDismissed: self)
		
	}
	
	fileprivate func onMenuButtonTapped() {

		// Check playResultsButtonIsSelectedYN
		if (self.playResultsButtonIsSelectedYN) {
			
			self.onPlayResultsDismissed()
			
			return
		}
		
		self.menuButtonIsSelectedYN = !self.menuButtonIsSelectedYN
		
		self.doSetMenuButtonAnimation()

		// Notify the delegate
		self.delegate?.dashboardBarView(menuButtonTapped: self)
		
	}
	
	fileprivate func deselectMenus() {

		// Check playResultsButtonIsSelectedYN
		if (self.playResultsButtonIsSelectedYN) {
			
			self.onPlayResultsDismissed()
			
			return
		}
		
		// Check menuButtonIsSelectedYN
		if (self.menuButtonIsSelectedYN) {
			
			self.onMenuDismissed()
			
			return
		}
		
	}
	
	fileprivate func displayAvatar() {
		
		guard (UserProfileWrapper.current != nil) else { return }
		
		// Get image from avatarImageData
		let avatarImageData: Data? = UserProfileWrapper.current!.avatarImageData
		
		if (avatarImageData != nil) {
			
			// Create image
			let image: UIImage = UIImage(data: avatarImageData!)!
			
			// Display image
			self.avatarImageView.image = image
	
		}
		
	}
	
	
	// MARK: - avatarImage Methods TapGestureRecognizer Methods
	
	@IBAction func avatarImageTapped(_ sender: Any) {
		
		self.onAvatarImageTapped()
		
	}
	
	
	// MARK: - playAreaButton Methods TapGestureRecognizer Methods
	
	@IBAction func playAreaButtonTapped(_ sender: Any) {
		
		self.onPlayAreaButtonTapped()
		
	}

	
	// MARK: - playAreaButtonLabel TapGestureRecognizer Methods
	
	@IBAction func playAreaButtonLabelTapped(_ sender: Any) {
		
		self.onPlayAreaButtonTapped()
	}

	
	// MARK: - playGamesButton Methods TapGestureRecognizer Methods
	
	@IBAction func playGamesButtonTapped(_ sender: Any) {
		
		self.onPlayGamesButtonTapped()
		
	}
	
	
	// MARK: - playGamesButtonLabel TapGestureRecognizer Methods
	
	@IBAction func playGamesButtonLabelTapped(_ sender: Any) {
		
		self.onPlayGamesButtonTapped()
	}
	

	// MARK: - menuButton Methods TapGestureRecognizer Methods
	
	@IBAction func menuButtonTapped(_ sender: Any) {
		
		self.onMenuButtonTapped()
		
	}

	
	// MARK: - playResultsButton Methods TapGestureRecognizer Methods
	
	@IBAction func playResultsButtonTapped(_ sender: Any) {
		
		self.onPlayResultsButtonTapped()
		
	}
	
}
