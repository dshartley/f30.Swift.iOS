//
//  LanguagePopoverViewViewController.swift
//  f30
//
//  Created by David on 25/02/2019.
//  Copyright © 2019 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import f30Model

/// A ViewController for the LanguagePopoverView
public class LanguagePopoverViewViewController: UIViewController {

	// MARK: - Private Stored Properties
	
	fileprivate var wrappers: 					[PlaySubsetWrapper]?
	
	
	// MARK: - Public Stored Properties
	
	public weak var delegate: 					ProtocolLanguagePopoverViewViewControllerDelegate?

	@IBOutlet weak var playSubsetsStackView: 	UIStackView!
	
	
	// MARK: - Override Methods
	
    public override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
		self.setup()
		
		self.setupLanguageFlagImageViews()
		
    }

    public override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
	
	
	// MARK: - Public Methods
	
	public func present(playSubsets wrappers: [PlaySubsetWrapper]) {

		self.wrappers = wrappers
		
		UIStackViewHelper.clearAllItems(from: self.playSubsetsStackView)
		
		// Go through each item
		for psw in wrappers {
			
			// Create PlaySubsetListItemView
			let item: PlaySubsetListItemView = self.createPlaySubsetListItemView(for: psw)
			
			self.playSubsetsStackView.addArrangedSubview(item)
			self.playSubsetsStackView.translatesAutoresizingMaskIntoConstraints = false
			
			self.view.layoutIfNeeded()
			
		}
		
	}

	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
//		self.setupControlManager()
//		self.setupModelManager()
//		self.setupViewManager()

	}
	
	fileprivate func setupLanguageFlagImageViews() {
		
		// flagEnglishImageContainerView
		//UIViewHelper.roundCorners(view: self.flagEnglishImageContainerView, corners: UIRectCorner.allCorners, radius: 5.0)

	}
	
	fileprivate func createPlaySubsetListItemView(for playSubsetWrapper: PlaySubsetWrapper) -> PlaySubsetListItemView {
		
		// Create PlaySubsetListItemView
		let result: 		PlaySubsetListItemView = PlaySubsetListItemView()
		
		// Set playSubsetWrapper
		result.set(playSubset: playSubsetWrapper)
		
		result.delegate 	= self
		
		let v: 				UIView = result as UIView
		
		// Set layout constraints
		v.widthAnchor.constraint(equalToConstant: self.playSubsetsStackView.frame.width).isActive = true
		v.heightAnchor.constraint(greaterThanOrEqualToConstant: 50).isActive = true
		
		return result
		
	}
	
}


// MARK: - Extension ProtocolPlaySubsetListItemViewDelegate

extension LanguagePopoverViewViewController: ProtocolPlaySubsetListItemViewDelegate {
	
	// MARK: - Public Methods
	
	public func playSubsetListItemView(tapped sender: PlaySubsetListItemView) {
		
		guard (sender.playSubsetWrapper != nil) else { return }
		
		// Get PlaySubsetWrapper
		let psw: PlaySubsetWrapper? = sender.playSubsetWrapper
		
		guard (psw != nil) else { return }
		
		// Notify the delegate
		self.delegate!.languagePopoverViewViewController(sender: self, languageSelected: psw!.id)
		
	}
	
}
