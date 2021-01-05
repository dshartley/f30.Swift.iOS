//
//  CoreDataHelper.swift
//  f30
//
//  Created by David on 06/11/2017.
//  Copyright © 2017 com.smartfoundation. All rights reserved.
//

import UIKit
import CoreData

/// A helper for managing CoreData
public struct CoreDataHelper {

	// MARK: - Initializers
	
	private init () {}
	
	
	// MARK: - Public Static Methods
	
	public static func getManagedObjectContext() -> NSManagedObjectContext
	{
		// Get appDelegate
		let appDelegate:			AppDelegate				= UIApplication.shared.delegate as! AppDelegate
		
		// Get managedObjectContext
		let managedObjectContext:	NSManagedObjectContext	= appDelegate.persistentContainer.viewContext
		
		return managedObjectContext
	}
	
}
