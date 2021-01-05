//
//  PlayViewFactory.swift
//  f30
//
//  Created by David on 16/09/2018.
//  Copyright © 2018 com.smartfoundation. All rights reserved.
//

import UIKit
import SFGridScape
import SFGraphics
import f30Model
import f30View

/// Creates Play views
public class PlayViewFactory {
	
	// MARK: - Initializers
	
	private init() {}
	
	
	// MARK: - Public Class Methods
	
	// MARK: - PlayAreaGridCellView
	
	public class func createPlayAreaGridCellView(forPlayAreaCell playAreaCellWrapper: PlayAreaCellWrapper, with gridCellProperties: GridCellProperties, delegate: ProtocolPlayAreaGridCellViewDelegate?) -> ProtocolPlayAreaGridCellView? {
		
		// Create PlayAreaGridCellView
		let result: 				PlayAreaGridCellView = PlayAreaGridCellView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))

		// Create cellCoord
		let cellCoord: 				CellCoord = CellCoord(column: playAreaCellWrapper.column, row: playAreaCellWrapper.row)

		// Create gridCellProperties
		let gcp: 					GridCellProperties = gridCellProperties

		gcp.cellCoord 				= cellCoord
		gcp.rotationDegrees 		= playAreaCellWrapper.rotationDegrees
		gcp.canDragYN				= false
		gcp.canTapYN				= true
		gcp.canLongPressYN			= false
		
		result.gridCellProperties 	= gcp

		// cellWrapper
		result.set(cellWrapper: playAreaCellWrapper)
		
		// Check imageData
		if (playAreaCellWrapper.imageData != nil) {
			
			// Create image
			let image: 				UIImage? = UIImage(data: playAreaCellWrapper.imageData!)
			
			result.set(image: image, with: playAreaCellWrapper.imageName)
			
		}
		
		// Check tileWrapper
		if (playAreaCellWrapper.tileWrapper != nil) {
			
			// Create tileView
			let tileView: 		ProtocolPlayAreaGridTileView? = PlayViewFactory.createPlayAreaGridTileView(forPlayAreaTile: playAreaCellWrapper.tileWrapper! as! PlayAreaTileWrapper, delegate: nil)
			
			if (tileView != nil) {
			
				// Present tileView
				result.present(tileView: tileView as! ProtocolGridTileView)
				
			}
			
		}

		// Check tokenWrapper
		if (playAreaCellWrapper.tokenWrapper != nil) {
			
			// Create tokenView
			let tokenView: 		ProtocolPlayAreaGridTokenView? = PlayViewFactory.createPlayAreaGridTokenView(forPlayAreaToken: playAreaCellWrapper.tokenWrapper! as! PlayAreaTokenWrapper, delegate: nil)
			
			if (tokenView != nil) {
				
				// Present tokenView
				result.present(tokenView: tokenView as! ProtocolGridTokenView)
				
			}
			
		}
		
		return result as ProtocolPlayAreaGridCellView

	}
	

	// MARK: - PlayAreaGridTileView
	
	public class func createPlayAreaGridTileView(forPlayAreaTile playAreaTileWrapper: PlayAreaTileWrapper, delegate: ProtocolPlayAreaGridTileViewDelegate?) -> ProtocolPlayAreaGridTileView? {
		
		// Create PlayAreaGridTileView
		let result: 				PlayAreaGridTileView = PlayAreaGridTileView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		// Create cellCoord
		let cellCoord: 				CellCoord = CellCoord(column: playAreaTileWrapper.column, row: playAreaTileWrapper.row)
		
		// Create gridTileProperties
		let gtp: 					GridTileProperties = GridTileProperties(cellCoord: cellCoord)
		
		gtp.key						= playAreaTileWrapper.id
		gtp.rotationDegrees 		= playAreaTileWrapper.rotationDegrees
		gtp.canDragYN				= false
		gtp.canTapYN				= true
		gtp.canLongPressYN			= false
		gtp.position				= playAreaTileWrapper.position
		
		if (playAreaTileWrapper.tileTypeWrapper != nil) {
			
			gtp.tileWidth 			= CGFloat(playAreaTileWrapper.tileTypeWrapper!.widthPixels)
			gtp.tileHeight 			= CGFloat(playAreaTileWrapper.tileTypeWrapper!.heightPixels)
			
		}
		
		result.gridTileProperties 	= gtp
		
		// tileWrapper
		result.set(tileWrapper: playAreaTileWrapper)
		
		// Check imageData
		if (playAreaTileWrapper.imageData != nil) {
			
			// Create image
			let image: 				UIImage? = UIImage(data: playAreaTileWrapper.imageData!)
			
			result.set(image: image, with: playAreaTileWrapper.imageName)
			
		}
		
		return result as ProtocolPlayAreaGridTileView
		
	}
	
	
	// MARK: - PlayAreaGridTokenView
	
	public class func createPlayAreaGridTokenView(forPlayAreaToken playAreaTokenWrapper: PlayAreaTokenWrapper, delegate: ProtocolPlayAreaGridTokenViewDelegate?) -> ProtocolPlayAreaGridTokenView? {
		
		// Create PlayAreaGridCellView
		let result: 				PlayAreaGridTokenView = PlayAreaGridTokenView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		// Create cellCoord
		let cellCoord: 				CellCoord = CellCoord(column: playAreaTokenWrapper.column, row: playAreaTokenWrapper.row)
		
		// Create gridTokenProperties
		let gtp: 					GridTokenProperties = GridTokenProperties(cellCoord: cellCoord)

		gtp.key						= playAreaTokenWrapper.id
		gtp.canDragYN				= true
		gtp.canTapYN				= true
		gtp.canLongPressYN			= true
		
		result.gridTokenProperties 	= gtp
		
		// tokenWrapper
		result.set(tokenWrapper: playAreaTokenWrapper)
		
		// Check imageData
		if (playAreaTokenWrapper.imageData != nil) {
			
			// Create image
			let image: 				UIImage? = UIImage(data: playAreaTokenWrapper.imageData!)
			
			result.set(image: image, with: playAreaTokenWrapper.imageName)
			
		}
		
		return result as ProtocolPlayAreaGridTokenView
		
	}
	

	// MARK: - PlayExperienceView
	
	public class func createPlayExperienceView(wrapper: PlayExperienceWrapper, delegate: ProtocolPlayExperienceViewDelegate?) -> ProtocolPlayExperienceView? {
		
		var result: ProtocolPlayExperienceView? = nil
		
		if (wrapper.playExperienceType == .Basic) {
			
			result = BasicPlayExperienceView(frame: CGRect.zero)
			
			(result as! BasicPlayExperienceView).delegate = delegate
			
			if let result = result as? UIView {
				
				result.translatesAutoresizingMaskIntoConstraints = false
				
			}
			
			result!.set(playExperienceWrapper: wrapper)
			
		}
		
		return result
	}


	// MARK: - PlayExperienceStepMarkerView
	
	public class func createPlayExperienceStepMarkerView(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, delegate: ProtocolPlayExperienceStepMarkerViewDelegate?) -> ProtocolPlayExperienceStepMarkerView? {
		
		let result: PlayExperienceStepMarkerView = PlayExperienceStepMarkerView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate 												= delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 80).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 80).isActive 	= true

		result.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper)

		return result
		
	}
	
	
	// MARK: - PlayExperienceStepView
	
	public class func createPlayExperienceStepView(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepWrapper: PlayExperienceStepWrapper, delegate: ProtocolPlayExperienceStepViewDelegate?) -> ProtocolPlayExperienceStepView? {
		
		var result: 		ProtocolPlayExperienceStepView? = nil

		if (playExperienceStepWrapper.playExperienceStepType == .Basic) {
			
			// Create BasicPlayExperienceStepView
			result 			= BasicPlayExperienceStepView(frame: CGRect.zero)
			
			(result as! BasicPlayExperienceStepView).delegate 		= delegate
			
			if let result = result as? UIView {
				
				result.translatesAutoresizingMaskIntoConstraints 	= false
				
			}
			
			result!.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepWrapper: playExperienceStepWrapper)
			
		}
		
		return result
		
	}
	
	
	// MARK: - PlayExperienceStepExerciseView
	
	public class func createPlayExperienceStepExerciseView(playExperienceWrapper: PlayExperienceWrapper, playExperienceStepExerciseWrapper: PlayExperienceStepExerciseWrapper, delegate: ProtocolPlayExperienceStepExerciseViewDelegate?) -> ProtocolPlayExperienceStepExerciseView? {
		
		var result: ProtocolPlayExperienceStepExerciseView? = nil
		
		if (playExperienceStepExerciseWrapper.playExperienceStepExerciseType == .Basic) {
			
			result = BasicPlayExperienceStepExerciseView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
	
		} else if (playExperienceStepExerciseWrapper.playExperienceStepExerciseType == .MC1) {
			
			result = MC1(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
			
		} else if (playExperienceStepExerciseWrapper.playExperienceStepExerciseType == .MP1) {
			
			result = MP1(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
			
		}
		
		guard (result != nil) else { return result }
		
		// Set delegate
		result!.delegate 													= delegate
		
		// Setup view
		if let result = result as? UIView {
			
			result.translatesAutoresizingMaskIntoConstraints 				= false
			result.heightAnchor.constraint(equalToConstant: 300).isActive 	= true
			result.widthAnchor.constraint(equalToConstant: 300).isActive 	= true
			
		}
		
		result!.set(playExperienceWrapper: playExperienceWrapper, playExperienceStepExerciseWrapper: playExperienceStepExerciseWrapper)
		
		return result
		
	}
	
	
	// MARK: - Img1
	
	public class func createImg1(wrapper: Img1Wrapper, delegate: ProtocolImg1Delegate?) -> ProtocolImg1? {
		
		let result: Img1 = Img1(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate 												= delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 30).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 30).isActive 	= true
		
		// Set image
		result.set(wrapper: wrapper)
		
		return result
		
	}
	
	
	// MARK: - P1
	
	public class func createP1(wrapper: P1Wrapper, delegate: ProtocolP1Delegate?) -> ProtocolP1? {
		
		let result: P1 = P1(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate 												= delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 30).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 30).isActive 	= true
		
		// Set image
		result.set(wrapper: wrapper)
		
		return result
		
	}
	
	
	// MARK: - P1SubItem
	
	public class func createP1SubItem(wrapper: P1SubItemWrapper, delegate: ProtocolP1SubItemDelegate?) -> ProtocolP1SubItem? {
		
		let result: P1SubItem = P1SubItem(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate 												= delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 30).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 30).isActive 	= true
		
		// Set image
		result.set(wrapper: wrapper)
		
		return result
		
	}
	
	
	// MARK: - PlayExperienceStepCompleteView
	
	public class func createPlayExperienceStepCompleteView(wrapper: PlayExperienceStepWrapper, delegate: ProtocolPlayExperienceStepCompleteViewDelegate?) -> ProtocolPlayExperienceStepCompleteView? {
		
		// Create PlayExperienceStepCompleteView
		let result: PlayExperienceStepCompleteView = PlayExperienceStepCompleteView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate = delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 200).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 200).isActive 	= true
	
		return result
		
	}
	
	
	// MARK: - PlayExperienceCompleteView
	
	public class func createPlayExperienceCompleteView(wrapper: PlayExperienceWrapper, delegate: ProtocolPlayExperienceCompleteViewDelegate?) -> ProtocolPlayExperienceCompleteView? {
		
		// Create PlayExperienceCompleteView
		let result: PlayExperienceCompleteView = PlayExperienceCompleteView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate = delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 200).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 200).isActive 	= true
		
		return result
		
	}

	
	// MARK: - PlayChallengeObjectiveCompleteView
	
	public class func createPlayChallengeObjectiveCompleteView(wrapper: PlayChallengeObjectiveWrapper, delegate: ProtocolPlayChallengeObjectiveCompleteViewDelegate?) -> ProtocolPlayChallengeObjectiveCompleteView? {
		
		// Create PlayChallengeObjectiveCompleteView
		let result: PlayChallengeObjectiveCompleteView = PlayChallengeObjectiveCompleteView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate = delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 200).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 200).isActive 	= true
		
		return result
		
	}
	
	
	// MARK: - PlayChallengeCompleteView
	
	public class func createPlayChallengeCompleteView(wrapper: PlayChallengeWrapper, delegate: ProtocolPlayChallengeCompleteViewDelegate?) -> ProtocolPlayChallengeCompleteView? {
		
		// Create PlayChallengeCompleteView
		let result: PlayChallengeCompleteView = PlayChallengeCompleteView(frame: CGRect(x: 0, y: 0, width: 0, height: 0))
		
		result.delegate = delegate
		
		result.translatesAutoresizingMaskIntoConstraints 				= false
		result.heightAnchor.constraint(equalToConstant: 200).isActive 	= true
		result.widthAnchor.constraint(equalToConstant: 200).isActive 	= true
		
		return result
		
	}
	
}


