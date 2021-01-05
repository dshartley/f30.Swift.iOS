//
//  P1SubItem.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFView
import f30Model
import f30View
import f30Controller

/// A view class for a P1SubItem
public class P1SubItem: UIView, ProtocolP1SubItem {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:				P1SubItemControlManager?

	
	// MARK: - Public Stored Properties
	
	public weak var delegate:					ProtocolP1SubItemDelegate?
	public fileprivate(set) var isSelected:		Bool = false
	
	@IBOutlet weak var contentView:				UIView!
	@IBOutlet weak var contentImageView: 		UIImageView!
	@IBOutlet weak var selectedView: 			UIView!
	
	@IBOutlet weak var textLabel: UILabel!
	
	
	// MARK: - Public Computed Properties

	public var wrapper: P1SubItemWrapper? {
		get {
			
			return self.controlManager?.wrapper
			
		}
	}
	
	public var givenAnswer: String? {
		get {
			
			return self.controlManager?.givenAnswer
			
		}
		set {
			
			self.controlManager!.givenAnswer = newValue
			
		}
	}
	
	
	// MARK: - Initializers
	
	override init(frame: CGRect) {
		super.init(frame: frame)
		
		self.setupContentView()
		
		self.setup()
		self.setupView()
		
	}
	
	required public init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
		
		self.setupContentView()
		
		self.setup()
		self.setupView()
		
	}
	
	
	// MARK: - Override Methods

	
	// MARK: - Public Methods
	
	public func viewDidAppear() {
		
	}
	
	public func set(wrapper: P1SubItemWrapper) {
		
		self.controlManager!.set(wrapper: wrapper)
		
		self.controlManager!.display()
		
	}
	
	public func set(isSelected: Bool) {
		
		self.isSelected = isSelected
		
		self.doDisplayIsSelected()
		
	}
	
	
	// MARK: - Public Methods; ProtocolP1SubItem
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= P1SubItemControlManager()
		
		self.controlManager!.delegate 	= self
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		//ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: P1SubItemViewAccessStrategy = P1SubItemViewAccessStrategy()
		
		viewAccessStrategy.setup(contentImageView: self.contentImageView)
		
		// Setup the view manager
		self.controlManager!.viewManager = P1SubItemViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("P1SubItem", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {

		self.doDisplayIsSelected()
		
	}
	
	fileprivate func toggleIsSelected() {
		
		self.isSelected = !self.isSelected
	
		self.doDisplayIsSelected()
		
	}
	
	fileprivate func doDisplayIsSelected() {
	
		self.selectedView.alpha = (self.isSelected) ? 100 : 0
		
	}
	
	
	// MARK: - contentView Methods TapGestureRecognizer Methods
	
	@IBAction func contentViewTapped(_ sender: Any) {
		
		self.toggleIsSelected()
		
		// Notify the delegate
		self.delegate?.p1SubItem(tapped: self.controlManager!.wrapper!, sender: self)

	}
	
}

// MARK: - Extension ProtocolP1SubItemControlManagerDelegate

extension P1SubItem: ProtocolP1SubItemControlManagerDelegate {
	
	// MARK: - Public Methods
	
}



