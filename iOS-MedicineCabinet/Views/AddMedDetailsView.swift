//
//  AddMedDetailsView.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 4/12/22.
//

import SwiftUI

struct AddMedDetailsView: View {
	//Inject Database w/ Enivronment Object
	@Environment(\.managedObjectContext) var managedObjectContext
	@Environment(\.dismiss) var dismiss
	
	//Local variables that will be modified and added to the DB
	@ObservedObject var meds: MedicineResultViewModel
	
	@State var brandName = ""
	@State var dosageForm = ""
	@State var strength = ""
	
	
	@State private var frequency = ""
	@State private var totalPillsInRefill = 0
	@State private var pillsRemaining = 0
	
	var dosageFormList = ["mg", "g", "unit(s)", "piece(s)", "capsule(s)", "pill(s)", "drop(s)"]
	var frequencyList = ["As Needed", "EveryDay", "Other"]
	
	let formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter
	}()
	
	@State var returnHomeActive = false
	
	///Main View of page stored here
    var body: some View {
		Form {
			Section {
				HStack {
					Text("Name: ")
					if meds.brandName == "" {
						TextField("Enter Medicine Name: ", text: $brandName)
					}
					Text(meds.brandName ?? "")
				}
				HStack {
					Text("Dosage Form: ")
					if meds.dosageForm == "" {
						TextField("Enter Dosage Form: ", text: $dosageForm)
					}
					Text(meds.dosageForm ?? "")
				}
				HStack {
					Text("Strength: ")
					if meds.strength == "" {
						TextField("Enter Strength: ", text: $strength)
					}
					Text(meds.strength ?? "")
				}
				
				HStack {
					Picker("Frequency", selection: $frequency){
						ForEach(frequencyList, id: \.self) {
							Text($0)
						}
					}
				}
				HStack {
					VStack {
						if frequency == "Other" {
							Text("Enter Frequency Amount")
							TextField("New Amount ",text: $frequency)
						}
					}
				}
				VStack {
					HStack {
						Text("Total in Refill: ")
						TextField("Total", value: $totalPillsInRefill, formatter: formatter)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.keyboardType(.numberPad)
							.padding()
					}
				}
				VStack {
					HStack {
						Text("Pills Remaining: ")
						TextField("Total", value: $pillsRemaining, formatter: formatter)
							.textFieldStyle(RoundedBorderTextFieldStyle())
							.keyboardType(.numberPad)
							.padding()
					}
				}
				VStack {
					HStack {
						Spacer()
						Button("Submit") {
							self.returnHomeActive = true
							
							ModelController().addNewMedicine(name: meds.brandName!,
															 strength: String(meds.strength!),
															 form: meds.dosageForm!,
															 frequency: frequency,
															 pillsRemaining: Int16(pillsRemaining),
															 totalPillsInRefill: Int16(totalPillsInRefill),
															 context: managedObjectContext)
						}
						.background(
							NavigationLink(destination: MainView(), isActive: $returnHomeActive){
							}
							.hidden()
						)
						Spacer()
					}
				}
			}
		}
    }
}
