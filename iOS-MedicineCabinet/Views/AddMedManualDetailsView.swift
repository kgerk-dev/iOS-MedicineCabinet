//
//  AddMedManualDetailsView.swift
//  iOS-MedicineCabinet
//
//

import SwiftUI

struct AddMedManualDetailsView: View {
	
	//Inject Database w/ Enivronment Object
	@Environment(\.managedObjectContext) var managedObjectContext
	@Environment(\.dismiss) var dismiss
	
	@State var brandName = ""
	@State var dosageForm = "mg"// mg, g, unit(s), piece(s), capsule(s), pill(s), drop(s)
	@State var totalPillsInRefill = 0
	@State var pillsRemaining = 0
	@State var strength = 0 // number formatter TextField
	@State var frequency = "" // As Needed, EveryDay, Other
	@State var otherFrequency = ""
	
	
	let formatter: NumberFormatter = {
		let formatter = NumberFormatter()
		formatter.numberStyle = .decimal
		return formatter
	}()
	
	var dosageFormList = ["mg", "g", "unit(s)", "piece(s)", "capsule(s)", "pill(s)", "drop(s)"]
	var frequencyList = ["As Needed", "EveryDay", "Other"]
	
	@State var returnHomeActive = false
	
	
    var body: some View {
		Form {
			Section {
				HStack {
					Text("Name  ")
					TextField("Enter Medicine Name", text: $brandName)
				}
				HStack {
					//Text("Dosage: ")
					Picker("Dosage Form ", selection: $dosageForm){
						ForEach(dosageFormList, id: \.self) {
							Text($0)
						}
					}
					Text("Dosage \(dosageForm)")
				}
				HStack {
					Text("Strength ")
					TextField("Enter strength in \(dosageForm)", value: $strength, formatter: formatter)
						.textFieldStyle(RoundedBorderTextFieldStyle())
						.keyboardType(.numberPad)
						.padding()
					Text("\(dosageForm)")
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
				VStack {
					HStack {
						Spacer()
						Button("Submit") {
							self.returnHomeActive = true
							
							ModelController().addNewMedicine(name: brandName,
															 strength: String(strength),
															 form: dosageForm,
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

struct AddMedManualDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedManualDetailsView()
    }
}
