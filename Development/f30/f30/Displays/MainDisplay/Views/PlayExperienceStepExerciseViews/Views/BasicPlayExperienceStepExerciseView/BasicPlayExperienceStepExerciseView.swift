//
//  BasicPlayExperienceStepExerciseView.swift
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

/// A view class for a BasicPlayExperienceStepExerciseView
public class BasicPlayExperienceStepExerciseView: UIView, ProtocolBasicPlayExperienceStepExerciseView {
	
	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:					BasicPlayExperienceStepExerciseViewControlManager?

	
	// MARK: - Public Stored Properties
	
	@IBOutlet weak var contentView:					UIView!
	@IBOutlet weak var layoutView: 					UIView!
	@IBOutlet weak var textLabel: 					UILabel!
	@IBOutlet weak var contentImagesStackView: 		UIStackView!
	
	
	// MARK: - Public Computed Properties
	
	fileprivate weak var _delegate:					ProtocolPlayExperienceStepExerciseViewDelegate?
	
	public var delegate: ProtocolPlayExperienceStepExerciseViewDelegate? {
		get {
			return _delegate
		}
		set(value) {
			_delegate = value
		}
	}
	
	public var playExperienceStepExerciseWrapper:	PlayExperienceStepExerciseWrapper? {
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
		self.controlManager 			= BasicPlayExperienceStepExerciseViewControlManager()
		
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
		let viewAccessStrategy: BasicPlayExperienceStepExerciseViewViewAccessStrategy = BasicPlayExperienceStepExerciseViewViewAccessStrategy()
		
		viewAccessStrategy.setup(playExperienceStepExerciseView: self,
								 textLabel: self.textLabel)

		// Setup the view manager
		self.controlManager!.viewManager = BasicPlayExperienceStepExerciseViewViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setupContentView() {
		
		// Load xib
		Bundle.main.loadNibNamed("BasicPlayExperienceStepExerciseView", owner: self, options: nil)
		
		addSubview(contentView)
		
		self.layoutIfNeeded()
		
		// Position the contentView to fill the view
		contentView.frame				= self.bounds
		contentView.autoresizingMask	= [.flexibleHeight, .flexibleWidth]
	}
	
	fileprivate func setupView() {
	
	}

	fileprivate func checkPlayExperienceStepExerciseCompleted() {
		
	}
	
	
	// MARK: - textLabel TapGestureRecognizer Methods
	
	@IBAction func textLabelTapped(_ sender: Any) {
		
	}
	
	
	@IBAction func jjjjkjk(_ sender: Any) {

	}
	
	
	@IBAction func kjkjkjkj(_ sender: Any) {

	}
	
}

// MARK: - Extension ProtocolBasicPlayExperienceStepExerciseViewControlManagerDelegate

extension BasicPlayExperienceStepExerciseView: ProtocolBasicPlayExperienceStepExerciseViewControlManagerDelegate {

	// MARK: - Public Methods
	
	public func basicPlayExperienceStepExerciseViewControlManager(createImg1For wrapper: Img1Wrapper) -> ProtocolImg1 {
		
		var result: ProtocolImg1? = nil
		
		// Create PlayExperienceStepExerciseContentImageView
		result = PlayViewFactory.createImg1(wrapper: wrapper, delegate: self)
		
		return result!
		
	}
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseViewControlManagerDelegate

extension BasicPlayExperienceStepExerciseView: ProtocolPlayExperienceStepExerciseViewControlManagerDelegate {
	
	// MARK: - Public Methods
	
}

// MARK: - Extension ProtocolPlayExperienceStepExerciseView

extension BasicPlayExperienceStepExerciseView: ProtocolPlayExperienceStepExerciseView {

	// MARK: - Public Methods
	
	public func set(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper) {
	
		self.controlManager!.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepExerciseWrapper: playExperienceStepExerciseWrapper)

		self.controlManager!.display()

	}
	
	public func reset() {
		
		// TODO:
		
	}
	
}

// MARK: - Extension ProtocolImg1Delegate

extension BasicPlayExperienceStepExerciseView: ProtocolImg1Delegate {
	
	// MARK: - Public Methods
	
	public func img1(tapped wrapper: Img1Wrapper, sender: ProtocolImg1) {

	}
	
}
