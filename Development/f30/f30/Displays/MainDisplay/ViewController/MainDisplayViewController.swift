//
//  MainDisplayViewController.swift
//  f30
//
//  Created by David on 04/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import SFSecurity
import SFView
import SFCore
import SFSocial
import SFGridScape
import f30Core
import f30Model
import f30View
import f30Controller

/// Specifies views
enum DashboardBarTabViews : Int {
	case playArea = 1
	case playGames = 2
}

/// A ViewController for the MainDisplay
public class MainDisplayViewController: UIViewController {

	// MARK: - Private Stored Properties
	
	fileprivate var controlManager:											MainDisplayControlManager?
	fileprivate var isNotConnectedAlertIsShownYN:       					Bool = false
	fileprivate var hasViewAppearedYN:										Bool = false
	fileprivate var applicationMenuViewIsShownYN:							Bool = false
	fileprivate var playDeckViewIsShownYN:									Bool = false
	fileprivate var playActiveChallengeViewIsShownYN:						Bool = false
	fileprivate var playResultsViewIsShownYN:								Bool = false
	fileprivate var playAreaGridTileMenuViewIsShownYN:						Bool = false
	fileprivate var playAreaGridTokenMenuViewIsShownYN:						Bool = false
	fileprivate var playAreaPathMenuViewIsShownYN:							Bool = false
	fileprivate var playAreaPathIsShownYN:									Bool = false
	fileprivate var currentView: 											DashboardBarTabViews = .playArea
	fileprivate var playExperienceStepCompleteViews: 						[String:PlayExperienceStepCompleteView] = [String:PlayExperienceStepCompleteView]()
	fileprivate var playExperienceCompleteViews: 							[String:PlayExperienceCompleteView] = [String:PlayExperienceCompleteView]()
	fileprivate var playChallengeObjectiveCompleteViews: 					[String:PlayChallengeObjectiveCompleteView] = [String:PlayChallengeObjectiveCompleteView]()
	fileprivate var playChallengeCompleteViews: 							[String:PlayChallengeCompleteView] = [String:PlayChallengeCompleteView]()
	
	
	// MARK: - Public Stored Properties
	
	@IBOutlet weak var dashboardBarView:									DashboardBarView!
	@IBOutlet weak var dashboardBarPlaceholderView:							UIView!
	@IBOutlet weak var dashboardBarViewHeightLayoutConstraint:				NSLayoutConstraint!
	@IBOutlet weak var applicationMenuView: 								ApplicationMenuView!
	@IBOutlet weak var applicationMenuPlaceholderView: 						UIView!
	@IBOutlet weak var applicationMenuViewTopLayoutConstraint: 				NSLayoutConstraint!
	@IBOutlet weak var applicationMenuViewBottomLayoutConstraint: 			NSLayoutConstraint!
	@IBOutlet weak var activityIndicatorView: 								UIView!
	@IBOutlet weak var avatarImageView: 									UIImageView!
	@IBOutlet weak var userInfoLabel: 										UILabel!
	@IBOutlet weak var playGamesView: 										PlayGamesView!
	@IBOutlet weak var playGamesPlaceholderView: 							UIView!
	@IBOutlet weak var playGameEditView: 									PlayGameEditView!
	@IBOutlet weak var playGameEditPlaceholderView: 						UIView!
	@IBOutlet weak var playGameEditViewTopLayoutConstraint: 				NSLayoutConstraint!
	@IBOutlet weak var playAreaView: 										PlayAreaView!
	@IBOutlet weak var playAreaPlaceholderView: 							UIView!
	@IBOutlet weak var playControlBarView:									PlayControlBarView!
	@IBOutlet weak var playControlBarPlaceholderView:						UIView!
	@IBOutlet weak var playExperienceView: 									UIView!
	@IBOutlet weak var playExperienceStepView: 								UIView!
	@IBOutlet weak var playResultsView: 									PlayResultsView!
	@IBOutlet weak var playResultsPlaceholderView: 							UIView!
	@IBOutlet weak var playResultsViewTopLayoutConstraint: 					NSLayoutConstraint!
	@IBOutlet weak var playResultsViewBottomLayoutConstraint: 				NSLayoutConstraint!
	@IBOutlet weak var playDeckButtonView: 									UIView!
	@IBOutlet weak var playDeckView:										PlayDeckView!
	@IBOutlet weak var playDeckPlaceholderView:								UIView!
	@IBOutlet weak var playDeckViewLeadingLayoutConstraint: 				NSLayoutConstraint!
	@IBOutlet weak var playActiveChallengeButtonView: 						UIView!
	@IBOutlet weak var playActiveChallengeView: 							PlayActiveChallengeView!
	@IBOutlet weak var playActiveChallengePlaceholderView: 					UIView!
	@IBOutlet weak var playAreaGridTileMenuView: 							PlayAreaGridTileMenuView!
	@IBOutlet weak var playAreaGridTileMenuPlaceholderView: 				UIView!
	@IBOutlet weak var playAreaGridTileMenuViewBottomLayoutConstraint: 		NSLayoutConstraint!
	@IBOutlet weak var playAreaGridTileMenuViewLeadingLayoutConstraint: 	NSLayoutConstraint!
	@IBOutlet weak var playAreaGridTokenMenuView: 							PlayAreaGridTokenMenuView!
	@IBOutlet weak var playAreaGridTokenMenuPlaceholderView: 				UIView!
	@IBOutlet weak var playAreaGridTokenMenuViewBottomLayoutConstraint: 	NSLayoutConstraint!
	@IBOutlet weak var playAreaGridTokenMenuViewLeadingLayoutConstraint: 	NSLayoutConstraint!
	@IBOutlet weak var playAreaPathMenuView: 								PlayAreaPathMenuView!
	@IBOutlet weak var playAreaPathMenuPlaceholderView: 					UIView!
	@IBOutlet weak var playAreaPathMenuViewBottomLayoutConstraint: 			NSLayoutConstraint!
	@IBOutlet weak var playAreaPathMenuViewLeadingLayoutConstraint: 		NSLayoutConstraint!
	@IBOutlet weak var sequencedViewsContainerView: 						UIView!
	
	
	// MARK: - Override Methods
	
	public override func viewDidLoad() {
		super.viewDidLoad()
		
		// Do any additional setup after loading the view.
		self.setup()

		self.setupApplicationMenuView()
		self.setupPlayGamesView()
		self.setupPlayGameEditView()
		self.setupPlayResultsView()
		self.setupDashboardBarView()
		self.setupPlayAreaView()
		self.setupPlayControlBarView()
		self.setupPlayDeckButtonView()
		self.setupPlayDeckView()
		self.setupPlayActiveChallengeButtonView()
		self.setupPlayActiveChallengeView()
		self.setupPlayAreaGridTileMenuView()
		self.setupPlayAreaGridTokenMenuView()
		self.setupPlayAreaPathMenuView()
		self.setupPlayExperienceView()
		self.setupPlayExperienceStepView()

	}
	
	public override func viewWillTransition(to size: CGSize, with coordinator: UIViewControllerTransitionCoordinator) {
		super.viewWillTransition(to: size, with: coordinator)
		
		// When transition complete
		coordinator.animate(alongsideTransition: nil) { _ in
			
			self.view.layoutIfNeeded()
			
		}
		
	}
	
	public override func viewDidAppear(_ animated: Bool) {
		
		// Check hasViewAppearedYN
		if (self.hasViewAppearedYN) {
			
			if (self.currentView == .playArea) {
				
				self.playAreaView.viewDidAppear()
				
			}
			
			return
			
		}
		
		self.clearViews()
		
		self.hasViewAppearedYN 			= true
		
		// Setup authentication
		self.controlManager!.setupAuthentication()
		
		// Setup UserProfileWrapper
		UserProfileWrapper.delegate 	= self.controlManager

		self.controlManager!.checkIsSignedIn()
		
		self.controlManager!.setButtons()
		self.controlManager!.displayUserInfo()
		self.controlManager!.displayAvatar()
		

		// Setup views
		
		// Setup playAreaView
		self.playAreaView.viewDidAppear()
		
		// Setup playGamesView
		self.playGamesView.viewDidAppear()

		self.doSetPlayGameEditView(isPresentedYN: false)
		
		// Setup playDeckView
		self.playDeckView.viewDidAppear()

		// Setup playActiveChallengeView
		self.playActiveChallengeView.viewDidAppear()
		
		// Setup playAreaGridTileMenuView
		self.playAreaGridTileMenuView.viewDidAppear()

		// Setup playAreaGridTokenMenuView
		self.playAreaGridTokenMenuView.viewDidAppear()

		// Setup playAreaPathMenuView
		self.playAreaPathMenuView.viewDidAppear()
		
		// Load data
		self.initialLoad()
		
	}
	
	public override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
		
