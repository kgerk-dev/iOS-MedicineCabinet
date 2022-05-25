//
//  ModelController.swift
//  iOS-MedicineCabinet
//
//

import Foundation
import CoreData

class ModelController: ObservableObject {
	let container = NSPersistentContainer(name: "iOS_MedicineCabinet")
	
	init () {
		container.loadPersistentStores { desc, error in
			if let error = error {
				print("Failed to load the data \(error.localizedDescription)")
			}
		}
	}
	
	func saveData(context: NSManagedObjectContext) {
		do {
			try context.save()
			print("New value stored")
		} catch {
			print("Error storing data. Data Not Stored")
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
						//units: String,
						form: String,
						frequency: String,
						pillsRemaining: Int16,
						totalPillsInRefill: Int16,
						context: NSManagedObjectContext)
	{
		let newMedicine = Medicine(context: context)
		newMedicine.id = UUID()
		newMedicine.dateCreated = Date()
		//newMedicine.units = units
		newMedicine.name = name
		newMedicine.strength = strength
		newMedicine.form = form
		newMedicine.frequency = frequency
		newMedicine.pillsRemaining = pillsRemaining
		newMedicine.totalPillsInRefill = totalPillsInRefill
		saveData(context: context)
	}
	
	func editMedicine(medicine: Medicine,
					  name: String,
					  strength: String,
					  //units: String,
					  form: String,
					  frequency: String,
					  pillsRemaining: Int16,
					  totalPillsInRefill: Int16,
					  context: NSManagedObjectContext)
	{
		medicine.name = name
		medicine.strength = strength
		medicine.dateCreated = Date()
		medicine.form = form
		medicine.frequency = frequency
		medicine.pillsRemaining = pillsRemaining
		medicine.totalPillsInRefill = totalPillsInRefill
		//medicine.units = units
		saveData(context: context)
		
	}
}
