//
//  MP1.swift
//  f30
//
//  Created by David on 15/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import SFCore
import SFView
import SFSerialization
import f30Model
import f30View
import f30Controller

/// A view class for a MP1
public class MP1: UIView, ProtocolMP1 {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:					MP1ControlManager?
	
	
	// MARK: - Public Stored Properties
	
	@IBOutlet weak var contentView:					UIView!
	@IBOutlet weak var layoutView: 					UIView!
	@IBOutlet weak var textLabel: 					UILabel!
	@IBOutlet weak var contentImagesStackView: 		UIStackView!
	
	
	// MARK: - Public Computed Properties
	
	fileprivate weak var _delegate:				ProtocolPlayExperienceStepExerciseViewDelegate?
	
	public var delegate: ProtocolPlayExperienceStepExerciseViewDelegate? {
		get {
			return _delegate
		}
		set(value) {
			_delegate = value
		}
	}
	
	public var playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper? {
		get {
			return self.controlManager?.playExperienceStepExerciseWrapper
		}
	}
	
	fileprivate var _properties: 					PlayExperienceStepExerciseViewProperties = PlayExperienceStepExerciseViewProperties()
	
	public var properties: PlayExperienceStepExerciseViewProperties {
		get {
			return _properties
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
	
	public func clearView() {
		

	}
	
	public func present(p1SubItem view: ProtocolP1SubItem) {
		
		DispatchQueue.main.async {
			
			self.contentImagesStackView.addArrangedSubview(view as! UIView)
			
			self.contentImagesStackView.translatesAutoresizingMaskIntoConstraints = false
			self.layoutSubviews()
			
		}
		
	}
	
		
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= MP1ControlManager()
		
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
		let viewAccessStrategy: MP1ViewAccessStrategy = MP1ViewAccessStrategy()
		
		viewAccessStrategy.setup(playExperienceStepExerciseView: self)

		// Setup the view manager
		self.controlManager!.viewManager = MP1ViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("MP1", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
	
	}
	
}

// MARK: - Extension ProtocolMP1ControlManagerDelegate

extension MP1: ProtocolMP1ControlManagerDelegate {

	// MARK: - Public Methods
	
	public func mp1ControlManager(createP1SubItemFor wrapper: P1SubItemWrapper) -> ProtocolP1SubItem {
		
		var result: ProtocolP1SubItem? = nil
		
		// Create P1
		result = PlayViewFactory.createP1SubItem(wrapper: wrapper, delegate: self)
		
		return result!
		
	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseViewControlManagerDelegate

extension MP1: ProtocolPlayExperienceStepExerciseViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseView

extension MP1: ProtocolPlayExperienceStepExerciseView {

	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper) {
	
		self.controlManager!.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepExerciseWrapper: playExperienceStepExerciseWrapper)

		self.controlManager!.display()

	}
	
	public func reset() {
		
		// TODO:
	
//		// Go through each item
//		for item in self.contentImagesStackView.subviews {
//
//			if let v = item as? Img1 {
//
//				v.set(isSelected: false)
//
//			}
//
//		}
		
	}
	
}

// MARK: - Extension ProtocolP1Delegate

extension MP1: ProtocolP1SubItemDelegate {
	
	// MARK: - Public Methods
	
	public func p1SubItem(tapped wrapper: P1SubItemWrapper, sender: ProtocolP1SubItem) {

		// TODO:
		
	}
	
}
