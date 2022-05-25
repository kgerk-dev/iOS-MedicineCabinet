//
//  EditMedicineDetailView.swift
//  iOS-MedicineCabinet
//
//

import SwiftUI

struct EditMedicineDetailView: View {
	
	@Environment(\.managedObjectContext) var managedObjectContext
	@Environment(\.dismiss) var dismiss
	
	var medicine: FetchedResults<Medicine>.Element
	
	@State private var brandName = ""
	@State private var dosageForm = ""
	@State private var strength = ""
	@State private var frequency = ""
	@State private var pillsRemaining = 0
	@State private var totalPillsInRefill = 0
	
	var dosageFormList = ["mg", "g", "unit(s)", "piece(s)", "capsule(s)", "pill(s)", "drop(s)"]
	var frequencyList = ["As Needed", "EveryDay", "Other"]
	
	@State private var newDosage = ""
	@State private var newFrequency = ""
	@State private var otherFrequency = ""
	
	let formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter
	}()
	
	var body: some View {
		Form {
			Section {
				TextField("\(medicine.name!)", text: $brandName)
					.font(.headline)
					.onAppear {
						brandName = medicine.name!
						dosageForm = medicine.form!
						strength = medicine.strength!
						frequency = medicine.frequency!
					}
				HStack {
					Picker("Dosage Form ", selection: $dosageForm){
						ForEach(dosageFormList, id: \.self) {
							Text($0)
						}
					}
					Text("Dosage \(dosageForm)")
				}
				HStack {
					Text("Strength ")
					TextField("\(strength) \(dosageForm)", value: $strength, formatter: formatter)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.padding()
					Text("\(dosageForm)")
				}
				
				VStack {
					Picker("Frequency: \(frequency)", selection: $newFrequency){
						ForEach(frequencyList, id: \.self) {
							Text($0)
						}
					}
				}
				
				VStack {
					VStack {
						if frequency == "Other" {
							Text("Enter Frequency Amount")
							TextField("New Amount ",text: $otherFrequency)
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
				HStack {
					Spacer()
					Button("Submit") {
						if newFrequency == "" {
							ModelController().editMedicine(medicine: medicine,
														   name: brandName,
														   strength: String(strength),
														   form: dosageForm,
														   frequency: frequency,
														   pillsRemaining: Int16(pillsRemaining),
														   totalPillsInRefill: Int16(totalPillsInRefill),
														   context: managedObjectContext)
							dismiss()
						}
					}
					Spacer()
				}
			}
		}
    }
}