		if segue.identifier == "showSettingsDisplay" {
			
			if let viewController = segue.destination as? SettingsDisplayViewController {
				
				// Set delegate
				viewController.delegate = self
				
			}
		}
	}
	
	public override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
		
		
	}
	
	
	// MARK: - Public Methods
	
	public func connectWebSockets() {

		// TODO:
		
	}
	
	public func disconnectWebSockets() {

		// TODO:
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setupControlManager()
		self.setupModelManager()
		self.setupViewManager()

		// Setup social
		self.controlManager!.setupSocial()
		
		self.setDebugFlags()
		
	}

	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 			= MainDisplayControlManager()

		self.controlManager!.delegate 	= self

		self.controlManager!.setUrls(imagesUrlRoot: UrlsHelper.imagesUrlRoot)
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelFactory.modelManager)
		
		// Setup the model administrators
		ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayResultModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlaySubsetModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayGameModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayGameDataModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayAreaTokenModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayAreaCellTypeModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayAreaTileTypeModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayAreaTileDataModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayAreaPathModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayAreaPathPointModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayMoveModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayExperienceModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayExperienceStepModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayExperiencePlayExperienceStepLinkModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayExperienceStepExerciseModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayExperienceStepPlayExperienceStepExerciseLinkModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayChallengeModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayChallengeTypeModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayChallengeObjectiveModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		ModelFactory.setupPlayChallengeObjectiveTypeModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)

	}
	
	fileprivate func setupViewManager() {
		
		// Create view strategy
		let viewAccessStrategy: MainDisplayViewAccessStrategy = MainDisplayViewAccessStrategy()
		
		viewAccessStrategy.setup(mainDisplayView:			self,
								 avatarImageView: 			self.avatarImageView,
		                         userInfoLabel: 			self.userInfoLabel,
								 playActiveChallengeView: 	self.playActiveChallengeView,
								 playControlBarView: 		self.playControlBarView)
		
		// Setup the view manager
		self.controlManager!.viewManager = MainDisplayViewManager(viewAccessStrategy: viewAccessStrategy)
	}
	
	fileprivate func setDebugFlags() {
		
		#if DEBUG
			
			///// RUN FROM CACHE: SET THESE FLAGS TO TRUE //////
			
			ApplicationFlags.flag(key: "SkipCheckIsConnectedYN", value: false)
			
			ApplicationFlags.flag(key: "SavePlayResultDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "SaveDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadDataFromCacheYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "SaveDataToCacheYN", value: false) // false = MIGRATING!!
			
			ApplicationFlags.flag(key: "LoadPlaySubsetsDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayAreaCellTypesDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayAreaTileTypesDummyDataYN", value: false)  // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayAreaCellsDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayChallengesDummyDataYN", value: false) // false = MIGRATING!!
			
			ApplicationFlags.flag(key: "LoadPlayAreaPathsDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayMovesDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayExperiencesDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayExperienceStepsDummyDataYN", value: false) // false = MIGRATING!!
			
			
			///// RUN FROM CACHE: SET THESE FLAGS TO FALSE //////
			
			ApplicationFlags.flag(key: "LoadPlayGamesDummyDataYN", value: false) // false = MIGRATING!!
			ApplicationFlags.flag(key: "LoadPlayGameDataDummyDataYN", value: false) // false = MIGRATING!!
			
			ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN", value: false)
			ApplicationFlags.flag(key: "LoadRelativeConnectionsDummyDataYN", value: false)
			ApplicationFlags.flag(key: "LoadRelativeConnectionRequestsDummyDataYN", value: false)
			ApplicationFlags.flag(key: "LoadRelativeInteractionsDummyDataYN", value: false)
			ApplicationFlags.flag(key: "LoadRelativeTimelineEventsDummyDataYN", value: false)
			
		#endif
		
	}
	
	fileprivate func presentSignInView() {

		let signInDisplayViewController = storyboard?.instantiateViewController(withIdentifier: "SignInDisplay") as? SignInDisplayViewController

		// Set delegate
		signInDisplayViewController!.delegate = self

		// Present the view
		present(signInDisplayViewController!, animated: true, completion: nil)
		
	}
	
	fileprivate func onSignOutSuccessful() {

		self.controlManager!.clear()
		
		self.playAreaView.clearView()
		
		self.presentSignInView()
	}

	fileprivate func onSignOutFailed() {
		
		self.controlManager!.clear()
		
		self.presentSignInView()
	}
	
	fileprivate func presentAlert(alertTitle: String, alertMessage: String) {
		
		// Create alertController
		let alertController: 	UIAlertController = UIAlertController(title: alertTitle, message: alertMessage, preferredStyle: UIAlertControllerStyle.alert)
		
		// Create 'OK' action
		let okAlertActionTitle: String = NSLocalizedString("AlertActionTitleOk", comment: "")
		let alertAction:		UIAlertAction = UIAlertAction(title: okAlertActionTitle, style: .default, handler: nil)
		alertController.addAction(alertAction)
		
		// Present alertController
		UIViewControllerHelper.getPresentedViewController().present(alertController, animated: true, completion: nil)
		
	}
	
	fileprivate func presentIsNotConnectedAlert() {
		
		guard (!self.isNotConnectedAlertIsShownYN) else { return }
		
		self.isNotConnectedAlertIsShownYN = true
		
		// Create completion handler
		let completionHandler: ((UIAlertAction?) -> Void) =
		{
			[unowned self] (action) -> Void in
			
			self.isNotConnectedAlertIsShownYN = false
			
		}
		
		let alertTitle:     String = NSLocalizedString("AlertTitleNotConnected", comment: "")
		let alertMessage:   String = NSLocalizedString("AlertMessageNotConnected", comment: "")
		
		DispatchQueue.main.async {
			
			UIAlertControllerHelper.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: completionHandler)
		
		}
	}
	
	fileprivate func presentOperationFailedAlert() {
		
		let alertTitle:     String = NSLocalizedString("AlertTitleOperationFailed", comment: "")
		let alertMessage:   String = NSLocalizedString("AlertMessageOperationFailed", comment: "")
		
		UIAlertControllerHelper.presentAlert(alertTitle: alertTitle, alertMessage: alertMessage, oncomplete: nil)
		
	}
	
	fileprivate func presentActivityIndicatorView(animateYN: Bool) {
		
		if (animateYN) {
			
			// Show view
			UIView.animate(withDuration: 0.3) {
				
				self.activityIndicatorView.alpha 	= 1
			}
			
		} else {
			
			self.activityIndicatorView.alpha 		= 1
		}
		
	}
	
	fileprivate func hideActivityIndicatorView() {
		
		DispatchQueue.main.async {
			
			guard (self.activityIndicatorView.alpha != 0) else { return }
			
			// Hide view
			UIView.animate(withDuration: 0.3) {
				
				self.activityIndicatorView.alpha 	= 0
			}
			
		}
	}

	fileprivate func clearViews() {
	
		self.currentView 						= .playArea
	
		// Set the dashboardBarTabItem
		self.dashboardBarView!.set(dashboardBarTabItem: .playArea, animateYN: false)

		// Clear views
		
		// Clear playAreaView
		self.playAreaView!.clearView()

		// Clear playGamesView
		self.playGamesView!.clearView()
		
	}
	
	fileprivate func initialLoad() {
		
		guard (RelativeMemberWrapper.current != nil) else { return }
		
		var playGameWrappers: [PlayGameWrapper]? = nil
		
		// Create completion handler
		let loadPlayAreaCellTypesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			guard (playGameWrappers != nil && playGameWrappers!.count > 0) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Setup PlayGame
			self.setupPlayGame(playGameWrapper: playGameWrappers!.first!)
			
		}
		
		// Create completion handler
		let loadPlayGameCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Get playGameWrappers
			playGameWrappers = wrappers!["PlayGames"] as? [PlayGameWrapper]
			
			guard (playGameWrappers != nil && playGameWrappers!.count > 0) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Get playAreaCellTypeWrappers
			let playAreaCellTypeWrappers: 	[PlayAreaCellTypeWrapper]? = wrappers!["PlayAreaCellTypes"] as? [PlayAreaCellTypeWrapper]
			
			// Check playAreaCellTypeWrappers
			if (playAreaCellTypeWrappers == nil || playAreaCellTypeWrappers!.count == 0) {
				
				// Load PlayAreaCellTypes
				self.controlManager!.loadPlayAreaCellTypes(for: playGameWrappers!.first!.playSubsetID, relativeMemberWrapper: RelativeMemberWrapper.current!, playGameID: playGameWrappers!.first!.id, oncomplete: loadPlayAreaCellTypesCompletionHandler)
				
			} else {
				
				// Setup PlayGame
				self.setupPlayGame(playGameWrapper: playGameWrappers!.first!)
				
			}
			
		}
		
		// Create completion handler
		let loadPlaySubsetsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Load PlayGame
			self.initialLoadPlayGame(oncomplete: loadPlayGameCompletionHandler)
			
		}
		
		// Load PlaySubsets
		self.loadPlaySubsets(oncomplete: loadPlaySubsetsCompletionHandler)
		
	}

	fileprivate func cancelTransientViews() {
		
		self.cancelTransientViews(playAreaGridTileMenuViewYN: true, playAreaGridTokenMenuViewYN: true, playAreaPathMenuViewYN: true, playAreaViewYN: true, playControlBarViewYN: true)
		
	}
	
	fileprivate func cancelTransientViews(playAreaGridTileMenuViewYN: Bool, playAreaGridTokenMenuViewYN: Bool, playAreaPathMenuViewYN: Bool, playAreaViewYN: Bool, playControlBarViewYN: Bool) {
		
		// playAreaGridTileMenuView
		if (playAreaGridTileMenuViewYN && self.playAreaGridTileMenuViewIsShownYN) {
			
			self.hidePlayAreaGridTileMenuView()
			
		}
		
		// playAreaGridTokenMenuView
		if (playAreaGridTokenMenuViewYN && self.playAreaGridTokenMenuViewIsShownYN) {
			
			self.hidePlayAreaGridTokenMenuView()
			
		}

		// playAreaPathMenuView
		if (playAreaPathMenuViewYN && self.playAreaPathMenuViewIsShownYN) {
			
			self.hidePlayAreaPathMenuView()
			
		}
		
		// playAreaView
		if (playAreaViewYN) {
			
			self.playAreaView.cancelTransientViews()
			
		}
		
		// playControlBarView
		if (playControlBarViewYN) {
			
			self.playControlBarView.cancelTransientViews()
			
		}
		
	}

	
	// MARK: - Private Methods; LanguagePopoverView
	
	fileprivate func setupLanguagePopoverView() {
		
		// TODO:
		
	}
	
	fileprivate func displayLanguagePopover(sender: UIView) {
		
		let vc =  self.storyboard?.instantiateViewController(withIdentifier: "LanguagePopoverViewController")
		
		guard (vc != nil) else { return }
		
		(vc as! LanguagePopoverViewViewController).delegate = self
		
		let lpv: LanguagePopoverViewViewController = (vc as! LanguagePopoverViewViewController)
		let w: [PlaySubsetWrapper] = Array(PlayWrapper.current!.playSubsets!.values)
		
		vc!.modalPresentationStyle = UIModalPresentationStyle.popover
		vc!.preferredContentSize = CGSize(width: 300, height: 200)
		let presentationController = vc!.presentationController as! UIPopoverPresentationController
		presentationController.delegate = self
		presentationController.sourceView = sender
		presentationController.sourceRect = sender.bounds
		presentationController.permittedArrowDirections = [.down, .up]
		self.present(vc!, animated: true)
		
		lpv.present(playSubsets: w)
		
	}
	
	
	// MARK: - Private Methods; DashboardBarView
	
	fileprivate func setupDashboardBarView() {
		
		self.dashboardBarView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.dashboardBarPlaceholderView.isHidden	= true
		
		self.dashboardBarView!.set(dashboardBarTabItem: .playArea, animateYN: false)
		
	}

	
	// MARK: - Private Methods; ApplicationMenuView

	fileprivate func setupApplicationMenuView() {
		
		self.applicationMenuView.delegate								= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.applicationMenuPlaceholderView.isHidden					= true
		
		// Hide applicationMenuView
		self.applicationMenuView.isHidden								= true
		
		// Set offset to fit under dashboardBoardBarView
		self.applicationMenuView.menuViewTopLayoutConstraintOffset		= self.dashboardBarViewHeightLayoutConstraint.constant
		
		// Layout applicationMenuView to fill superview
		self.applicationMenuViewTopLayoutConstraint.constant			= 0
		self.applicationMenuViewBottomLayoutConstraint.constant			= 0
		
	}
	
	fileprivate func switchApplicationMenuView() {
		
		// If applicationMenuView is not shown then show, otherwise hide
		if (!self.applicationMenuViewIsShownYN) {
			
			self.applicationMenuViewIsShownYN = true
			self.applicationMenuView.presentMenu()
		}
		else {
			self.applicationMenuViewIsShownYN = false
			self.applicationMenuView.dismissMenu()
		}
		
	}

	
	// MARK: - Private Methods; PlayGamesView
	
	fileprivate func setupPlayGamesView() {
		
		self.playGamesView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playGamesPlaceholderView.isHidden	= true
		
		self.playGamesView.alpha				= 0
		
	}
	
	fileprivate func presentPlayGamesView() {
		
		self.currentView = .playGames
		
		self.playGamesView.clearView()
		self.playGamesView.set(activePlayGameID: self.controlManager!.playGameWrapper?.id)
		
		// Load items
		self.playGamesView.loadItems()
		
		// Show view
		UIView.animate(withDuration: 0.1) {
			
			self.playAreaView.alpha		= 0
			self.playGamesView.alpha 	= 1
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayAreaView

	fileprivate func setupPlayAreaView() {
		
		self.playAreaView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playAreaPlaceholderView.isHidden	= true
		
		self.playAreaView.alpha					= 1
		
	}
	
	fileprivate func presentPlayAreaView() {
		
		self.currentView = .playArea
		
		// Show view
		UIView.animate(withDuration: 0.1) {
			
			self.playAreaView.alpha 	= 1
			self.playGamesView.alpha	= 0
			
		}
		
	}

	
	// MARK: - Private Methods; PlayResultsView

	fileprivate func setupPlayResultsView() {
		
		self.playResultsView.delegate								= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playResultsPlaceholderView.isHidden					= true
		
		// Hide playResultsView
		self.playResultsView.isHidden								= true
		
		// Set offset to fit under dashboardBoardBarView
		self.playResultsView.menuViewTopLayoutConstraintOffset		= self.dashboardBarViewHeightLayoutConstraint.constant
		
		// Layout playResultsView to fill superview
		self.playResultsViewTopLayoutConstraint.constant			= 0
		self.playResultsViewBottomLayoutConstraint.constant			= 0
		
	}
	
	fileprivate func switchPlayResultsView() {
		
		// If playResultsView is not shown then show, otherwise hide
		if (!self.playResultsViewIsShownYN) {
			
			self.playResultsViewIsShownYN = true
			self.playResultsView.presentMenu()
		}
		else {
			self.playResultsViewIsShownYN = false
			self.playResultsView.dismissMenu()
		}
		
	}

	
	// MARK: - Private Methods; PlayControlBarView
	
	fileprivate func setupPlayControlBarView() {
		
		self.playControlBarView.delegate			= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playControlBarPlaceholderView.isHidden	= true
		
		self.playControlBarView.alpha				= 1

//		self.playControlBarView.widthAnchor.constraint(equalToConstant: 100).isActive = true
//		self.playControlBarView.heightAnchor.constraint(equalToConstant: 50).isActive = true
	}
	
	
	// MARK: - Private Methods; PlayDeckButtonView
	
	fileprivate func setupPlayDeckButtonView() {
		
		UIViewHelper.makeCircle(view: self.playDeckButtonView)
		
		UIViewHelper.setShadow(view: self.playDeckButtonView)
		
	}
	
	fileprivate func doPlayDeckButtonViewGrowAnimation() {
		
		UIView.animate(withDuration: 0.2, animations: {
			
			self.playDeckButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			
			self.view.layoutIfNeeded()
			
		})
		
	}
	
	fileprivate func doPlayDeckButtonViewShrinkAnimation() {
		
		UIView.animate(withDuration: 0.2, animations: {
			
			self.playDeckButtonView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			
			self.view.layoutIfNeeded()
			
		})
		
	}
	
	
	// MARK: - Private Methods; PlayDeckView
	
	fileprivate func setupPlayDeckView() {
		
		self.playDeckView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playDeckPlaceholderView.isHidden	= true
		
		self.playDeckViewIsShownYN 				= false
		self.doSetPlayDeckView(isPresentedYN: false)
		
	}

	fileprivate func presentPlayDeckView() {
		
		self.hidePlayActiveChallengeView()

		self.playDeckViewIsShownYN 						= true
		self.playDeckView.isUserInteractionEnabled		= true
		
		self.doPlayDeckButtonViewShrinkAnimation()
		
		self.doSetPlayDeckViewAnimation()
		
	}
	
	fileprivate func hidePlayDeckView() {

		guard (self.playDeckViewIsShownYN) else { return }
		
		self.playDeckViewIsShownYN 						= false
		self.playDeckView.isUserInteractionEnabled		= false
		
		self.doPlayDeckButtonViewGrowAnimation()
		
		self.doSetPlayDeckViewAnimation()
		
	}
	
	fileprivate func doSetPlayDeckViewAnimation() {
		
		UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {

			self.doSetPlayDeckView(isPresentedYN: self.playDeckViewIsShownYN)
			
			self.view.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetPlayDeckView(isPresentedYN: Bool) {
		
		if (isPresentedYN) {

			self.playDeckView.alpha = 1
			//self.playDeckViewLeadingLayoutConstraint.constant = -15
			
		} else {

			self.playDeckView.alpha = 0
			//self.playDeckViewLeadingLayoutConstraint.constant = 0 - self.playDeckView.frame.width + 45
			
		}
		
	}
	
	fileprivate func doAddCellToPlayDeckView() {
		
		// Create completion handler
		let createDeckPlayAreaGridCellViewCompletionHandler: ((ProtocolPlayAreaGridCellView?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			guard (item != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			DispatchQueue.main.async {
				
				// Display in deck view
				self.playDeckView.present(playAreaGridCellView: item!)
				
			}
			
		}
		
		// Create playAreaGridCellView
		self.createDeckPlayAreaGridCellView(oncomplete: createDeckPlayAreaGridCellViewCompletionHandler)
		
	}
	
	fileprivate func createDeckPlayAreaGridCellView(oncomplete completionHandler:@escaping (ProtocolPlayAreaGridCellView?, Error?) -> Void) {
		
		// Create completion handler
		let createPlayAreaCellWrapperCompletionHandler: ((PlayAreaCellWrapper?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			guard (wrapper != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Create gridCellProperties
			let gridCellProperties: 	GridCellProperties = GridCellProperties(cellCoord: CellCoord(column: 0, row: 0))

			// Create View
			let playAreaGridCellView: 	ProtocolPlayAreaGridCellView? = PlayViewFactory.createPlayAreaGridCellView(forPlayAreaCell: wrapper!, with: gridCellProperties, delegate: nil)
			
			// Call completion handler
			completionHandler(playAreaGridCellView, error)
			
		}
		
		// Create completion handler
		let getRandomPlayAreaCellTypeWrapperCompletionHandler: ((PlayAreaCellTypeWrapper?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			guard (wrapper != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Create playAreaCellWrapper
			self.controlManager!.createPlayAreaCellWrapper(for: wrapper!, urlRoot: UrlsHelper.imagesUrlRoot, oncomplete: createPlayAreaCellWrapperCompletionHandler)
			
		}
		
		// Get random playAreaCellTypeWrapper
		self.controlManager!.getRandomPlayAreaCellTypeWrapper(oncomplete: getRandomPlayAreaCellTypeWrapperCompletionHandler)
		
	}
	
	fileprivate func doAddTileToPlayDeckView() {
		
		// Create completion handler
		let createDeckPlayAreaGridTileViewCompletionHandler: ((ProtocolPlayAreaGridTileView?, Error?) -> Void) =
		{
			(item, error) -> Void in
			
			guard (item != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			DispatchQueue.main.async {
				
				// Display in deck view
				self.playDeckView.present(playAreaGridTileView: item!)
				
			}
			
		}
		
		// Create playAreaGridTileView
		self.createDeckPlayAreaGridTileView(oncomplete: createDeckPlayAreaGridTileViewCompletionHandler)
		
	}
	
	fileprivate func createDeckPlayAreaGridTileView(oncomplete completionHandler:@escaping (ProtocolPlayAreaGridTileView?, Error?) -> Void) {
		
		// Create completion handler
		let createPlayAreaTileWrapperCompletionHandler: ((PlayAreaTileWrapper?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			guard (wrapper != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}

			// Create View
			let playAreaGridTileView: 	ProtocolPlayAreaGridTileView? = PlayViewFactory.createPlayAreaGridTileView(forPlayAreaTile: wrapper!, delegate: nil)
			
			// Set wrapper position Unspecified
			wrapper!.position 			= .Unspecified
			
			// Set tileView position Center
			(playAreaGridTileView as? PlayAreaGridTileView)?.gridTileProperties!.position = .Center
			
			
			// Call completion handler
			completionHandler(playAreaGridTileView, error)
			
		}
		
		// Create completion handler
		let getRandomPlayAreaTileTypeWrapperCompletionHandler: ((PlayAreaTileTypeWrapper?, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			guard (wrapper != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(nil, error)
				
				return
				
			}
			
			// Create playAreaTileWrapper
			self.controlManager!.createPlayAreaTileWrapper(for: wrapper!, urlRoot: UrlsHelper.imagesUrlRoot, oncomplete: createPlayAreaTileWrapperCompletionHandler)
			
		}
		
		// Get random playAreaTileTypeWrapper
		self.controlManager!.getRandomPlayAreaTileTypeWrapper(oncomplete: getRandomPlayAreaTileTypeWrapperCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods; PlayActiveChallengeButtonView
	
	fileprivate func setupPlayActiveChallengeButtonView() {
		
		self.hidePlayActiveChallengeButtonView()
		
		UIViewHelper.makeCircle(view: self.playActiveChallengeButtonView)
		
		UIViewHelper.setShadow(view: self.playActiveChallengeButtonView)
		
	}
	
	fileprivate func presentPlayActiveChallengeButtonView() {
		
		DispatchQueue.main.async {
		
			self.playActiveChallengeButtonView.alpha 						= 1
			self.playActiveChallengeButtonView.isUserInteractionEnabled 	= true
			
			self.playActiveChallengeView.alpha 								= 1
			
		}
		
	}
	
	fileprivate func hidePlayActiveChallengeButtonView() {
		
		DispatchQueue.main.async {
			
			self.playActiveChallengeButtonView.alpha 						= 0
			self.playActiveChallengeButtonView.isUserInteractionEnabled 	= false
			
			self.playActiveChallengeView.alpha 								= 0
			
		}
		
	}
	
	fileprivate func doPlayActiveChallengeButtonViewGrowAnimation() {
		
		UIView.animate(withDuration: 0.2, animations: {
			
			self.playActiveChallengeButtonView.transform = CGAffineTransform(scaleX: 1.0, y: 1.0)
			
			self.view.layoutIfNeeded()
			
		})
		
	}
	
	fileprivate func doPlayActiveChallengeButtonViewShrinkAnimation() {
		
		UIView.animate(withDuration: 0.2, animations: {
			
			self.playActiveChallengeButtonView.transform = CGAffineTransform(scaleX: 0.8, y: 0.8)
			
			self.view.layoutIfNeeded()
			
		})
		
	}
	
	
	// MARK: - Private Methods; PlayActiveChallengeView
	
	fileprivate func setupPlayActiveChallengeView() {
		
		self.playActiveChallengeView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playActiveChallengePlaceholderView.isHidden	= true
		
		self.playActiveChallengeViewIsShownYN 				= false
	
		self.doSetPlayActiveChallengeView(isPresentedYN: false)
		
	}
	
	fileprivate func presentPlayActiveChallengeView() {
		
		DispatchQueue.main.async {
			
			self.hidePlayDeckView()

			self.playActiveChallengeViewIsShownYN 					= true
			self.playActiveChallengeView.isUserInteractionEnabled	= true
			
			self.doPlayActiveChallengeButtonViewShrinkAnimation()
			
			self.doSetPlayActiveChallengeViewAnimation()
		
		}
	}
	
	fileprivate func hidePlayActiveChallengeView() {
		
		guard (self.playActiveChallengeViewIsShownYN) else { return }
		
		DispatchQueue.main.async {
			
			self.playActiveChallengeViewIsShownYN 					= false
			self.playActiveChallengeView.isUserInteractionEnabled	= false

			self.doPlayActiveChallengeButtonViewGrowAnimation()
			
			self.doSetPlayActiveChallengeViewAnimation()
		
		}
		
	}
	
	fileprivate func doSetPlayActiveChallengeViewAnimation() {
		
		UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
			
			self.doSetPlayActiveChallengeView(isPresentedYN: self.playActiveChallengeViewIsShownYN)
			
			self.view.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetPlayActiveChallengeView(isPresentedYN: Bool) {
		
		if (isPresentedYN) {
			
			self.playActiveChallengeView.alpha = 1
			//self.playActiveChallengeViewLeadingLayoutConstraint.constant = -15
			
		} else {
			
			self.playActiveChallengeView.alpha = 0
			
			//self.playActiveChallengeViewLeadingLayoutConstraint.constant = 0 - self.playActiveChallengeView.frame.width + 45
			
		}
		
	}

	
	// MARK: - Private Methods; PlayAreaGridTileMenuView
	
	fileprivate func setupPlayAreaGridTileMenuView() {
		
		self.playAreaGridTileMenuView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playAreaGridTileMenuPlaceholderView.isHidden	= true
		
		self.playAreaGridTileMenuViewIsShownYN 				= false
		self.doSetPlayAreaGridTileMenuView(isPresentedYN: false)
		
	}

	fileprivate func presentPlayAreaGridTileMenuView(playMoveWrappers: [PlayMoveWrapper], for tileWrapper: PlayAreaTileWrapper, at indicatedPoint: CGPoint, cellCoord: CellCoord) {
		
		DispatchQueue.main.async {
			
			self.hidePlayDeckView()
			self.hidePlayActiveChallengeView()
			
			// Present the menu items
			self.playAreaGridTileMenuView.present(playMoves: playMoveWrappers, for: tileWrapper)
			
			// Use sizeThatFits to determine height
			let s: CGSize = self.playAreaGridTileMenuView.sizeThatFits(self.playAreaGridTileMenuView.frame.size)
			self.playAreaGridTileMenuView.heightAnchor.constraint(equalToConstant: s.height).isActive = true
			
			// Nb: Call viewDidAppear to ensure the view is updated
			self.playAreaGridTileMenuView.viewDidAppear()
			
			// Set menu position
			self.setPlayAreaGridTileMenuViewPosition(at: cellCoord)
			
			self.view.layoutIfNeeded()
			
			// Create completion handler
			let checkShouldMoveToFitCompletionHandler: ((Error?) -> Void) =
			{
				(error) -> Void in
				
				self.playAreaGridTileMenuViewIsShownYN = true
				
				// Set menu position
				self.setPlayAreaGridTileMenuViewPosition(at: cellCoord)
				
				// Animate menu
				self.doSetPlayAreaGridTileMenuViewAnimation()
				
			}
			
			// Check should move grid position
			self.checkShouldMoveGridPositionToFitPlayAreaGridTileMenuView(oncomplete: checkShouldMoveToFitCompletionHandler)
			
		}
		
	}
	
	fileprivate func setPlayAreaGridTileMenuViewPosition(at cellCoord: CellCoord) {
		
		// Get indicatedPoint for cellCoord
		let indicatedPoint: 	CGPoint = self.playAreaView.gridScapeManager!.get(indicatedPoint: cellCoord)
		
		// Used to reposition the view
		let offsetY:			CGFloat = 30
		
		self.playAreaGridTileMenuViewBottomLayoutConstraint.constant 	= (self.playAreaView.frame.size.height - indicatedPoint.y) - offsetY
		self.playAreaGridTileMenuViewLeadingLayoutConstraint.constant 	= indicatedPoint.x
		
		self.view.layoutIfNeeded()
		
	}

	fileprivate func hidePlayAreaGridTileMenuView() {
		
		DispatchQueue.main.async {
			
			self.playAreaGridTileMenuViewIsShownYN = false
			
			self.doSetPlayAreaGridTileMenuViewAnimation()
			
			self.playAreaGridTileMenuView.clearView()
		
		}
		
	}
	
	fileprivate func doSetPlayAreaGridTileMenuViewAnimation() {
		
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
			
			self.doSetPlayAreaGridTileMenuView(isPresentedYN: self.playAreaGridTileMenuViewIsShownYN)
			
			self.view.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetPlayAreaGridTileMenuView(isPresentedYN: Bool) {
		
		if (isPresentedYN) {
			
			self.playAreaGridTileMenuView.alpha = 1
			
		} else {
			
			self.playAreaGridTileMenuView.alpha = 0

		}
		
	}

	fileprivate func checkShouldMoveGridPositionToFitPlayAreaGridTileMenuView(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let setGridPositionCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Call the completion handler
			completionHandler(nil)
			
		}
		
		let leftMargin:				CGFloat = 20
		let rightMargin: 			CGFloat = 20
		let topMargin: 				CGFloat = 20
		
		// Get display size
		let displaySize: 			CGSize = self.playAreaView!.frame.size
		
		// Get maxX, minY
		let maxX: 					CGFloat = self.playAreaGridTileMenuView.frame.maxX
		let minX:					CGFloat = self.playAreaGridTileMenuView.frame.minX
		let minY: 					CGFloat = self.playAreaGridTileMenuView.frame.minY
		
		// Get isOffscreenLeftYN
		let offscreenLeftAmount:	CGFloat = (0 + leftMargin) - minX
		let isOffscreenLeftYN: 		Bool = (offscreenLeftAmount > 0)
		
		// Get isOffscreenRightYN
		let offscreenRightAmount:	CGFloat = maxX - (displaySize.width - rightMargin)
		let isOffscreenRightYN: 	Bool = (offscreenRightAmount > 0)
		
		// Get isOffscreenTopYN
		let offscreenTopAmount:		CGFloat = (0 + self.dashboardBarView.frame.size.height + topMargin) - minY
		let isOffscreenTopYN: 		Bool = (offscreenTopAmount > 0)
		
		// Get gridPosition
		let gridPosition: 			CGPoint = self.playAreaView.gridScapeManager!.gridPosition
		
		// Set toIndicatedOffsetX
		var toIndicatedOffsetX: 	CGFloat = gridPosition.x
		
		if (isOffscreenLeftYN) {			// Offset to right
			
			toIndicatedOffsetX = gridPosition.x + offscreenLeftAmount
			
		} else if (isOffscreenRightYN) {	// Offset to left
			
			toIndicatedOffsetX = gridPosition.x - offscreenRightAmount
			
		}
		
		// Set toIndicatedOffsetY
		let toIndicatedOffsetY:		CGFloat = (isOffscreenTopYN) ? (gridPosition.y + offscreenTopAmount) : gridPosition.y
		
		if (isOffscreenLeftYN || isOffscreenRightYN || isOffscreenTopYN) {
			
			// Set grid position
			self.playAreaView.gridScapeManager!.set(gridPositionAt: toIndicatedOffsetX, indicatedOffsetY: toIndicatedOffsetY, animateYN: true, oncomplete: setGridPositionCompletionHandler)
			
		} else {
			
			// Call the completion handler
			completionHandler(nil)
			
		}
		
	}

	
	// MARK: - Private Methods; PlayAreaGridTokenMenuView

	fileprivate func setupPlayAreaGridTokenMenuView() {
		
		self.playAreaGridTokenMenuView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playAreaGridTokenMenuPlaceholderView.isHidden	= true
		
		self.playAreaGridTokenMenuViewIsShownYN 				= false
		self.doSetPlayAreaGridTokenMenuView(isPresentedYN: false)
		
	}
	
	fileprivate func presentPlayAreaGridTokenMenuView(playMoveWrappers: [PlayMoveWrapper], for tokenWrapper: PlayAreaTokenWrapper, at indicatedPoint: CGPoint, cellCoord: CellCoord) {
		
		DispatchQueue.main.async {
			
			self.hidePlayDeckView()
			self.hidePlayActiveChallengeView()
			
			// Present the menu items
			self.playAreaGridTokenMenuView.present(playMoves: playMoveWrappers, for: tokenWrapper)
			
			// Use sizeThatFits to determine height
			let s: CGSize = self.playAreaGridTokenMenuView.sizeThatFits(self.playAreaGridTokenMenuView.frame.size)
			self.playAreaGridTokenMenuView.heightAnchor.constraint(equalToConstant: s.height).isActive = true
			
			// Nb: Call viewDidAppear to ensure the view is updated
			self.playAreaGridTokenMenuView.viewDidAppear()
			
			// Set menu position
			self.setPlayAreaGridTokenMenuViewPosition(at: cellCoord)
			
			self.view.layoutIfNeeded()
			
			// Create completion handler
			let checkShouldMoveToFitCompletionHandler: ((Error?) -> Void) =
			{
				(error) -> Void in
				
				self.playAreaGridTokenMenuViewIsShownYN = true
				
				// Set menu position
				self.setPlayAreaGridTokenMenuViewPosition(at: cellCoord)
				
				// Animate menu
				self.doSetPlayAreaGridTokenMenuViewAnimation()
				
			}
			
			// Check should move grid position
			self.checkShouldMoveGridPositionToFitPlayAreaGridTokenMenuView(oncomplete: checkShouldMoveToFitCompletionHandler)
			
		}
	}
	
	fileprivate func setPlayAreaGridTokenMenuViewPosition(at cellCoord: CellCoord) {
		
		// Get indicatedPoint for cellCoord
		let indicatedPoint: 	CGPoint = self.playAreaView.gridScapeManager!.get(indicatedPoint: cellCoord)
		
		// Used to reposition the view
		let offsetY:			CGFloat = 30
		
		self.playAreaGridTokenMenuViewBottomLayoutConstraint.constant 	= (self.playAreaView.frame.size.height - indicatedPoint.y) - offsetY
		self.playAreaGridTokenMenuViewLeadingLayoutConstraint.constant 	= indicatedPoint.x
		
		self.view.layoutIfNeeded()
		
	}
	
	fileprivate func hidePlayAreaGridTokenMenuView() {
		
		DispatchQueue.main.async {
			
			self.playAreaGridTokenMenuViewIsShownYN = false
			
			self.doSetPlayAreaGridTokenMenuViewAnimation()
			
			self.playAreaGridTokenMenuView.clearView()
			
		}
		
		self.controlManager!.clearPlayChallenges(byIsActiveYN: false)
		
	}
	
	fileprivate func doSetPlayAreaGridTokenMenuViewAnimation() {
		
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
			
			self.doSetPlayAreaGridTokenMenuView(isPresentedYN: self.playAreaGridTokenMenuViewIsShownYN)
			
			self.view.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetPlayAreaGridTokenMenuView(isPresentedYN: Bool) {
		
		if (isPresentedYN) {
			
			self.playAreaGridTokenMenuView.alpha = 1

		} else {
			
			self.playAreaGridTokenMenuView.alpha = 0
			
		}
		
	}
	
	fileprivate func checkShouldMoveGridPositionToFitPlayAreaGridTokenMenuView(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let setGridPositionCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Call the completion handler
			completionHandler(error)
			
		}
		
		let leftMargin:				CGFloat = 20
		let rightMargin: 			CGFloat = 20
		let topMargin: 				CGFloat = 20
		
		// Get display size
		let displaySize: 			CGSize = self.playAreaView!.frame.size
		
		// Get maxX, minY
		let maxX: 					CGFloat = self.playAreaGridTokenMenuView.frame.maxX
		let minX:					CGFloat = self.playAreaGridTokenMenuView.frame.minX
		let minY: 					CGFloat = self.playAreaGridTokenMenuView.frame.minY
		
		// Get isOffscreenLeftYN
		let offscreenLeftAmount:	CGFloat = (0 + leftMargin) - minX
		let isOffscreenLeftYN: 		Bool = (offscreenLeftAmount > 0)
		
		// Get isOffscreenRightYN
		let offscreenRightAmount:	CGFloat = maxX - (displaySize.width - rightMargin)
		let isOffscreenRightYN: 	Bool = (offscreenRightAmount > 0)
		
		// Get isOffscreenTopYN
		let offscreenTopAmount:		CGFloat = (0 + self.dashboardBarView.frame.size.height + topMargin) - minY
		let isOffscreenTopYN: 		Bool = (offscreenTopAmount > 0)
		
		// Get gridPosition
		let gridPosition: 			CGPoint = self.playAreaView.gridScapeManager!.gridPosition
		
		// Set toIndicatedOffsetX
		var toIndicatedOffsetX: 	CGFloat = gridPosition.x
		
		if (isOffscreenLeftYN) {			// Offset to right
			
			toIndicatedOffsetX = gridPosition.x + offscreenLeftAmount
			
		} else if (isOffscreenRightYN) {	// Offset to left
			
			toIndicatedOffsetX = gridPosition.x - offscreenRightAmount
			
		}
		
		// Set toIndicatedOffsetY
		let toIndicatedOffsetY:		CGFloat = (isOffscreenTopYN) ? (gridPosition.y + offscreenTopAmount) : gridPosition.y
		
		if (isOffscreenLeftYN || isOffscreenRightYN || isOffscreenTopYN) {
			
			// Set grid position
			self.playAreaView.gridScapeManager!.set(gridPositionAt: toIndicatedOffsetX, indicatedOffsetY: toIndicatedOffsetY, animateYN: true, oncomplete: setGridPositionCompletionHandler)
			
		} else {
			
			// Call the completion handler
			completionHandler(nil)
			
		}
		
	}

	
	// MARK: - Private Methods; PlayAreaPathMenuView
	
	fileprivate func setupPlayAreaPathMenuView() {
		
		self.playAreaPathMenuView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playAreaPathMenuPlaceholderView.isHidden	= true
		
		self.playAreaPathMenuViewIsShownYN 				= false
		self.doSetPlayAreaPathMenuView(isPresentedYN: false)
		
	}
	
	fileprivate func presentPlayAreaPathMenuView(for tokenWrapper: PlayAreaTokenWrapper, playAreaPathWrapper: PlayAreaPathWrapper, at indicatedPoint: CGPoint, cellCoord: CellCoord) {
		
		// Present the menu items
		self.playAreaPathMenuView.present(for: tokenWrapper, playAreaPathWrapper: playAreaPathWrapper)
		
		// Use sizeThatFits to determine height
		let s: CGSize = self.playAreaPathMenuView.sizeThatFits(self.playAreaPathMenuView.frame.size)
		self.playAreaPathMenuView.heightAnchor.constraint(equalToConstant: s.height).isActive = true
		
		// Nb: Call viewDidAppear to ensure the view is updated
		self.playAreaPathMenuView.viewDidAppear()
		
		// Set menu position
		self.setPlayAreaPathMenuViewPosition(at: cellCoord)
		
		self.view.layoutIfNeeded()
		
		// Create completion handler
		let checkShouldMoveToFitCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			self.playAreaPathMenuViewIsShownYN = true
			
			// Set menu position
			self.setPlayAreaPathMenuViewPosition(at: cellCoord)
			
			// Animate menu
			self.doSetPlayAreaPathMenuViewAnimation()
			
		}
		
		// Check should move grid position
		self.checkShouldMoveGridPositionToFitPlayAreaPathMenuView(oncomplete: checkShouldMoveToFitCompletionHandler)
		
	}
	
	fileprivate func setPlayAreaPathMenuViewPosition(at cellCoord: CellCoord) {
		
		// Get indicatedPoint for cellCoord
		let indicatedPoint: 	CGPoint = self.playAreaView.gridScapeManager!.get(indicatedPoint: cellCoord)
		
		// Used to reposition the view
		let offsetY:			CGFloat = 30
		
		self.playAreaPathMenuViewBottomLayoutConstraint.constant 	= (self.playAreaView.frame.size.height - indicatedPoint.y) - offsetY
		self.playAreaPathMenuViewLeadingLayoutConstraint.constant 	= indicatedPoint.x
		
		self.view.layoutIfNeeded()
		
	}
	
	fileprivate func hidePlayAreaPathMenuView() {
		
		self.playAreaPathMenuViewIsShownYN = false
		
		self.doSetPlayAreaPathMenuViewAnimation()
		
		self.playAreaPathMenuView.clearView()
		
		if (self.playAreaPathIsShownYN) {
			
			self.controlManager!.hidePlayAreaPath()
			
		}
		
	}
	
	fileprivate func doSetPlayAreaPathMenuViewAnimation() {
		
		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
			
			self.doSetPlayAreaPathMenuView(isPresentedYN: self.playAreaPathMenuViewIsShownYN)
			
			self.view.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	fileprivate func doSetPlayAreaPathMenuView(isPresentedYN: Bool) {
		
		if (isPresentedYN) {
			
			self.playAreaPathMenuView.alpha = 1
			
		} else {
			
			self.playAreaPathMenuView.alpha = 0
			
		}
		
	}
	
	fileprivate func checkShouldMoveGridPositionToFitPlayAreaPathMenuView(oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let setGridPositionCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Call the completion handler
			completionHandler(nil)
			
		}
		
		let leftMargin:				CGFloat = 20
		let rightMargin: 			CGFloat = 20
		let topMargin: 				CGFloat = 20
		
		// Get display size
		let displaySize: 			CGSize = self.playAreaView!.frame.size
		
		// Get maxX, minY
		let maxX: 					CGFloat = self.playAreaPathMenuView.frame.maxX
		let minX:					CGFloat = self.playAreaPathMenuView.frame.minX
		let minY: 					CGFloat = self.playAreaPathMenuView.frame.minY
		
		// Get isOffscreenLeftYN
		let offscreenLeftAmount:	CGFloat = (0 + leftMargin) - minX
		let isOffscreenLeftYN: 		Bool = (offscreenLeftAmount > 0)
		
		// Get isOffscreenRightYN
		let offscreenRightAmount:	CGFloat = maxX - (displaySize.width - rightMargin)
		let isOffscreenRightYN: 	Bool = (offscreenRightAmount > 0)
		
		// Get isOffscreenTopYN
		let offscreenTopAmount:		CGFloat = (0 + self.dashboardBarView.frame.size.height + topMargin) - minY
		let isOffscreenTopYN: 		Bool = (offscreenTopAmount > 0)
		
		// Get gridPosition
		let gridPosition: 			CGPoint = self.playAreaView.gridScapeManager!.gridPosition
		
		// Set toIndicatedOffsetX
		var toIndicatedOffsetX: 	CGFloat = gridPosition.x
		
		if (isOffscreenLeftYN) {			// Offset to right
			
			toIndicatedOffsetX = gridPosition.x + offscreenLeftAmount
			
		} else if (isOffscreenRightYN) {	// Offset to left
			
			toIndicatedOffsetX = gridPosition.x - offscreenRightAmount
			
		}
		
		// Set toIndicatedOffsetY
		let toIndicatedOffsetY:		CGFloat = (isOffscreenTopYN) ? (gridPosition.y + offscreenTopAmount) : gridPosition.y
		
		if (isOffscreenLeftYN || isOffscreenRightYN || isOffscreenTopYN) {
			
			// Set grid position
			self.playAreaView.gridScapeManager!.set(gridPositionAt: toIndicatedOffsetX, indicatedOffsetY: toIndicatedOffsetY, animateYN: true, oncomplete: setGridPositionCompletionHandler)
			
		} else {
			
			// Call the completion handler
			completionHandler(nil)
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayGameEditView
	
	fileprivate func setupPlayGameEditView() {
		
		self.playGameEditView.delegate				= self
		
		// Hide placeholder view which is just used for view in interface builder
		self.playGameEditPlaceholderView.isHidden	= true
		
		self.playGameEditView.alpha					= 0
		
		self.doSetPlayGameEditView(isPresentedYN: false)
		
	}
	
	fileprivate func presentPlayGameEditView() {
		
		self.doSetPlayGameEditViewAnimation(isPresentedYN: true)
		
	}
	
	fileprivate func hidePlayGameEditView() {
		
		self.doSetPlayGameEditViewAnimation(isPresentedYN: false)
		
	}
	
	fileprivate func doSetPlayGameEditViewAnimation(isPresentedYN: Bool) {
		
		DispatchQueue.main.async {
		
			self.playGameEditView.alpha = 1
			
			UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseOut, animations: {
				
				self.doSetPlayGameEditView(isPresentedYN: isPresentedYN)
				
				self.view.layoutIfNeeded()
				
			}) { (completedYN) in
				
				if (!isPresentedYN) {
					
					self.playGameEditView.alpha = 0
					self.playGameEditView.clearView()
					
				}
				
			}
			
		}
		
	}
	
	fileprivate func doSetPlayGameEditView(isPresentedYN: Bool) {
		
		if (isPresentedYN) {
			
			//self.playGameEditView.alpha = 1
			self.playGameEditViewTopLayoutConstraint.constant = 0
			
		} else {
			
			//self.playGameEditView.alpha = 0

			self.playGameEditViewTopLayoutConstraint.constant = self.playGameEditView.frame.height
			
		}
		
	}

	
	// MARK: - Private Methods; PlaySubsets
	
	fileprivate func loadPlaySubsets(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create completion handler
		let loadPlaySubsetsCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				// Call completion handler
				completionHandler(wrappers, error)
			
				return
			}
			
			// Get playSubsetWrappers
			let playSubsetWrappers: [PlaySubsetWrapper]? = wrappers!["PlaySubsets"] as? [PlaySubsetWrapper]
			
			guard (playSubsetWrappers != nil) else {
				
				self.presentOperationFailedAlert()
				
				// Call completion handler
				completionHandler(wrappers, error)
				
				return
				
			}

			// Call completion handler
			completionHandler(wrappers, nil)
			
			// TODO:
			// Set in LanguagesPopoverView????
			
		}
		
		// Load playSubsets
		self.controlManager!.loadPlaySubsets(for: RelativeMemberWrapper.current!, oncomplete: loadPlaySubsetsCompletionHandler)
		
	}
	

	// MARK: - Private Methods; PlayGames

	fileprivate func initialLoadPlayGame(oncomplete completionHandler:@escaping ([String:Any]?, Error?) -> Void) {
		
		// Create completion handler
		let processLoadedPlayGameCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Call completion handler
			completionHandler(wrappers, error)
			
		}
		
		// Create completion handler
		let addPlayGameCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Process loaded PlayGame
			self.controlManager!.processLoadedPlayGame(wrappers: wrappers!, oncomplete: processLoadedPlayGameCompletionHandler)
			
		}
		
		// Create completion handler
		let loadPlayGamesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Get playGameWrappers
			let playGameWrappers: [PlayGameWrapper]? = wrappers!["PlayGames"] as? [PlayGameWrapper]
			
			guard (playGameWrappers != nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			if (playGameWrappers!.count > 0) {
				
				// Process loaded PlayGame
				self.controlManager!.processLoadedPlayGame(wrappers: wrappers!, oncomplete: processLoadedPlayGameCompletionHandler)
				
			} else {
				
				// Add PlayGame
				self.controlManager!.addPlayGame(for: RelativeMemberWrapper.current!, oncomplete: addPlayGameCompletionHandler)
				
			}
			
		}

		// DEBUG:
		PlayGamesCacheManager.shared.deleteAllFromCache()
		PlayGameDataCacheManager.shared.deleteAllFromCache()
		PlayAreaCellsCacheManager.shared.deleteAllFromCache()
		PlayAreaTilesCacheManager.shared.deleteAllFromCache()
		PlayAreaTileDataCacheManager.shared.deleteAllFromCache()
		PlayAreaTokensCacheManager.shared.deleteAllFromCache()
		self.clearActivePlayGameID()
		
		// Clear PlayGame
		self.controlManager!.clearPlayGame()
		
		// Get activePlayGameID
		let activePlayGameID: String? = self.retrieveActivePlayGameID()
		
		if (activePlayGameID != nil) {
			
			// Load PlayGame for activePlayGameID
			self.controlManager!.loadPlayGame(for: activePlayGameID!, oncomplete: loadPlayGamesCompletionHandler)
			
		} else {
			
			// Load latest PlayGame
			self.controlManager!.loadLatestPlayGame(oncomplete: loadPlayGamesCompletionHandler)
			
		}
		
	}
	
	fileprivate func clearActivePlayGameID() {
	
		SettingsManager.clear(forKey: "\(AppSettingsKeys.ActivePlayGameID)", prefix: RelativeMemberWrapper.current!.id)
		
	}
	
	fileprivate func retrieveActivePlayGameID() -> String? {
		
		var result: String? = nil
		
		result = SettingsManager.get(stringForKey: "\(AppSettingsKeys.ActivePlayGameID)", prefix: RelativeMemberWrapper.current!.id)
		
		return result
		
	}
	
	fileprivate func storeActivePlayGameID() {
		
		guard (self.controlManager!.playGameWrapper != nil) else { return }
		
		SettingsManager.set(string: self.controlManager!.playGameWrapper!.id, forKey: "\(AppSettingsKeys.ActivePlayGameID)", prefix: RelativeMemberWrapper.current!.id)
		
	}
	
	fileprivate func setupPlayGame(playGameWrapper: PlayGameWrapper) {
		
		// Set playGameWrapper
		self.controlManager!.set(playGameWrapper: playGameWrapper)
		
		// Store active PlayGameID
		self.storeActivePlayGameID()
		
		// Clear views
		self.playResultsView.clearView()
		self.playDeckView.clearView()
		self.playActiveChallengeView.clearView()
		self.playControlBarView.clearView()
		self.playAreaView.clearView()
		
		// Create completion handler
		let setCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			// Display playAreaPathAbilities
			self.controlManager!.displayPlayAreaPathAbilitiesForToken()
			
			// Display playGameData
			self.playResultsView.displayPlayGameData(playGameWrapper: playGameWrapper)
			
			// Add cell to PlayDeckView
			self.doAddCellToPlayDeckView()
			
			// Display active playChallenge
			self.controlManager!.displayPlayActiveChallenge()
			
		}
		
		// Display playGame
		self.playAreaView.set(relativeMemberWrapper: RelativeMemberWrapper.current!, playGameWrapper: playGameWrapper, playAreaID: "1", oncomplete: setCompletionHandler)
		
	}
	
	fileprivate func loadSelectedPlayGame(wrapper: PlayGameWrapper) {

		// Create completion handler
		let processLoadedPlayGameCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Get playGameWrappers
			let playGameWrappers: [PlayGameWrapper]? = wrappers!["PlayGames"] as? [PlayGameWrapper]
			
			guard (playGameWrappers != nil && playGameWrappers!.count > 0) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Setup PlayGame
			self.setupPlayGame(playGameWrapper: playGameWrappers!.first!)
			
		}
		
		// Create completion handler
		let loadPlayGameCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Process loaded PlayGame
			self.controlManager!.processLoadedPlayGame(wrappers: wrappers!, oncomplete: processLoadedPlayGameCompletionHandler)
			
		}
		
		// Clear PlayGame
		self.controlManager!.clearPlayGame()
		
		// Load PlayGame
		self.controlManager!.loadPlayGame(for: wrapper.id, oncomplete: loadPlayGameCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods; SequencedViews
	
	fileprivate func presentSequencedViews(playExperienceWrappers: [PlayExperienceWrapper]?, playExperienceStepWrappers: [PlayExperienceStepWrapper]?, playChallengeObjectiveWrappers: [PlayChallengeObjectiveWrapper]?, playChallengeWrappers: [PlayChallengeWrapper]?, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		var sequencedViewWrappers: [SequencedViewWrapper] = [SequencedViewWrapper]()
		
		// Create completion handler
		let checkSequencedViewsCompletionHandler: (([SequencedViewWrapper]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		var index: Int = 0

		// Check playExperienceWrappers
		if (playExperienceWrappers != nil && playExperienceWrappers!.count > 0) {

			// Go through each item
			for pew in playExperienceWrappers! {

				// Create SequencedViewWrapper
				let svw: 								SequencedViewWrapper = SequencedViewWrapper()
				svw.type 								= .PlayExperienceComplete
				svw.index 								= index
				svw.params["PlayExperienceWrapper"] 	= pew

				sequencedViewWrappers.append(svw)
				index += 1

			}

		}
		
		// Check playExperienceStepWrappers
		if (playExperienceStepWrappers != nil && playExperienceStepWrappers!.count > 0) {
			
			// Go through each item
			for pesw in playExperienceStepWrappers! {
				
				// Create SequencedViewWrapper
				let svw: 									SequencedViewWrapper = SequencedViewWrapper()
				svw.type 									= .PlayExperienceStepComplete
				svw.index 									= index
				svw.params["PlayExperienceStepWrapper"] 	= pesw
				
				sequencedViewWrappers.append(svw)
				index += 1
				
			}
			
		}
		
		// Check playChallengeObjectiveWrappers
		if (playChallengeObjectiveWrappers != nil && playChallengeObjectiveWrappers!.count > 0) {
			
			// Go through each item
			for pcow in playChallengeObjectiveWrappers! {
				
				// Create SequencedViewWrapper
				let svw: 										SequencedViewWrapper = SequencedViewWrapper()
				svw.type 										= .PlayChallengeObjectiveComplete
				svw.index 										= index
				svw.params["PlayChallengeObjectiveWrapper"] 	= pcow
				
				sequencedViewWrappers.append(svw)
				index += 1
				
			}
			
		}
		
		// Check playChallengeWrappers
		if (playChallengeWrappers != nil && playChallengeWrappers!.count > 0) {
			
			// Go through each item
			for pcw in playChallengeWrappers! {
				
				// Create SequencedViewWrapper
				let svw: 							SequencedViewWrapper = SequencedViewWrapper()
				svw.type 							= .PlayChallengeComplete
				svw.index 							= index
				svw.params["PlayChallengeWrapper"] 	= pcw
				
				sequencedViewWrappers.append(svw)
				index += 1
				
			}
			
		}
		
		// Check sequencedViews
		self.checkSequencedViews(sequencedViewWrappers: sequencedViewWrappers, hideCurrentViewYN: true, oncomplete: checkSequencedViewsCompletionHandler)
		
	}
	
	fileprivate func checkSequencedViews(sequencedViewWrappers: [SequencedViewWrapper], hideCurrentViewYN: Bool, oncomplete completionHandler:@escaping ([SequencedViewWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let doCheckSequencedViewsCompletionHandler: (([SequencedViewWrapper]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				// Call completion handler
				completionHandler(wrappers, error)
				
				return
				
			}
			
			// Check sequencedViews
			self.checkSequencedViews(sequencedViewWrappers: sequencedViewWrappers, hideCurrentViewYN: hideCurrentViewYN, oncomplete: completionHandler)
			
		}
		
		// Create completion handler
		let doCheckSequencedViewsOnFinishedCompletionHandler: (([SequencedViewWrapper]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			// Call completion handler
			completionHandler(wrappers, error)
			
		}
		
		// Check relational data
		self.doCheckSequencedViews(sequencedViewWrappers: sequencedViewWrappers,
								   hideCurrentViewYN: hideCurrentViewYN,
								   oncomplete: doCheckSequencedViewsCompletionHandler,
								   onfinished: doCheckSequencedViewsOnFinishedCompletionHandler)
		
	}
	
	fileprivate func doCheckSequencedViews(sequencedViewWrappers: [SequencedViewWrapper], hideCurrentViewYN: Bool, oncomplete completionHandler:@escaping ([SequencedViewWrapper]?, Error?) -> Void, onfinished onFinishedCompletionHandler:@escaping ([SequencedViewWrapper]?, Error?) -> Void) {
		
		// Create completion handler
		let onCloseCompletionHandler: ((SequencedViewWrapper, Error?) -> Void) =
		{
			(wrapper, error) -> Void in
			
			// Nb: The view has already been hidden by the call to the delegate
			// Hide sequencedView
			//self.hideSequencedView(for: wrapper)
			
			// Call completion handler
			completionHandler(sequencedViewWrappers, error)
			
		}
		
		// Get next sequencedViewWrapper
		var sequencedViewWrapper: 							SequencedViewWrapper? = nil
		
		// Go through each item
		for svw in sequencedViewWrappers {
			
			// Check hasBeenPresentedYN
			if (!svw.hasBeenPresentedYN) {
				
				sequencedViewWrapper 						= svw
				sequencedViewWrapper!.hasBeenPresentedYN 	= true
				
				break
				
			}
			
		}
		
		guard (sequencedViewWrapper != nil) else {
			
			// Call completion handler
			onFinishedCompletionHandler(sequencedViewWrappers, nil)
			
			return
			
		}
		
		// Present sequencedView
		let didPresentYN: Bool = self.presentSequencedView(for: sequencedViewWrapper!, onclose: onCloseCompletionHandler)
		
		if (!didPresentYN) {
		
			// Call completion handler
			onFinishedCompletionHandler(sequencedViewWrappers, nil)
			
		}
		
	}
	
	fileprivate func presentSequencedView(for sequencedViewWrapper: 							SequencedViewWrapper, onclose onCloseCompletionHandler: ((SequencedViewWrapper, Error?) -> Void)?) -> Bool {
		
		var result: Bool = true
		
		// Check type
		if (sequencedViewWrapper.type == .PlayExperienceComplete) {
			
			// Present PlayExperienceCompleteView
			self.presentPlayExperienceCompleteView(with: sequencedViewWrapper, onclose: onCloseCompletionHandler)
			
		} else if (sequencedViewWrapper.type == .PlayExperienceStepComplete) {
			
			// Present PlayExperienceCompleteView
			self.presentPlayExperienceStepCompleteView(with: sequencedViewWrapper, onclose: onCloseCompletionHandler)

		} else if (sequencedViewWrapper.type == .PlayChallengeObjectiveComplete) {
			
			// Present PlayChallengeObjectiveCompleteView
			self.presentPlayChallengeObjectiveCompleteView(with: sequencedViewWrapper, onclose: onCloseCompletionHandler)

		} else if (sequencedViewWrapper.type == .PlayChallengeComplete) {
			
			// Present PlayChallengeCompleteView
			self.presentPlayChallengeCompleteView(with: sequencedViewWrapper, onclose: onCloseCompletionHandler)
			
		} else {
			
			result = false
			
		}
		
		return result
		
	}
	
	fileprivate func doPresentSequencedViewAnimation(view: UIView, oncomplete completionhandler: ((NSError?) -> Void)?) {
		
		let offset: 	CGFloat = 0

		UIView.animate(withDuration: 0.3, delay: 0, options: .curveEaseIn, animations: {
			
			view.centerXAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerXAnchor, constant: offset).isActive = true
			
			self.view.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}

	fileprivate func doHideSequencedViewAnimation(view: UIView, oncomplete completionhandler: ((NSError?) -> Void)?) {
		
		UIView.animate(withDuration: 0.1, delay: 0, options: .curveEaseIn, animations: {
			
			view.alpha = 0
			
			self.view.layoutIfNeeded()
			
		}) { (completedYN) in
			
			// Not required
		}
		
	}
	
	
	// MARK: - Private Methods; PlayExperienceStepView
	
	fileprivate func setupPlayExperienceStepView() {
		
		self.playExperienceStepView.alpha = 0
		
	}
	
	fileprivate func hidePlayExperienceStepView() {
		
		// Hide view
		UIView.animate(withDuration: 0.1) {
			
			self.playExperienceStepView.alpha = 0
		}
		
	}
	
	fileprivate func presentConfirmClosePlayExperienceStepAlert(onconfirm completionHandler:@escaping (UIAlertAction?) -> Void) {
		
		// Create completion handler
		let onOkCompletionHandler: ((UIAlertAction?) -> Void) =
		{
			(action) -> Void in
			
			// Call completion handler
			completionHandler(action)
			
		}
		
		let alertTitle:     String = NSLocalizedString("AlertTitleConfirmClosePlayExperienceStep", comment: "")
		let alertMessage:   String = NSLocalizedString("AlertMessageConfirmClosePlayExperienceStep", comment: "")
		
		DispatchQueue.main.async {
			
			UIAlertControllerHelper.presentAlert(alertType: .OkCancel, alertTitle: alertTitle, alertMessage: alertMessage, onok: onOkCompletionHandler, oncancel: nil)
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayExperienceStepCompleteView
	
	fileprivate func presentPlayExperienceStepCompleteView(with sequencedViewWrapper: 							SequencedViewWrapper, onclose onCloseCompletionhandler: ((SequencedViewWrapper, Error?) -> Void)?) {
		
		// Get PlayExperienceStepWrapper
		let wrapper: 							PlayExperienceStepWrapper = sequencedViewWrapper.params["PlayExperienceStepWrapper"] as! PlayExperienceStepWrapper
		
		// Create playExperienceStepCompleteView
		let playExperienceStepCompleteView: 	ProtocolPlayExperienceStepCompleteView = PlayViewFactory.createPlayExperienceStepCompleteView(wrapper: wrapper, delegate: self)!
		
		// Set playExperienceStepWrapper and onclose completion handler in playExperienceStepCompleteView
		playExperienceStepCompleteView.set(playExperienceStepWrapper: wrapper, sequencedViewWrapper: sequencedViewWrapper, onclose: onCloseCompletionhandler)
		
		// Present playExperienceStepCompleteView
		self.presentPlayExperienceStepCompleteView(view: playExperienceStepCompleteView)
		
	}
	
	fileprivate func presentPlayExperienceStepCompleteView(view: ProtocolPlayExperienceStepCompleteView) {
		
		DispatchQueue.main.async {
			
			// Add to collection
			self.playExperienceStepCompleteViews[view.sequencedViewWrapper!.id] = view as? PlayExperienceStepCompleteView
			
			let v = view as! UIView
			
			self.sequencedViewsContainerView.addSubview(v)
			self.sequencedViewsContainerView.bringSubview(toFront: v)
			
			let offset: 	CGFloat = self.sequencedViewsContainerView.frame.width / 2
			
			v.centerXAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerXAnchor, constant: offset).isActive = true
			v.centerYAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerYAnchor).isActive = true
			
			self.view.layoutIfNeeded()
			self.view.layoutSubviews()
			
			self.sequencedViewsContainerView.isUserInteractionEnabled = true
			
			// Animate view
			self.doPresentSequencedViewAnimation(view: v, oncomplete: nil)

		}
		
	}
	
	fileprivate func hidePlayExperienceStepCompleteView(view: ProtocolPlayExperienceStepCompleteView, oncomplete completionhandler: ((NSError?) -> Void)?) {
		
		// Get view from collection
		let pescv: UIView? = self.playExperienceStepCompleteViews[view.sequencedViewWrapper!.id]
		
		guard (pescv != nil) else {
			
			// Call the completion handler
			completionhandler?(nil)
			
			return
			
		}
		
		DispatchQueue.main.async {
			
			pescv!.removeFromSuperview()
			
			if (self.sequencedViewsContainerView.subviews.count == 0) {
				
				self.sequencedViewsContainerView.isUserInteractionEnabled = false
				
			}
			
			// Animate view
			self.doHideSequencedViewAnimation(view: view as! UIView, oncomplete: nil)
			
			// Remove from collection
			self.playExperienceStepCompleteViews.removeValue(forKey: view.sequencedViewWrapper!.id)

			// Call the completion handler
			completionhandler?(nil)
			
		}

	}

	
	// MARK: - Private Methods; PlayExperienceView
	
	fileprivate func setupPlayExperienceView() {
		
		self.playExperienceView.alpha = 0
		
	}
	
	fileprivate func hidePlayExperienceView() {
		
		// Hide view
		UIView.animate(withDuration: 0.1) {
			
			self.playExperienceView.alpha = 0
		}
		
	}
	
	fileprivate func presentConfirmClosePlayExperienceAlert(onconfirm completionHandler:@escaping (UIAlertAction?) -> Void) {
		
		// Create completion handler
		let onOkCompletionHandler: ((UIAlertAction?) -> Void) =
		{
			(action) -> Void in
			
			// Call completion handler
			completionHandler(action)
			
		}
		
		let alertTitle:     String = NSLocalizedString("AlertTitleConfirmClosePlayExperience", comment: "")
		let alertMessage:   String = NSLocalizedString("AlertMessageConfirmClosePlayExperience", comment: "")
		
		DispatchQueue.main.async {
			
			UIAlertControllerHelper.presentAlert(alertType: .OkCancel, alertTitle: alertTitle, alertMessage: alertMessage, onok: onOkCompletionHandler, oncancel: nil)
			
		}
		
	}
	
	
	// MARK: - Private Methods; PlayExperienceCompleteView
	
	fileprivate func presentPlayExperienceCompleteView(with sequencedViewWrapper: 							SequencedViewWrapper, onclose onCloseCompletionhandler: ((SequencedViewWrapper, Error?) -> Void)?) {
		
		// Get PlayExperienceWrapper
		let wrapper: 						PlayExperienceWrapper = sequencedViewWrapper.params["PlayExperienceWrapper"] as! PlayExperienceWrapper
		
		// Create playExperienceCompleteView
		let playExperienceCompleteView: 	ProtocolPlayExperienceCompleteView = PlayViewFactory.createPlayExperienceCompleteView(wrapper: wrapper, delegate: self)!
		
		// Set playExperienceWrapper and onclose completion handler in playExperienceCompleteView
		playExperienceCompleteView.set(playExperienceWrapper: wrapper, sequencedViewWrapper: sequencedViewWrapper, onclose: onCloseCompletionhandler)
		
		// Present playExperienceCompleteView
		self.presentPlayExperienceCompleteView(view: playExperienceCompleteView)
		
	}
	
	fileprivate func presentPlayExperienceCompleteView(view: ProtocolPlayExperienceCompleteView) {
		
		DispatchQueue.main.async {
			
			// Add to collection
			self.playExperienceCompleteViews[view.sequencedViewWrapper!.id] = view as? PlayExperienceCompleteView
			
			let v = view as! UIView
			
			self.sequencedViewsContainerView.addSubview(v)
			self.sequencedViewsContainerView.bringSubview(toFront: v)
			
			let offset: 	CGFloat = self.sequencedViewsContainerView.frame.width / 2
			
			v.centerXAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerXAnchor, constant: offset).isActive = true
			v.centerYAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerYAnchor).isActive = true
			
			self.view.layoutIfNeeded()
			self.view.layoutSubviews()
			
			self.sequencedViewsContainerView.isUserInteractionEnabled = true
			
			// Animate view
			self.doPresentSequencedViewAnimation(view: v, oncomplete: nil)

		}
		
	}
	
	fileprivate func hidePlayExperienceCompleteView(view: ProtocolPlayExperienceCompleteView, oncomplete completionhandler: ((NSError?) -> Void)?) {
		
		// Get view from collection
		let pecv: UIView? = self.playExperienceCompleteViews[view.sequencedViewWrapper!.id]
		
		guard (pecv != nil) else {

			// Call the completion handler
			completionhandler?(nil)

			return

		}

		DispatchQueue.main.async {

			pecv!.removeFromSuperview()
			
			if (self.sequencedViewsContainerView.subviews.count == 0) {
				
				self.sequencedViewsContainerView.isUserInteractionEnabled = false
				
			}
			
			// Animate view
			self.doHideSequencedViewAnimation(view: view as! UIView, oncomplete: nil)
			
			// Remove from collection
			self.playExperienceCompleteViews.removeValue(forKey: view.sequencedViewWrapper!.id)

			// Call the completion handler
			completionhandler?(nil)
		}

	}
	
	
	// MARK: - Private Methods; PlayChallengeObjectiveCompleteView
	
	fileprivate func presentPlayChallengeObjectiveCompleteView(with sequencedViewWrapper: 							SequencedViewWrapper, onclose onCloseCompletionhandler: ((SequencedViewWrapper, Error?) -> Void)?) {
		
		// Get PlayChallengeObjectiveWrapper
		let wrapper: 								PlayChallengeObjectiveWrapper = sequencedViewWrapper.params["PlayChallengeObjectiveWrapper"] as! PlayChallengeObjectiveWrapper
		
		// Create playChallengeObjectiveCompleteView
		let playChallengeObjectiveCompleteView: 	ProtocolPlayChallengeObjectiveCompleteView = PlayViewFactory.createPlayChallengeObjectiveCompleteView(wrapper: wrapper, delegate: self)!
		
		// Set playChallengeObjectiveWrapper and onclose completion handler in playChallengeObjectiveCompleteView
		playChallengeObjectiveCompleteView.set(playChallengeObjectiveWrapper: wrapper, sequencedViewWrapper: sequencedViewWrapper, onclose: onCloseCompletionhandler)
		
		// Present playChallengeObjectiveCompleteView
		self.presentPlayChallengeObjectiveCompleteView(view: playChallengeObjectiveCompleteView)
		
	}
	
	fileprivate func presentPlayChallengeObjectiveCompleteView(view: ProtocolPlayChallengeObjectiveCompleteView) {

		DispatchQueue.main.async {
			
			// Add to collection
			self.playChallengeObjectiveCompleteViews[view.sequencedViewWrapper!.id] = view as? PlayChallengeObjectiveCompleteView
			
			let v = view as! UIView
			
			self.sequencedViewsContainerView.addSubview(v)
			self.sequencedViewsContainerView.bringSubview(toFront: v)
			
			let offset: 	CGFloat = self.sequencedViewsContainerView.frame.width / 2
			
			v.centerXAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerXAnchor, constant: offset).isActive = true
			v.centerYAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerYAnchor).isActive = true
			
			self.view.layoutIfNeeded()
			self.view.layoutSubviews()
			
			self.sequencedViewsContainerView.isUserInteractionEnabled = true
			
			// Animate view
			self.doPresentSequencedViewAnimation(view: v, oncomplete: nil)
			
		}
		
	}
	
	fileprivate func hidePlayChallengeObjectiveCompleteView(view: ProtocolPlayChallengeObjectiveCompleteView, oncomplete completionhandler: ((NSError?) -> Void)?) {
		
		// Get view from collection
		let pcocv: UIView? = self.playChallengeObjectiveCompleteViews[view.sequencedViewWrapper!.id]
		
		guard (pcocv != nil) else {

			// Call the completion handler
			completionhandler?(nil)

			return

		}

		DispatchQueue.main.async {

			pcocv!.removeFromSuperview()
			
			if (self.sequencedViewsContainerView.subviews.count == 0) {
				
				self.sequencedViewsContainerView.isUserInteractionEnabled = false
				
			}
			
			// Animate view
			self.doHideSequencedViewAnimation(view: view as! UIView, oncomplete: nil)
			
			// Remove from collection
			self.playChallengeObjectiveCompleteViews.removeValue(forKey: view.sequencedViewWrapper!.id)

			// Call the completion handler
			completionhandler?(nil)
			
		}

	}

	
	// MARK: - Private Methods; PlayChallengeCompleteView

	fileprivate func presentPlayChallengeCompleteView(with sequencedViewWrapper: 							SequencedViewWrapper, onclose onCloseCompletionhandler: ((SequencedViewWrapper, Error?) -> Void)?) {
		
		// Get PlayChallengeWrapper
		let wrapper: 							PlayChallengeWrapper = sequencedViewWrapper.params["PlayChallengeWrapper"] as! PlayChallengeWrapper
		
		// Create playChallengeCompleteView
		let playChallengeCompleteView: 			ProtocolPlayChallengeCompleteView = PlayViewFactory.createPlayChallengeCompleteView(wrapper: wrapper, delegate: self)!
		
		// Set playChallengeWrapper and onclose completion handler in playChallengeCompleteView
		playChallengeCompleteView.set(playChallengeWrapper: wrapper, sequencedViewWrapper: sequencedViewWrapper, onclose: onCloseCompletionhandler)
		
		// Present playChallengeCompleteView
		self.presentPlayChallengeCompleteView(view: playChallengeCompleteView)
		
	}
	
	fileprivate func presentPlayChallengeCompleteView(view: ProtocolPlayChallengeCompleteView) {
		
		DispatchQueue.main.async {
			
			// Add to collection
			self.playChallengeCompleteViews[view.sequencedViewWrapper!.id] = view as? PlayChallengeCompleteView
			
			let v = view as! UIView
	
			self.sequencedViewsContainerView.addSubview(v)
			self.sequencedViewsContainerView.bringSubview(toFront: v)
			
			let offset: 	CGFloat = self.sequencedViewsContainerView.frame.width / 2
			
			v.centerXAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerXAnchor, constant: offset).isActive = true
			v.centerYAnchor.constraint(equalTo: self.sequencedViewsContainerView.centerYAnchor).isActive = true
			
			self.view.layoutIfNeeded()
			self.view.layoutSubviews()
			
			self.sequencedViewsContainerView.isUserInteractionEnabled = true
			
			// Animate view
			self.doPresentSequencedViewAnimation(view: v, oncomplete: nil)
			
		}
		
	}
	
	fileprivate func hidePlayChallengeCompleteView(view: ProtocolPlayChallengeCompleteView, oncomplete completionhandler: ((NSError?) -> Void)?) {
		
		// Get view from collection
		let pccv: UIView? = self.playChallengeCompleteViews[view.sequencedViewWrapper!.id]
		
		guard (pccv != nil) else {

			// Call the completion handler
			completionhandler?(nil)

			return

		}

		DispatchQueue.main.async {

			pccv!.removeFromSuperview()
			
			if (self.sequencedViewsContainerView.subviews.count == 0) {
				
				self.sequencedViewsContainerView.isUserInteractionEnabled = false
				
			}
			
			// Animate view
			self.doHideSequencedViewAnimation(view: view as! UIView, oncomplete: nil)
			
			// Remove from collection
			self.playChallengeCompleteViews.removeValue(forKey: view.sequencedViewWrapper!.id)

			// Call the completion handler
			completionhandler?(nil)
			
		}

	}

	
	// MARK: - Private Methods; PlayAreaPathAbilities
	
	fileprivate func disengagePlayAreaPathAbilities() {
		
		self.controlManager!.disengagePlayAreaPathAbilities()
	
	}
	
	
	// MARK: - Private Methods; PlayAreaPaths
	
	fileprivate func presentPlayAreaPath(for playAreaTokenWrapper: PlayAreaTokenWrapper, afterTapped cellCoord: CellCoord, at indicatedPoint: CGPoint, withEngaged engagedPlayAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {
		
		guard (!self.playAreaPathMenuViewIsShownYN) else {
		
			self.hidePlayAreaPathMenuView()

			return
			
		}
		
		// Create completion handler
		let buildPlayAreaPathCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else { return }
			
			let playAreaPathWrappers: 		[PlayAreaPathWrapper]? = wrappers!["PlayAreaPaths"] as? [PlayAreaPathWrapper]
			
			guard (playAreaPathWrappers != nil && playAreaPathWrappers!.count > 0) else { return }
			
			DispatchQueue.main.async {
				
				// Display playAreaPath
				self.controlManager!.displayPlayAreaPath(playAreaPathWrapper: playAreaPathWrappers!.first!)
				
				// Present playAreaPathMenuView
				self.presentPlayAreaPathMenuView(for: playAreaTokenWrapper, playAreaPathWrapper: playAreaPathWrappers!.first!, at: indicatedPoint, cellCoord: cellCoord)
				
			}

		}
		
		// Build playAreaPath
		self.controlManager!.buildPlayAreaPath(for: playAreaTokenWrapper, to: cellCoord, by: engagedPlayAreaPathAbilityWrapper, oncomplete: buildPlayAreaPathCompletionHandler)
		
	}

	fileprivate func presentPlayAreaPath(for playAreaTokenWrapper: PlayAreaTokenWrapper, playAreaPathWrapper: PlayAreaPathWrapper, afterPlayExperienceCompleted playExperienceWrapper: PlayExperienceWrapper) {
		
		// Display playAreaPath
		self.controlManager!.displayPlayAreaPath(playAreaPathWrapper: playAreaPathWrapper)

		// Get cellCoord
		let cellCoord: 			CellCoord = CellCoord(column: playAreaTokenWrapper.column, row: playAreaTokenWrapper.row)
		
		// Get indicatedPoint
		let indicatedPoint: 	CGPoint = self.playAreaView.gridScapeManager!.get(indicatedPoint: cellCoord)
		
		// Present playAreaPathMenuView
		self.presentPlayAreaPathMenuView(for: playAreaTokenWrapper, playAreaPathWrapper: playAreaPathWrapper, at: indicatedPoint, cellCoord: cellCoord)

	}

	fileprivate func getPlayAreaPathWrapper(for playMoveWrapper: PlayMoveWrapper) -> PlayAreaPathWrapper? {
		
		var result: 				PlayAreaPathWrapper? = nil
		
		// Get playAreaPathWrappers
		var playAreaPathWrappers: 	[String: PlayAreaPathWrapper] = [String: PlayAreaPathWrapper]()
		
		if (playMoveWrapper.playReferenceType == .PlayAreaPath) {
			
			playAreaPathWrappers 	= PlayWrapper.current!.get(byID: playMoveWrapper.playReferenceID)
			
		} else if (playMoveWrapper.playReferenceType == .PlayAreaPathPoint) {
			
			playAreaPathWrappers 	= PlayWrapper.current!.get(byPlayAreaPathPointID: playMoveWrapper.playReferenceID)
			
		}
		
		// Get playAreaPathWrapper
		result 						= playAreaPathWrappers.values.first
		
		return result
		
	}
	
	fileprivate func resumePlayAreaPath(afterPlayExperienceCompleted wrapper: PlayExperienceWrapper) {
		
		// Get playMoveWrapper
		let playMoveWrapper: 		PlayMoveWrapper = wrapper.playMove!
		
		// Get playAreaPathWrapper
		let papw: 					PlayAreaPathWrapper? = self.getPlayAreaPathWrapper(for: playMoveWrapper)
		
		guard (papw != nil) else { return }
		
		// Check playAreaPathWrapper status
		if (papw!.status == .Finished) {
			
			PlayWrapper.current!.clearPlayAreaPaths()
			
			return
			
		}
		
		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: 	PlayAreaTokenWrapper = PlayWrapper.current!.playAreaTokens!.values.first!
		
		// Set playAreaPathAbility engaged
		self.controlManager!.setPlayAreaPathAbility(for: playAreaTokenWrapper, playAreaPathAbilityType: papw!.playAreaPathAbilityType, isEngagedYN: true, isGoingYN: false)
		
		// Present playAreaPath
		self.presentPlayAreaPath(for: playAreaTokenWrapper, playAreaPathWrapper: papw!,  afterPlayExperienceCompleted: wrapper)
		
	}
	
	fileprivate func doMovePlayAreaTokenAlongPlayAreaPath(playAreaTokenWrapper: 	PlayAreaTokenWrapper, playAreaPathWrapper: 	PlayAreaPathWrapper) {
		
		self.controlManager!.setPlayAreaPathAbility(for: playAreaTokenWrapper, playAreaPathAbilityType: playAreaPathWrapper.playAreaPathAbilityType, isEngagedYN: true, isGoingYN: true)
		
		// Create completion handler
		let movePlayAreaTokenWrapperCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in
			
			self.controlManager!.doAfterMoved(playAreaTokenWrapper: playAreaTokenWrapper, alongPath: playAreaPathWrapper)
			
		}
		
		// Move playAreaTokenWrapper
		self.playAreaView.move(playAreaTokenWrapper: playAreaTokenWrapper, alongPath: playAreaPathWrapper, oncomplete: movePlayAreaTokenWrapperCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods; PlayMoves
	
	fileprivate func presentPlayMoves(for playAreaTokenWrapper: PlayAreaTokenWrapper, afterTapped cellCoord: CellCoord, at indicatedPoint: CGPoint) {
		
		// Create completion handler
		let loadPlayMovesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Get playMoveWrappers
			let playMoveWrappers: [PlayMoveWrapper]? = wrappers!["PlayMoves"] as? [PlayMoveWrapper]
			
			guard (playMoveWrappers != nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Check playMoveWrappers
			if (playMoveWrappers!.count == 0) { return }
			
			DispatchQueue.main.async {
			
				// Present playMoves
				self.presentPlayAreaGridTokenMenuView(playMoveWrappers: playMoveWrappers!, for: playAreaTokenWrapper, at: indicatedPoint, cellCoord: cellCoord)
				
			}
			
		}
		
		// Load playMoves
		self.controlManager!.loadPlayMoves(for: playAreaTokenWrapper, oncomplete: loadPlayMovesCompletionHandler)
		
	}
	
	fileprivate func presentPlayMoves(for playAreaTileWrapper: PlayAreaTileWrapper, afterTapped cellCoord: CellCoord, at indicatedPoint: CGPoint) {
		
		// Create completion handler
		let loadPlayMovesCompletionHandler: (([String:Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Get playMoveWrappers
			let playMoveWrappers: [PlayMoveWrapper]? = wrappers!["PlayMoves"] as? [PlayMoveWrapper]
			
			guard (playMoveWrappers != nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Present playMoves
			self.presentPlayAreaGridTileMenuView(playMoveWrappers: playMoveWrappers!, for: playAreaTileWrapper, at: indicatedPoint, cellCoord: cellCoord)
			
		}
		
		// Load playMoves
		self.controlManager!.loadPlayMoves(for: playAreaTileWrapper, oncomplete: loadPlayMovesCompletionHandler)
		
	}

	
	// MARK: - playDeckButtonView TapGestureRecognizer Methods
	
	@IBAction func playDeckButtonViewTapped(_ sender: Any) {
		
		self.cancelTransientViews()
		
		if (self.playDeckViewIsShownYN) {
			
			self.hidePlayDeckView()
			
		} else {
			
			self.presentPlayDeckView()
			
		}
		
	}

	
	// MARK: - playActiveChallengeButtonView TapGestureRecognizer Methods
	
	@IBAction func playActiveChallengeButtonViewTapped(_ sender: Any) {
		
		self.cancelTransientViews()
		
		if (self.playActiveChallengeViewIsShownYN) {
			
			self.hidePlayActiveChallengeView()
			
		} else {
			
			self.presentPlayActiveChallengeView()
			
		}
		
	}
	
}


// MARK: - Extension ProtocolMainDisplayView

extension MainDisplayViewController: ProtocolMainDisplayView {

	// Public Methods
	
	public func present(playExperienceView view: ProtocolPlayExperienceView) {

		DispatchQueue.main.async {

			self.playExperienceView.subviews.forEach { $0.removeFromSuperview() }


			self.playExperienceView.addSubview(view as! UIView)

			let lc = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal,
										toItem: self.playExperienceView, attribute: .leading,
										multiplier: 1.0, constant: 0)
			let tc = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
										toItem: self.playExperienceView, attribute: .top,
										multiplier: 1.0, constant: 0)
			let trc = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal,
										 toItem: self.playExperienceView, attribute: .trailing,
										 multiplier: 1.0, constant: 0)
			let bc = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
										toItem: self.playExperienceView, attribute: .bottom,
										multiplier: 1.0, constant: 0)


			self.playExperienceView.addConstraints([lc, tc, trc, bc])

			self.playExperienceView.layoutIfNeeded()

		}

		// Show view
		UIView.animate(withDuration: 0.1) {

			self.playExperienceView.alpha 	= 1
		}

	}
	
	public func present(playExperienceStepView view: ProtocolPlayExperienceStepView) {

		DispatchQueue.main.async {

			self.playExperienceStepView.subviews.forEach { $0.removeFromSuperview() }


			self.playExperienceStepView.addSubview(view as! UIView)

			let lc = NSLayoutConstraint(item: view, attribute: .leading, relatedBy: .equal,
										toItem: self.playExperienceStepView, attribute: .leading,
										multiplier: 1.0, constant: 0)
			let tc = NSLayoutConstraint(item: view, attribute: .top, relatedBy: .equal,
										toItem: self.playExperienceStepView, attribute: .top,
										multiplier: 1.0, constant: 0)
			let trc = NSLayoutConstraint(item: view, attribute: .trailing, relatedBy: .equal,
										 toItem: self.playExperienceStepView, attribute: .trailing,
										 multiplier: 1.0, constant: 0)
			let bc = NSLayoutConstraint(item: view, attribute: .bottom, relatedBy: .equal,
										toItem: self.playExperienceStepView, attribute: .bottom,
										multiplier: 1.0, constant: 0)


			self.playExperienceStepView.addConstraints([lc, tc, trc, bc])

			self.playExperienceStepView.layoutIfNeeded()

			// Nb: Call viewDidAppear to ensure the view is updated
			view.viewDidAppear()
			
		}

		// Show view
		UIView.animate(withDuration: 0.1) {

			self.playExperienceStepView.alpha 	= 1
		}

	}

	public func setPlayAreaPath(playAreaPathWrapper: PlayAreaPathWrapper, visibleYN: Bool) {

		self.playAreaPathIsShownYN = visibleYN
		
		// Set playAreaPath in playAreaView
		self.playAreaView.setPlayAreaPath(playAreaPathWrapper: playAreaPathWrapper, visibleYN: visibleYN)
		
	}
	
	public func display(playAreaPathAbility playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper, for playAreaTokenWrapper: PlayAreaTokenWrapper) {
		
		// Set display in playAreaView
		self.playAreaView.set(changedPlayAreaPathAbility: playAreaPathAbilityWrapper, for: playAreaTokenWrapper)
		
	}
	
	public func setPlayActiveChallenge(visibleYN: Bool) {
		
		if (visibleYN) {
		
			self.presentPlayActiveChallengeButtonView()
			
		} else {
			
			self.hidePlayActiveChallengeButtonView()
			
		}
		
	}
	
}


// MARK: - Extension ProtocolApplicationMenuViewDelegate

extension MainDisplayViewController: ProtocolApplicationMenuViewDelegate {
	
	// Public Methods

	public func applicationMenuView(willDismiss sender: ApplicationMenuView) {

		self.dashboardBarView!.set(menuButtonIsSelectedYN: false, animateYN: true)
		
	}
	
	public func applicationMenuView(didDismiss sender: ApplicationMenuView) {
		
		self.applicationMenuViewIsShownYN = false
		
	}
	
	public func applicationMenuView(settingsButtonTapped sender: ApplicationMenuView) {
		
		// Discconnect web socket
		self.disconnectWebSockets()
		
		self.dashboardBarView!.set(menuButtonIsSelectedYN: false, animateYN: false)
		
		// Nb: The delegate of the SettingsDisplayViewController is set in the Perform For Segue method
		
		// Segue to settingsDisplay
		self.performSegue(withIdentifier: "showSettingsDisplay", sender: self)
		
	}
	
	public func applicationMenuView(signOutButtonTapped sender: ApplicationMenuView) {
		
		// Discconnect web socket
		// self.disconnectWebSockets()	// nb: This does not need to be done here because the web socket is disconnected in MemberFeedContainerView.clearViews
		
		self.dashboardBarView!.set(menuButtonIsSelectedYN: false, animateYN: false)
		
		self.controlManager!.signOut()
		
		self.hasViewAppearedYN = false
		
		self.clearViews()
		
	}
	
}


// MARK: - Extension ProtocolPlayResultsViewDelegate

extension MainDisplayViewController: ProtocolPlayResultsViewDelegate {
	
	// Public Methods
	
	public func playResultsView(willDismiss sender: PlayResultsView) {

		self.dashboardBarView!.set(playResultsButtonIsSelectedYN: false, animateYN: true)
		
	}
	
	public func playResultsView(didDismiss sender: PlayResultsView) {
		
		self.playResultsViewIsShownYN = false
		
	}
	
}


// MARK: - Extension ProtocolDashboardBarViewDelegate

extension MainDisplayViewController: ProtocolDashboardBarViewDelegate {
	
	// Public Methods

	public func dashboardBarView(touchesBegan sender: DashboardBarView) {
		
		self.cancelTransientViews()
		self.disengagePlayAreaPathAbilities()
		
	}
	
	public func dashboardBarView(avatarImageTapped sender: DashboardBarView) {
		
		// Nb: The delegate of the SettingsDisplayViewController is set in the Perform For Segue method
		
		// Segue to settingsDisplay
		self.performSegue(withIdentifier: "showSettingsDisplay", sender: self)
		
	}
	
	public func dashboardBarView(playAreaButtonTapped sender: DashboardBarView) {
		
		self.presentPlayAreaView()
		
	}
	
	public func dashboardBarView(playGamesButtonTapped sender: DashboardBarView) {
		
		self.presentPlayGamesView()
		
	}

	public func dashboardBarView(playActiveChallengeButtonTapped sender: DashboardBarView) {
		

	}
	
	public func dashboardBarView(playActiveChallengeDismissed sender: DashboardBarView) {

	}
	
	public func dashboardBarView(playResultsButtonTapped sender: DashboardBarView) {
		
		self.switchPlayResultsView()
		
	}
	
	public func dashboardBarView(playResultsDismissed sender: DashboardBarView) {
		
		self.switchPlayResultsView()
		
	}
	
	public func dashboardBarView(menuButtonTapped sender: DashboardBarView) {
		
		self.switchApplicationMenuView()
		
	}

	public func dashboardBarView(menuDismissed sender: DashboardBarView) {
		
		self.switchApplicationMenuView()
		
	}
	
}


// MARK: - Extension ProtocolSignInDisplayViewControllerDelegate

extension MainDisplayViewController: ProtocolSignInDisplayViewControllerDelegate {
	
	// MARK: - Public Methods
	
	public func signInDisplayViewController(dismiss controller: UIViewController) {
		
		// Dismiss the view
		controller.dismiss(animated: true, completion: nil)

	}
	
}


// MARK: - Extension ProtocolMainDisplayControlManagerDelegate

extension MainDisplayViewController: ProtocolMainDisplayControlManagerDelegate {
	
	// MARK: - Public Methods
	
	public func mainDisplayControlManager(signOutSuccessful userProperties: UserProperties) {
		
		self.onSignOutSuccessful()
	}

	public func mainDisplayControlManager(signOutFailed userProperties: UserProperties?) {
		
		self.onSignOutFailed()
	}
	
	public func mainDisplayControlManager(isNotSignedIn error: Error?) {
		
		self.presentSignInView()
		
	}

	public func mainDisplayControlManager(isNotConnected error: Error?) {
		
		self.presentSignInView()
		
	}
	
	public func mainDisplayControlManager(userProfileWrapperLoadSuccessful userProfileWrapper: UserProfileWrapper){
		
		if (self.hasViewAppearedYN) {
			
			// TODO:
			print(RelativeMemberWrapper.current?.id ?? "rm not loaded!")
			
			// Load data
			self.initialLoad()
			
		}
		
	}

	public func mainDisplayControlManager(userProfileWrapperLoadFailed error: Error?, code: UserProfileWrapperErrorCodes) {
		
		self.controlManager!.signOut()
		
	}
	
	public func mainDisplayControlManager(item: RelativeMemberWrapper, loadedAvatarImage sender: MainDisplayControlManager) {
		
		// Display avatarImage
		// TODO:

	}
	
	public func mainDisplayControlManager(createPlayExperienceViewFor wrapper: PlayExperienceWrapper, delegate: ProtocolPlayExperienceViewDelegate) -> ProtocolPlayExperienceView {
		
		var result: ProtocolPlayExperienceView? = nil
		
		// Create PlayExperienceView
		result = PlayViewFactory.createPlayExperienceView(wrapper: wrapper, delegate: delegate)
		
		return result!
		
	}
	
	public func mainDisplayControlManager(createPlayExperienceStepViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, delegate: ProtocolPlayExperienceStepViewDelegate) -> ProtocolPlayExperienceStepView {
		
		var result: ProtocolPlayExperienceStepView? = nil
		
		// Create PlayExperienceStepView
		result = PlayViewFactory.createPlayExperienceStepView(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper, delegate: delegate)
		
		return result!
		
	}

	public func mainDisplayControlManager(playActiveChallengeLoaded wrapper: PlayChallengeWrapper?, sender: MainDisplayControlManager) {
		
		if (wrapper != nil) {

			self.presentPlayActiveChallengeButtonView()
			self.presentPlayActiveChallengeView()

		} else {

			self.hidePlayActiveChallengeButtonView()
			self.hidePlayActiveChallengeView()

		}
		
	}
	
	public func mainDisplayControlManager(shouldAbortPlayActiveChallenge wrapper: PlayChallengeWrapper, oncomplete completionHandler:@escaping (Bool, Error?) -> Void) {
	
		// TODO:
		// Call the completion handler
		completionHandler(true, nil)
		
	}
	
	public func mainDisplayControlManager(gridScapeManager sender: MainDisplayControlManager) -> GridScapeManager? {
	
		return self.playAreaView.gridScapeManager
		
	}
	
	public func mainDisplayControlManager(gridScapeContainerViewControlManager sender: MainDisplayControlManager) -> GridScapeContainerViewControlManager? {
		
		return self.playAreaView.gridScapeContainerViewControlManager
		
	}
	
	public func mainDisplayControlManager(byFootPlayPathAbilitySet sender: MainDisplayControlManager, isEngagedYN: Bool) {
		
		// TODO:
		
	}
	
}


// MARK: - Extension ProtocolSettingsDisplayViewControllerDelegate

extension MainDisplayViewController: ProtocolSettingsDisplayViewControllerDelegate {
	
	// MARK: - Public Methods
	
	public func settingsDisplayViewController(dismiss controller: UIViewController) {
		
		controller.dismiss(animated: true, completion: nil)
		
	}
	
	public func settingsDisplayViewController(avatarImageChanged sender: UIViewController) {
		
		self.dashboardBarView.set(displayAvatarYN: true)
		
	}
	
}


// MARK: - Extension ProtocolPlayAreaViewDelegate

extension MainDisplayViewController: ProtocolPlayAreaViewDelegate {
	
	// MARK: - Public Methods
	
	public func playAreaView(scrollingBegan sender: PlayAreaView) {
		
		self.cancelTransientViews()
		
	}
	
	public func playAreaView(touchesBegan sender: PlayAreaView, on view: UIView?) {
		
//		let cellView: 		ProtocolGridCellView? = view as? ProtocolGridCellView
		let tileView: 		ProtocolGridTileView? = view as? ProtocolGridTileView
		let tokenView: 		ProtocolGridTokenView? = view as? ProtocolGridTokenView
//		let tappedGridYN: 	Bool = (cellView == nil && tileView == nil && tokenView == nil)
		
		
		// Check playAreaGridTileMenuViewIsShownYN
		if (self.playAreaGridTileMenuViewIsShownYN) {
			
			var hideMenuYN: Bool = true
			
			// check tileView
			if (tileView != nil) {
				
				// Get tileWrapper
				let tw: PlayAreaTileWrapper = tileView!.tileWrapper as! PlayAreaTileWrapper
				
				if (self.playAreaGridTileMenuView.tileWrapper != nil && self.playAreaGridTileMenuView.tileWrapper!.id == tw.id) { hideMenuYN = false }
				
			}
			
			if (hideMenuYN) { self.hidePlayAreaGridTileMenuView() }
			
		}
		
		// Check playAreaGridTokenMenuViewIsShownYN
		if (self.playAreaGridTokenMenuViewIsShownYN) {
			
			var hideMenuYN: Bool = true
			
			// check tokenView
			if (tokenView != nil) {
				
				// Get tokenWrapper
				let tw: PlayAreaTokenWrapper = tokenView!.tokenWrapper as! PlayAreaTokenWrapper
				
				if (self.playAreaGridTokenMenuView.tokenWrapper != nil && self.playAreaGridTokenMenuView.tokenWrapper!.id == tw.id) { hideMenuYN = false }
				
			}
			
			if (hideMenuYN) { self.hidePlayAreaGridTokenMenuView() }
			
		}
		
		// Check playAreaPathMenuViewIsShownYN
		if (self.playAreaPathMenuViewIsShownYN) {
			
			self.hidePlayAreaPathMenuView()
			self.disengagePlayAreaPathAbilities()
			
//			if (tappedGridYN) {
//
//				self.hidePlayAreaPathMenuView()
//
//			}
			
		}
		
	}
	
	public 	func playAreaView(tapped tileView: ProtocolGridTileView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint) {
	
		guard (!self.playAreaGridTileMenuViewIsShownYN) else { return }
		
		// Get playAreaTileWrapper
		let playAreaTileWrapper: 			PlayAreaTileWrapper = tileView.tileWrapper as! PlayAreaTileWrapper

		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: 			PlayAreaTokenWrapper? = PlayWrapper.current!.playAreaTokens!.values.first
		
		// Get engaged PlayAreaPathAbilityWrapper
		let playAreaPathAbilityWrapper: 	PlayAreaPathAbilityWrapper? = self.controlManager!.getEngagedPlayAreaPathAbilityWrapper(for: playAreaTokenWrapper!)
		
		if (playAreaPathAbilityWrapper != nil) {
			
			// Present playAreaPath
			self.presentPlayAreaPath(for: playAreaTokenWrapper!, afterTapped: cellView.gridCellProperties!.cellCoord!, at: indicatedPoint, withEngaged: playAreaPathAbilityWrapper!)
			
			return
			
		}
		
		// Present playMoves
		self.presentPlayMoves(for: playAreaTileWrapper, afterTapped: cellView.gridCellProperties!.cellCoord!, at: indicatedPoint)
		
	}

	public 	func playAreaView(tapped tokenView: ProtocolGridTokenView, cellView: ProtocolGridCellView, at indicatedPoint: CGPoint) {
		
		guard (!self.playAreaGridTokenMenuViewIsShownYN) else { return }
		
		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: 			PlayAreaTokenWrapper? = PlayWrapper.current!.playAreaTokens!.values.first
		
		// Get engaged PlayAreaPathAbilityWrapper
		let playAreaPathAbilityWrapper: 	PlayAreaPathAbilityWrapper? = self.controlManager!.getEngagedPlayAreaPathAbilityWrapper(for: playAreaTokenWrapper!)
		
		if (playAreaPathAbilityWrapper != nil) {
			
			if (self.playAreaPathMenuViewIsShownYN) {
				
				self.hidePlayAreaPathMenuView()
				
			}
			
			return
			
		}
		
		// Present playMoves
		self.presentPlayMoves(for: playAreaTokenWrapper!, afterTapped: cellView.gridCellProperties!.cellCoord!, at: indicatedPoint)

	}

	public 	func playAreaView(tapped cellView: ProtocolGridCellView, at indicatedPoint: CGPoint) {
		
		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: 			PlayAreaTokenWrapper? = PlayWrapper.current!.playAreaTokens!.values.first
		
		guard (playAreaTokenWrapper != nil) else { return }
		
		// Get engaged PlayAreaPathAbilityWrapper
		let playAreaPathAbilityWrapper: 	PlayAreaPathAbilityWrapper? = self.controlManager!.getEngagedPlayAreaPathAbilityWrapper(for: playAreaTokenWrapper!)
		
		guard (playAreaPathAbilityWrapper != nil) else { return }
		
		if (playAreaPathAbilityWrapper != nil) {
			
			// Present playAreaPath
			self.presentPlayAreaPath(for: playAreaTokenWrapper!, afterTapped: cellView.gridCellProperties!.cellCoord!, at: indicatedPoint, withEngaged: playAreaPathAbilityWrapper!)
			
			return
			
		}
	
	}

}


// MARK: - Extension ProtocolPlayControlBarViewDelegate

extension MainDisplayViewController: ProtocolPlayControlBarViewDelegate {

	// Public Methods
	
	public func playControlBarView(touchesBegan sender: PlayControlBarView) {
		
		self.cancelTransientViews()
		
	}
	
	public func playControlBarView(playAreaPathAbilityTapped playAreaPathAbilityWrapper: PlayAreaPathAbilityWrapper) {
		
		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: PlayAreaTokenWrapper? = PlayWrapper.current!.playAreaTokens!.values.first
		
		guard (playAreaTokenWrapper != nil) else { return }
		
		self.controlManager!.setPlayAreaPathAbility(for: playAreaTokenWrapper!, playAreaPathAbilityType: playAreaPathAbilityWrapper.playAreaPathAbilityType.type, isEngagedYN: playAreaPathAbilityWrapper.isEngagedYN, isGoingYN: playAreaPathAbilityWrapper.isGoingYN)
		
	}
	
}


// MARK: - Extension ProtocolPlayExperienceContainerViewDelegate

extension MainDisplayViewController: ProtocolPlayExperienceContainerViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceContainerView(startExperienceFor playMoveWrapper: PlayMoveWrapper, delegate: ProtocolPlayExperienceViewDelegate, responseCompletionHandler: @escaping (MoveAlongPathResponseTypes, Error?) -> Void) {
		
		// Create completion handler
		let loadPlayExperienceCompletionHandler: (([String: Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}
			
			// Get playExperienceWrappers
			let playExperienceWrappers: 	[PlayExperienceWrapper]? = wrappers!["PlayExperiences"] as? [PlayExperienceWrapper]
			
			let wrapper: 					PlayExperienceWrapper? = playExperienceWrappers?.first
			
			if (wrapper != nil) {
			
				// Nb: When a PlayExperience is loaded for the PlayMove we want the token to suspend moving along the path
				
				// Call the completion handler
				responseCompletionHandler(.Suspend, nil)
				
				self.cancelTransientViews()
				
				// Check playReferenceType; PlayAreaPath, PlayAreaPathPoint
				if (playMoveWrapper.playReferenceType != .PlayAreaPath && playMoveWrapper.playReferenceType != .PlayAreaPathPoint) {
					
					self.disengagePlayAreaPathAbilities()
					
				}
				
				// Set playMoveWrapper in the PlayExperienceWrapper
				wrapper!.set(playMoveWrapper: playMoveWrapper)
				
				// Display PlayExperience
				self.controlManager!.displayPlayExperience(wrapper: wrapper!, delegate: delegate)
				
			} else {
				
				// Nb: When no PlayExperience is loaded for the PlayMove we want the token to continue moving along the path
				
				// Call the completion handler
				responseCompletionHandler(.Continue, nil)
				
			}
			
		}
		
		// Load PlayExperience
		self.controlManager!.loadPlayExperience(forPlayMove: playMoveWrapper, oncomplete: loadPlayExperienceCompletionHandler)
		
	}

}


// MARK: - Extension ProtocolPlayExperienceDelegate

extension MainDisplayViewController: ProtocolPlayExperienceViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceView(closeButtonTapped sender: ProtocolPlayExperienceView) {
		
		// Create completion handler
		let onConfirmCompletionHandler: ((UIAlertAction?) -> Void) =
		{
			(action) -> Void in
			
			self.hidePlayExperienceView()
			
		}
		
		// Get PlayExperienceWrapper
		let pew: PlayExperienceWrapper? = sender.playExperienceWrapper
		
		// Check isCompleteYN
		if (!(pew?.isCompleteYN ?? false)) {
			
			// Confirm close
			self.presentConfirmClosePlayExperienceAlert(onconfirm: onConfirmCompletionHandler)
			
		} else {
			
			self.hidePlayExperienceView()
			
		}

	}

	public func playExperienceView(playExperienceCompleted wrapper: PlayExperienceWrapper, sender: ProtocolPlayExperienceView) {
		
		// Create completion handler
		let doAfterPlayExperienceCompletedCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			// Not required
			
		}
		
		self.controlManager!.doAfterPlayExperienceCompleted(wrapper: wrapper, oncomplete: doAfterPlayExperienceCompletedCompletionHandler)
		
		// Display playGameData
		self.playResultsView.displayPlayGameData(playGameWrapper: self.controlManager!.playGameWrapper!)
		
		let pm: PlayMoveWrapper = wrapper.playMove!
		
		// Check playReferenceType; PlayAreaPath, PlayAreaPathPoint
		if (pm.playReferenceType == .PlayAreaPath || pm.playReferenceType == .PlayAreaPathPoint) {
			
			// Resume moving along playAreaPath
			self.resumePlayAreaPath(afterPlayExperienceCompleted: wrapper)
			
		}
		
	}
	
	public func playExperienceView(presentPlayExperienceStepViewFor playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceView, delegate: ProtocolPlayExperienceStepViewDelegate) {
		
		// Create completion handler
		let loadPlayExperienceStepCompletionHandler: (([String: Any]?, Error?) -> Void) =
		{
			(wrappers, error) -> Void in
			
			guard (wrappers != nil && error == nil) else {
				
				self.presentOperationFailedAlert()
				
				return
				
			}

			// Display PlayExperienceStep
			self.controlManager!.displayPlayExperienceStep(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper, delegate: delegate)
			
		}
		
		// Load PlayExperienceStep
		self.controlManager!.loadPlayExperienceStep(for: playExperienceStepWrapper.id, oncomplete: loadPlayExperienceStepCompletionHandler)
		
	}
	
	public func playExperienceView(playExperienceStepCompleted wrapper: PlayExperienceStepWrapper, sender: ProtocolPlayExperienceView, oncomplete completionHandler:@escaping (Error?) -> Void, onuicomplete uiCompletionHandler:@escaping (Error?) -> Void) {
		
		// Get playExperienceWrapper
		let playExperienceWrapper: 				PlayExperienceWrapper = sender.playExperienceWrapper!
		var playExperienceWrappers: 			[PlayExperienceWrapper]? = nil
		
		var playChallengeObjectiveWrappers: 	[PlayChallengeObjectiveWrapper] = [PlayChallengeObjectiveWrapper]()
		
		// Check PlayChallengeObjectives completed by playExperienceStep
		playChallengeObjectiveWrappers.append(contentsOf: self.controlManager!.checkPlayChallengeObjectivesCompleted(by: wrapper) ?? [PlayChallengeObjectiveWrapper]())

		// Check playExperienceWrapper isCompleteYN
		if (playExperienceWrapper.isCompleteYN) {
			
			playExperienceWrappers 				= [playExperienceWrapper]
			
			// Check PlayChallengeObjectives completed by playExperience
			playChallengeObjectiveWrappers.append(contentsOf: self.controlManager!.checkPlayChallengeObjectivesCompleted(by: playExperienceWrapper) ?? [PlayChallengeObjectiveWrapper]())
			
		}
		
		// Check completed PlayChallenge
		let playChallengeWrappers: 				[PlayChallengeWrapper]? = self.controlManager!.checkPlayChallengesCompleted()

		// Create completion handler
		let presentSequencedViewsCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in

			// Call completion handler
			uiCompletionHandler(error)
			
		}

		// hide playExperienceStepView
		self.hidePlayExperienceStepView()
		
		// Present sequenced views
		self.presentSequencedViews(playExperienceWrappers: playExperienceWrappers, playExperienceStepWrappers: [wrapper], playChallengeObjectiveWrappers: playChallengeObjectiveWrappers, playChallengeWrappers: playChallengeWrappers, oncomplete: presentSequencedViewsCompletionHandler)
		
		// Create completion handler
		let doProcessCompletedPlayChallengesCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			// Display playGameData
			self.playResultsView.displayPlayGameData(playGameWrapper: self.controlManager!.playGameWrapper!)
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Process playChallenges
		self.doProcessCompletedPlayChallenges(playChallengeWrappers: playChallengeWrappers, playChallengeObjectiveWrappers: playChallengeObjectiveWrappers, oncomplete: doProcessCompletedPlayChallengesCompletionHandler)
		
	}
	
	public func playExperienceView(playExperienceStepViewCloseButtonTapped sender: ProtocolPlayExperienceStepView) {
		
		// Create completion handler
		let onConfirmCompletionHandler: ((UIAlertAction?) -> Void) =
		{
			(action) -> Void in

			// Confirm close
			self.hidePlayExperienceStepView()
			
		}

		// Confirm close
		self.presentConfirmClosePlayExperienceStepAlert(onconfirm: onConfirmCompletionHandler)
		
	}
	
	
	// MARK: - Private Methods
	
	fileprivate func doProcessCompletedPlayChallenges(playChallengeWrappers: [PlayChallengeWrapper]?, playChallengeObjectiveWrappers: [PlayChallengeObjectiveWrapper]?, oncomplete completionHandler:@escaping (Error?) -> Void) {
		
		// Create completion handler
		let doAfterPlayChallengesCompletedCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			// Call completion handler
			completionHandler(error)
			
		}
		
		// Create completion handler
		let doAfterPlayChallengeObjectivesCompletedCompletionHandler: ((Error?) -> Void) =
		{
			(error) -> Void in	//[unowned self]
			
			guard (error == nil) else {
				
				// Call completion handler
				completionHandler(error)
				
				return
				
			}
			
			if (playChallengeWrappers != nil && playChallengeWrappers!.count > 0) {
				
				self.controlManager!.doAfterPlayChallengesCompleted(playChallengeWrappers: playChallengeWrappers!, oncomplete: doAfterPlayChallengesCompletedCompletionHandler)
				
			} else {
				
				// Call completion handler
				completionHandler(nil)
				
			}
			
		}
		
		if (playChallengeObjectiveWrappers != nil && playChallengeObjectiveWrappers!.count > 0) {
			
			// Go through each item
			for pcow in playChallengeObjectiveWrappers! {
			
				// Update playActiveChallengeView
				self.playActiveChallengeView.doAfterPlayChallengeObjectiveCompleted(playChallengeObjectiveWrapper: pcow)
				
			}

			self.controlManager!.doAfterPlayChallengeObjectivesCompleted(playChallengeObjectiveWrappers: playChallengeObjectiveWrappers!, oncomplete: doAfterPlayChallengeObjectivesCompletedCompletionHandler)
			
		} else if (playChallengeWrappers != nil && playChallengeWrappers!.count > 0) {
			
			// Clear playActiveChallengeView
			self.playActiveChallengeView.clearPlayActiveChallenge()
			
			self.controlManager!.doAfterPlayChallengesCompleted(playChallengeWrappers: playChallengeWrappers!, oncomplete: doAfterPlayChallengesCompletedCompletionHandler)
			
		} else {
			
			// Call completion handler
			completionHandler(nil)
			
		}
		
	}

}


// MARK: - Extension ProtocolPlayExperienceStepCompleteViewDelegate

extension MainDisplayViewController: ProtocolPlayExperienceStepCompleteViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceStepCompleteView(sender: ProtocolPlayExperienceStepCompleteView, closeButtonTapped wrapper: PlayExperienceStepWrapper, oncomplete completionhandler: ((Error?) -> Void)?) {
	
		self.hidePlayExperienceStepCompleteView(view: sender, oncomplete: completionhandler)
		
	}
	
}


// MARK: - Extension ProtocolPlayExperienceCompleteViewDelegate

extension MainDisplayViewController: ProtocolPlayExperienceCompleteViewDelegate {
	
	// MARK: - Public Methods
	
	public func playExperienceCompleteView(sender: ProtocolPlayExperienceCompleteView, closeButtonTapped wrapper: PlayExperienceWrapper, oncomplete completionhandler: ((Error?) -> Void)?) {
		
		self.hidePlayExperienceCompleteView(view: sender, oncomplete: completionhandler)
		
	}
	
}


// MARK: - Extension ProtocolPlayChallengeObjectiveCompleteViewDelegate

extension MainDisplayViewController: ProtocolPlayChallengeObjectiveCompleteViewDelegate {
	
	// MARK: - Public Methods
	
	public func playChallengeObjectiveCompleteView(sender: ProtocolPlayChallengeObjectiveCompleteView, closeButtonTapped wrapper: PlayChallengeObjectiveWrapper, oncomplete completionhandler: ((Error?) -> Void)?) {
		
		self.hidePlayChallengeObjectiveCompleteView(view: sender, oncomplete: completionhandler)
		
	}
	
}


// MARK: - Extension ProtocolPlayChallengeCompleteViewDelegate

extension MainDisplayViewController: ProtocolPlayChallengeCompleteViewDelegate {
	
	// MARK: - Public Methods
	
	public func playChallengeCompleteView(sender: ProtocolPlayChallengeCompleteView, closeButtonTapped wrapper: PlayChallengeWrapper, oncomplete completionhandler: ((Error?) -> Void)?) {
		
		self.hidePlayChallengeCompleteView(view: sender, oncomplete: completionhandler)
		
	}
	
}


// MARK: - Extension ProtocolPlayDeckViewDelegate

extension MainDisplayViewController: ProtocolPlayDeckViewDelegate {

	// Public Methods

	public func playDeckView(touchesBegan sender: PlayDeckView) {
		
		self.cancelTransientViews()
		self.disengagePlayAreaPathAbilities()
		
	}
		
	public func playDeckView(swapCellButtonTapped sender: PlayDeckView) {
		
		self.doAddCellToPlayDeckView()
		
	}

	public func playDeckView(swapTileButtonTapped sender: PlayDeckView) {
		
		self.doAddTileToPlayDeckView()
		
	}
	
	public func playDeckView(toGridScapeManager sender: PlayDeckView) -> GridScapeManager {
		
		return self.playAreaView.gridScapeManager!
		
	}
	
	public func playDeckView(sender: PlayDeckView, didDrop cellView: ProtocolGridCellView) {
		
		self.doAddCellToPlayDeckView()
		
	}

	public func playDeckView(sender: PlayDeckView, didDrop tileView: ProtocolGridTileView) {
		
		self.doAddTileToPlayDeckView()
		
	}
	
}


// MARK: - Extension ProtocolPlayActiveChallengeViewDelegate

extension MainDisplayViewController: ProtocolPlayActiveChallengeViewDelegate {
	
	// Public Methods
	
	public func playActiveChallengeView(touchesBegan sender: PlayActiveChallengeView) {

		self.cancelTransientViews()
		self.disengagePlayAreaPathAbilities()
		
	}
	
	public func playActiveChallengeView(willDismiss sender: PlayActiveChallengeView) {

	}

	public func playActiveChallengeView(didDismiss sender: PlayActiveChallengeView) {

		self.playActiveChallengeViewIsShownYN = false

	}
	
}


// MARK: - Extension ProtocolPlayAreaGridTileMenuViewDelegate

extension MainDisplayViewController: ProtocolPlayAreaGridTileMenuViewDelegate {
	
	// Public Methods
	
}


// MARK: - Extension ProtocolPlayAreaGridTokenMenuViewDelegate

extension MainDisplayViewController: ProtocolPlayAreaGridTokenMenuViewDelegate {
	
	// Public Methods
	
	public func playAreaGridTokenMenuView(tapped playMoveWrapper: PlayMoveWrapper, sender: PlayAreaGridTokenMenuView) {
		
		if (playMoveWrapper.playChallenge != nil) {
			
			// Create completion handler
			let setPlayActiveChallengeCompletionHandler: ((Error?) -> Void) =
			{
				(error) -> Void in

				self.hidePlayAreaGridTokenMenuView()
				
			}
			
			// Set active PlayChallenge
			self.controlManager!.setPlayActiveChallenge(playChallengeWrapper: playMoveWrapper.playChallenge!, oncomplete: setPlayActiveChallengeCompletionHandler)

		}
		
	}
	
}


// MARK: - Extension ProtocolPlayAreaPathMenuViewDelegate

extension MainDisplayViewController: ProtocolPlayAreaPathMenuViewDelegate {
	
	// Public Methods
	
	public func playAreaPathMenuView(goButtonTapped sender: PlayAreaPathMenuView) {
		
		self.hidePlayAreaPathMenuView()
		
		// Get playAreaTokenWrapper
		let playAreaTokenWrapper: 	PlayAreaTokenWrapper = PlayWrapper.current!.playAreaTokens!.values.first!
		
		// Move
		self.doMovePlayAreaTokenAlongPlayAreaPath(playAreaTokenWrapper: playAreaTokenWrapper, playAreaPathWrapper: sender.playAreaPathWrapper!)
		
	}
	
}


// MARK: - Extension ProtocolGamesViewDelegate

extension MainDisplayViewController: ProtocolPlayGamesViewDelegate {
	
	// MARK: - Public Methods
	
	public func playGamesView(isNotConnected error: Error?) {
		
		self.presentIsNotConnectedAlert()
		
	}
	
	public func playGamesView(operationFailed error: Error?) {
		
		self.presentOperationFailedAlert()
		
	}

	public func playGamesView(presentPlayGameEditView sender: ProtocolPlayGamesView, for wrapper: PlayGameWrapper) {
		
		// Set in playGameEditView
		self.playGameEditView.set(wrapper: wrapper)
		
		// Present playGameEditView
		self.presentPlayGameEditView()

	}
	
	public func playGamesView(sender: ProtocolPlayGamesView, playGameSelected wrapper: PlayGameWrapper) {

		// Set dashboardBarView
		self.dashboardBarView.set(dashboardBarTabItem: .playArea, animateYN: false)
		
		// Present playAreaView
		self.presentPlayAreaView()
		
		if (wrapper.id != self.controlManager!.playGameWrapper!.id) {
			
			// Load selected playGame
			self.loadSelectedPlayGame(wrapper: wrapper)
			
		}

	}
	
	public func playGamesView(sender: ProtocolPlayGamesView, playGameDeleted wrapper: PlayGameWrapper, activePlayGame: PlayGameWrapper) {
	
		// Check playGameWrapper
		if (activePlayGame.id != self.controlManager!.playGameWrapper!.id) {
			
			// Load selected playGame
			self.loadSelectedPlayGame(wrapper: activePlayGame)
			
		}
		
	}

}


// MARK: - Extension ProtocolPlayGameEditViewDelegate

extension MainDisplayViewController: ProtocolPlayGameEditViewDelegate {
	
	// MARK: - Public Methods
	
	public func playGameEditView(sender: ProtocolPlayGameEditView, backButtonTapped wrapper: PlayGameWrapper) {
		
		self.hidePlayGameEditView()
		
	}
	
	public func playGameEditView(sender: ProtocolPlayGameEditView, doneButtonTapped wrapper: PlayGameWrapper) {

		self.hidePlayGameEditView()
		
		// Set in playGamesView
		self.playGamesView.doAfterEdit(wrapper: wrapper)
		
	}

	public func playGameEditView(sender: ProtocolPlayGameEditView, willSelectLanguage wrapper: PlayGameWrapper, source: UIView) {
	
		self.displayLanguagePopover(sender: source)
		
	}
	
}


// MARK: - Extension UIPopoverPresentationControllerDelegate

extension MainDisplayViewController: UIPopoverPresentationControllerDelegate {

	// MARK: - Public Methods

	public func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
		
		return .none
		
	}
}


// MARK: - Extension ProtocolLanguagePopoverViewViewControllerDelegate

extension MainDisplayViewController: ProtocolLanguagePopoverViewViewControllerDelegate {
	
	// MARK: - Public Methods
	
	public 	func languagePopoverViewViewController(sender: LanguagePopoverViewViewController, languageSelected languageID: String) {
		
		(sender as UIViewController).dismiss(animated: true, completion: nil)
		
		self.playGameEditView.set(languageID: languageID)
		
	}

}

