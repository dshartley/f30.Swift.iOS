//
//  PlayGamesTableViewCell.swift
//  f30
//
//  Created by David on 24/03/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import f30Model

/// A class for a PlayGamesTableViewCell
public class PlayGamesTableViewCell: UITableViewCell {

	// MARK: - Private Stored Properties
	
	fileprivate var isActivePlayGameYN: 				Bool = false
	fileprivate var canDeleteYN: 						Bool = true
	fileprivate let notActiveBorderColor: 				UIColor = UIColor(red: (170 / 255), green: (170 / 255), blue: (170 / 255), alpha: 0.5) // Light grey
	fileprivate let activeBorderColor: 					UIColor = UIColor(red: (89 / 255), green: (232 / 255), blue: (82 / 255), alpha: 1.0) // Green 59e852
	fileprivate let dateLastPlayedLabelNormalColor: 	UIColor = UIColor.darkGray

	
	
	// MARK: - Public Stored Properties
	
	public var delegate:								ProtocolPlayGamesTableViewCellDelegate?
	public fileprivate(set) var wrapper:				PlayGameWrapper? = nil
	
	@IBOutlet weak var containerView: 					UIView!
	@IBOutlet weak var gameNameLabel: 					UILabel!
	@IBOutlet weak var gameImageImageView: 				UIImageView!
	@IBOutlet weak var gameImageContainerView: 			UIView!
	@IBOutlet weak var isActivePlayGameImageView: 		UIImageView!
	@IBOutlet weak var deletePlayGameButton: 			UIButton!
	@IBOutlet weak var numberofPointsLabel: 			UILabel!
	@IBOutlet weak var numberofFeathersLabel: 			UILabel!
	@IBOutlet weak var dateLastPlayedLabel: 			UILabel!
	@IBOutlet weak var languageFlagImageContainerView: 	UIView!
	@IBOutlet weak var languageFlagImageImageView: 		UIImageView!
	
	
	// MARK: - Private Stored Properties
	
	
	// MARK: - Public Methods
	
	public func set(wrapper: PlayGameWrapper, isActivePlayGameYN: Bool, canDeleteYN: Bool) {
		
		self.wrapper 				= wrapper
		self.isActivePlayGameYN		= isActivePlayGameYN
		self.canDeleteYN			= canDeleteYN
		
		self.setupIsActivePlayGameImageView()
		self.setupIsActiveDateLastPlayedLabel()
		self.setupIsActiveBorder()
		self.setupDeletePlayGameButton()
		
		self.displayItem()
		
	}
	
	
	// MARK: - Override Methods
	
	public override func awakeFromNib() {
		super.awakeFromNib()
		// Initialization code
		
		self.setup()
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		//self.setupContentView()
	
		self.setupContainerView()
		self.setupGameImageView()
		self.setupLanguageFlagImageView()
		self.setupTapGestureRecognizer()
		
	}
	
