//
//  AppDelegate.swift
//  f30
//
//  Created by David on 17/10/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import CoreData
import Firebase
import TwitterKit
import FBSDKCoreKit
import SFSecurity
import SFSocial
import SFCore
import SFNet
import f30Model
import f30Controller

@UIApplicationMain
class AppDelegate: UIResponder {

	// MARK: - Private Stored Properties
	
	fileprivate var controlManager: AppDelegateControlManager?
	
	
	// MARK: - Internal Stored Properties
	
	var window: UIWindow?

	lazy var persistentContainer: NSPersistentContainer = {
		/*
		The persistent container for the application. This implementation
		creates and returns a container, having loaded the store for the
		application to it. This property is optional since there are legitimate
		error conditions that could cause the creation of the store to fail.
		*/
		let container = NSPersistentContainer(name: "f30")
		container.loadPersistentStores(completionHandler: { (storeDescription, error) in
			if let error = error as NSError? {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				
				/*
				Typical reasons for an error here include:
				* The parent directory does not exist, cannot be created, or disallows writing.
				* The persistent store is not accessible, due to permissions or data protection when the device is locked.
				* The device is out of space.
				* The store could not be migrated to the current model version.
				Check the error message to determine what the actual problem was.
				*/
				fatalError("Unresolved error \(error), \(error.userInfo)")
			}
		})
		return container
	}()

	
	// MARK: - Private Methods
	
	fileprivate func setup() {
		
		self.setApplicationVariables()
		
		self.setupControlManager()
		self.setupModelManager()

		self.setDebugFlags()
	}
	
	fileprivate func setupControlManager() {
		
		// Setup the control manager
		self.controlManager 				= AppDelegateControlManager()
		
		self.controlManager!.baseDelegate 	= ControlManagerBaseDelegate()
		
		// Setup authentication
		self.setupAuthenticationManager()
		self.controlManager!.setupAuthentication()
		
		// Setup social
		self.setupSocial()
		self.controlManager!.setupSocial()
		
		// Setup cacheing
		self.controlManager!.setupCacheing(managedObjectContext: CoreDataHelper.getManagedObjectContext())
		
	}
	
	fileprivate func setupModelManager() {
		
		// Set the model manager
		self.controlManager!.set(modelManager: ModelManager(storageDateFormatter: ModelFactory.storageDateFormatter))
		
		// Setup the model administrators
		ModelFactory.setupUserProfileModelAdministrator(modelManager: self.controlManager!.modelManager! as! ModelManager)
		
	}
	
	fileprivate func setupAuthenticationManager() {
		
		// Create authentication strategy
		let authenticationStrategy: ProtocolAuthenticationStrategy = FirebaseAuthenticationStrategy()
		
		// Setup the authentication manager
		AuthenticationManager.shared.set(authenticationStrategy: authenticationStrategy)
		
	}
	
	fileprivate func checkIsSignedIn() {
	
		if (!self.controlManager!.isSignedInYN()) {
			
			self.presentSignInDisplay()
			
		} else {
			
			DispatchQueue.global().async {
				
				self.controlManager!.loadUserProfile()
				
			}
			
		}
		
	}	

	fileprivate func presentSignInDisplay() {
		
		self.window = UIWindow(frame: UIScreen.main.bounds)
		
		// Get the storyboard
		let mainStoryBoard: UIStoryboard = UIStoryboard(name: "Main", bundle: nil)
		
		let signInDisplayViewController: SignInDisplayViewController = mainStoryBoard.instantiateViewController(withIdentifier: "SignInDisplay") as! SignInDisplayViewController
		
		self.window?.rootViewController = signInDisplayViewController
		
		self.window?.makeKeyAndVisible()

	}

	fileprivate func setupFirebase() {
		
		FirebaseApp.configure()
		
	}
	
	fileprivate func setupFacebookAuthentication(application: UIApplication, launchOptions: [UIApplicationLaunchOptionsKey: Any]?) {
		
		FBSDKApplicationDelegate.sharedInstance().application(application, didFinishLaunchingWithOptions: launchOptions)
		
	}
	
	fileprivate func setupTwitterAuthentication() {
		
		Twitter.sharedInstance().start(withConsumerKey:"3zUOls4e1CEAqF04YN3kfayaT", consumerSecret:"nESYLmyp7rRqxhTLCsxVQFwBIYWOkKSeK1TqSzOAxvxLSCEKKW")
		
	}
	
