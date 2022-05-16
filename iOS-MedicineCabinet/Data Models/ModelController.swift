//
//  ModelController.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/12/22.
//

import Foundation
import CoreData

class ModelController: ObservableObject {
	let container = NSPersistentContainer(name: "iOS_MedicineCabinet")
	
	init () {
		container.loadPersistentStores {
			desc, error in
			if let error = error {
				print("Failed to load the data \(error.localizedDescription)")
			}
		}
	}
	
	func saveData(context: NSManagedObjectContext) {
		do {
			try context.save()
			print("Data Saved!!! Woohoo")
		} catch {
			print("We could Not save the dat")
		}
	}
	
	/**
	 Model for functions to refer to objects
	 1. Id = UUID
	 2. name = STRING  -- 	 		Advil
	 3. strength = Double  -- 			200
	 4. unit = STRING -- 				mg (milligrams)
	 5. frequency = INT --       			1
	 6. dosage = String -- 			As Needed
	 7. timeOfDosage = String -- 		Morning
	 8. totalPillInRefill = Double -- 		50
	 9. pillsRemaining = Double --		50
	 10. prescribingDoctor = String --		Over The Counter (Default)
	 11. descriptionOfMedicine = String -- 	"" (Default)
	 12. dateFilled = Date -- 			05-01-2022
	 13. nextRefillDate = Date -- 		"None" (Default)
	 */
	
	func addNewMedicine(name: String,
						strength: String,
						unit: String,
						context: NSManagedObjectContext)
	{
		let newMedicine = Medicine(context: context)
		newMedicine.id = UUID()
		newMedicine.name = name
		newMedicine.strength = strength
		newMedicine.units = unit
		
		saveData(context: context)
	}
	
	func editMedicine(medicine: Medicine,
					  name: String,
					  strength: String,
					  unit: String,
					  context: NSManagedObjectContext)
	{
		medicine.name = name
		medicine.strength = strength
		medicine.units = unit
		saveData(context: context)
		
	}
}
