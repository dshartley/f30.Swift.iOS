//
//  MC1.swift
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

/// A view class for a MC1
public class MC1: UIView, ProtocolMC1 {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:					MC1ControlManager?
	
	
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
	
	public func present(img1 view: ProtocolImg1) {
		
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
		self.controlManager 			= MC1ControlManager()
		
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
		let viewAccessStrategy: MC1ViewAccessStrategy = MC1ViewAccessStrategy()
		
		viewAccessStrategy.setup(playExperienceStepExerciseView: self,
								 textLabel: self.textLabel)

		// Setup the view manager
		self.controlManager!.viewManager = MC1ViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("MC1", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
	
	}
	
	fileprivate func doUnselectOtherImg1s(img1: ProtocolImg1) {
		
		// Get key
		let key: String = img1.wrapper!.key
		
		// Go through each item
		for item in self.contentImagesStackView.subviews {
			
			if let v = item as? Img1 {
				
				if (v.wrapper!.key != key) { v.set(isSelected: false) }
				
			}
			
		}
		
	}
	
}

// MARK: - Extension ProtocolMC1ControlManagerDelegate

extension MC1: ProtocolMC1ControlManagerDelegate {

	// MARK: - Public Methods
	
	public func mc1ControlManager(createImg1For wrapper: Img1Wrapper) -> ProtocolImg1 {
		
		var result: ProtocolImg1? = nil
		
		// Create Img1
		result = PlayViewFactory.createImg1(wrapper: wrapper, delegate: self)
		
		return result!
		
	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseViewControlManagerDelegate

extension MC1: ProtocolPlayExperienceStepExerciseViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseView

extension MC1: ProtocolPlayExperienceStepExerciseView {

	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper) {
	
		self.controlManager!.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepExerciseWrapper: playExperienceStepExerciseWrapper)

		self.controlManager!.display()

	}
	
	public func reset() {
		
		// TODO:
	
		// Go through each item
		for item in self.contentImagesStackView.subviews {
			
			if let v = item as? Img1 {
			
				v.set(isSelected: false)
				
			}
			
		}
		
		
	}
	
}

// MARK: - Extension ProtocolImg1Delegate

extension MC1: ProtocolImg1Delegate {
	
	// MARK: - Public Methods
	
	public func img1(tapped wrapper: Img1Wrapper, sender: ProtocolImg1) {

		// Unselect other img1s
		self.doUnselectOtherImg1s(img1: sender)
		
		let isCorrectYN: 				Bool = (wrapper.value == "1")
		
		self.properties.isCorrectYN 	= isCorrectYN
		
		// Set isCompleteYN
		self.controlManager!.playExperienceStepExerciseWrapper!.isCompleteYN = isCorrectYN
		
		// Get canCheckYN
		let canCheckYN: 				Bool = self.controlManager!.getCanCheckYN()
		
		// Notify the delegate
		self.delegate!.playExperienceStepExerciseView(canCheck: self.playExperienceStepExerciseWrapper!, sender: self, canCheckYN: canCheckYN)

	}
	
}