	fileprivate func setDebugFlags() {
		
		#if DEBUG
			
			ApplicationFlags.flag(key: "SkipCheckIsConnectedYN", value: false)
			ApplicationFlags.flag(key: "LoadRelativeMembersDummyDataYN", value: false)
			
		#endif
		
	}
	
	fileprivate func setApplicationVariables() {
	
		ApplicationVariables.set(key: "ApplicationID", value: "f30")
		
	}
	
}

// MARK: - Extension UIApplicationDelegate

extension AppDelegate: UIApplicationDelegate {
	
	// MARK: - Internal Methods
	
	func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplicationLaunchOptionsKey: Any]?) -> Bool {
		// Override point for customization after application launch.
		
		self.setupFacebookAuthentication(application: application, launchOptions: launchOptions)
		self.setupTwitterAuthentication()
		self.setupFirebase()
		
		self.setup()
		self.checkIsSignedIn()
		
		return true
	}
	
	func applicationWillResignActive(_ application: UIApplication) {
		// Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
		// Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
	}
	
	func applicationDidEnterBackground(_ application: UIApplication) {
		// Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
		// If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
		
		self.disconnectWebSockets()
		
	}
	
	func applicationWillEnterForeground(_ application: UIApplication) {
		// Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
	}
	
	func applicationDidBecomeActive(_ application: UIApplication) {
		// Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
		
		self.connectWebSockets()
		
	}
	
	func applicationWillTerminate(_ application: UIApplication) {
		// Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
		// Saves changes in the application's managed object context before the application terminates.
		self.saveContext()
		
		self.disconnectWebSockets()
		self.disposeWebSockets()
		
	}
	
	func application(_ application: UIApplication, open url: URL, sourceApplication: String?, annotation: Any) -> Bool {
		
		if url.scheme != nil && url.scheme == "fb458499674529414" {
			
			return FBSDKApplicationDelegate.sharedInstance().application(application, open: url, sourceApplication: sourceApplication, annotation: annotation)
			
		} else {
			
			return Twitter.sharedInstance().application(application, open: url, options: [:])
			
		}
		
	}
	
}

// MARK: - Extension CoreData

extension AppDelegate {

	// MARK: - Internal Methods
	
	func saveContext () {
		let context = persistentContainer.viewContext
		if context.hasChanges {
			do {
				try context.save()
			} catch {
				// Replace this implementation with code to handle the error appropriately.
				// fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
				let nserror = error as NSError
				fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
			}
		}
	}
	
}


// MARK: - Extension Social

extension AppDelegate {

	// MARK: - Private Methods
	
	fileprivate func setupSocial() {
		
		// Create the SocialModelManager
		let socialModelManager: SocialModelManager = ModelFactory.socialModelManager
		
		// Set the social model manager
		self.controlManager!.set(socialModelManager: socialModelManager)
		
		// Setup the model administrators
		ModelFactory.setupRelativeMemberModelAdministrator(modelManager: self.controlManager!.socialModelManager! as! SocialModelManager)
		
		ModelFactory.setupRelativeConnectionModelAdministrator(modelManager: self.controlManager!.socialModelManager! as! SocialModelManager)
		
		ModelFactory.setupRelativeConnectionRequestModelAdministrator(modelManager: self.controlManager!.socialModelManager! as! SocialModelManager)
		
		ModelFactory.setupRelativeInteractionModelAdministrator(modelManager: self.controlManager!.socialModelManager! as! SocialModelManager)
		
		ModelFactory.setupRelativeTimelineEventModelAdministrator(modelManager: self.controlManager!.socialModelManager! as! SocialModelManager)
		
	}
	
}


// MARK: - Extension WebSockets

extension AppDelegate {
	
	// MARK: - Private Methods
	
	fileprivate func connectWebSockets() {

//		// connectWebSockets
//		if let vc = UIApplication.shared.keyWindow?.rootViewController as? MainDisplayViewController {
//
//			vc.connectWebSockets()
//
//		}
		
	}
	
	fileprivate func disconnectWebSockets() {

//		// disconnectWebSockets
//		if let vc = UIApplication.shared.keyWindow?.rootViewController as? MainDisplayViewController {
//
//			vc.disconnectWebSockets()
//
//		}
		
	}
	
	fileprivate func disposeWebSockets() {
		
		WebSocketsClientManager.shared.dispose()
		
	}
	
}