	fileprivate func setupTapGestureRecognizer() {
		
		// The tapGestureRecognizer must be setup in code rather than in the .xib to avoid errors
		
		let tapGestureRecognizer: UITapGestureRecognizer = UITapGestureRecognizer(target: self, action: #selector(PlayGamesTableViewCell.gameNameLabelTapped(_:)))

		self.gameNameLabel.addGestureRecognizer(tapGestureRecognizer)
		
	}
	
	fileprivate func setupContainerView() {
		
		self.containerView.layer.borderWidth	= 1.0;
		self.containerView.layer.borderColor 	= self.notActiveBorderColor.cgColor
		self.containerView.layer.masksToBounds 	= true;
		
		self.containerView.layer.cornerRadius 	= 10.0;
	}
	
	fileprivate func setupGameImageView() {
		
		// gameImageContainerView
		UIViewHelper.roundCorners(view: self.gameImageContainerView, corners: UIRectCorner.allCorners, radius: 10.0)
		
	}
	
	fileprivate func setupLanguageFlagImageView() {
		
		// languageFlagImageContainerView
		UIViewHelper.roundCorners(view: self.languageFlagImageContainerView, corners: UIRectCorner.allCorners, radius: 5.0)
		
	}
	
	fileprivate func displayItem() {
		
		guard (self.wrapper != nil) else { return }
		
		self.displayGameName()
		self.displayGameImage()
		self.displayNumberofPoints()
		self.displayNumberofFeathers()
		self.displayLanguage()
		self.displayDateLastPlayed()
		
	}
	
	fileprivate func displayGameName() {
		
		// gameNameLabel
		self.gameNameLabel.text	= self.wrapper!.name
		
	}

	fileprivate func displayGameImage() {

		var backgroundColor: UIColor? = nil
		
		// Get backgroundColor
		//if (self.wrapper!.imageBackgroundColor.count > 0) {
		//
		//	backgroundColor = UIColorHelper.toColor(hex: self.wrapper!.imageBackgroundColor)
		//
		//}
		
		if (backgroundColor == nil) { backgroundColor = UIColorHelper.randomColor() }
		
		self.gameImageContainerView.backgroundColor = backgroundColor
		
		// Clear the image
		//self.gameImageImageView.image 		= nil

		// TODO:
//		if (self.item == nil) {
//
//			return
//
//		} else if (self.item!.gameImageData != nil) {
//
//			// Set the image
//			self.gameImageImageView.alpha 	= 1
//			self.gameImageImageView.image 	= UIImage(data: self.item!.gameImageData!)
//
//		} else if (self.item!.gameImageData == nil) {
//
//			// Hide the image
//			self.gameImageImageView.alpha 	= 0
//
//		}
		
	}

	fileprivate func displayNumberofPoints() {
		
		let w: 		PlayGameDataOnCompleteDataWrapper? = self.wrapper!.playGameData!.playGameDataOnCompleteData!
		
		self.numberofPointsLabel.text = "\(w!.numberOfPoints)"
		
	}
	
	fileprivate func displayNumberofFeathers() {
		
		let w: 		PlayGameDataOnCompleteDataWrapper? = self.wrapper!.playGameData!.playGameDataOnCompleteData!
		
		self.numberofFeathersLabel.text = "\(w!.numberOfFeathers)"
		
	}

	fileprivate func displayLanguage() {
		
		self.languageFlagImageImageView.image 		= nil
		
		// Get PlaySubsetWrapper
		let psw: 									PlaySubsetWrapper? = PlayWrapper.current?.playSubsets?[self.wrapper!.playSubsetID]
		
		guard (psw != nil) else { return }
		
		if (psw!.thumbnailImageData != nil) {
			
			self.languageFlagImageImageView.image 	= UIImage(data: psw!.thumbnailImageData!)
			
		}
		
	}
	
	fileprivate func displayDateLastPlayed() {
		
		// Get dateLastPlayedString from dateFormatter
		let dateFormatter				= DateFormatter()
		dateFormatter.dateFormat		= "MMM d, yyyy"
		dateFormatter.timeZone 			= TimeZone(secondsFromGMT: 0)
		
		let dateLastPlayedString 		= dateFormatter.string(from: self.wrapper!.playGameData!.dateLastPlayed)
		
		self.dateLastPlayedLabel.text 	= dateLastPlayedString
	}
	
	fileprivate func setupIsActivePlayGameImageView() {
		
		self.isActivePlayGameImageView.alpha = (self.isActivePlayGameYN) ? 1 : 0
		
	}

	fileprivate func setupIsActiveDateLastPlayedLabel() {
		
		self.dateLastPlayedLabel.textColor = (self.isActivePlayGameYN) ? self.activeBorderColor : self.dateLastPlayedLabelNormalColor
		
	}

	fileprivate func setupIsActiveBorder() {
		
		self.containerView.layer.borderColor = (self.isActivePlayGameYN) ? self.activeBorderColor.cgColor : self.notActiveBorderColor.cgColor
		
	}
	
	fileprivate func setupDeletePlayGameButton() {
		
		self.deletePlayGameButton.alpha = (self.canDeleteYN) ? 1 : 0
		
	}
	
	
	// MARK: - gameNameLabel TapGestureRecognizer Methods
	
	@IBAction func gameNameLabelTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playGamesTableViewCell(cell: self, itemTapped: self.wrapper!)

	}
	
	
	// MARK: - editPlayGameButton Methods
	
	@IBAction func editPlayGameButtonTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playGamesTableViewCell(cell: self, editButtonTapped: self.wrapper!)
		
	}
	
	
	// MARK: - deletePlayGameButton Methods
	
	@IBAction func deletePlayGameButtonTapped(_ sender: Any) {
		
		// Notify the delegate
		self.delegate?.playGamesTableViewCell(cell: self, deleteButtonTapped: self.wrapper!)
		
	}

}
