//
//  MedicineFetcher.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/12/22.
//

import Foundation

class MedicineFetcher: ObservableObject {
	@Published var medicine = [Products]()
	@Published var errorMessage: String? = nil
	@Published var loading: Bool = false
	
	init() {
		
	}
	
	func fetchMedicineList() {
		
		loading = true
		
		let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?search=products.brand_name:")!
		
		let task = URLSession.shared.dataTask(with: url) {[unowned self] (data, response, error) in
			
			DispatchQueue.main.async {
				self.loading = false
			}
			
			let decoder = JSONDecoder()
			if let data = data {
				do {
					let medicines = try decoder.decode([MedicineData].self, from: data)
					print(medicines)
					DispatchQueue.main.async {
						//self.medicine = medicines
					}
					
				} catch {
					print(error)
				}
			}
		}
		task.resume()
	}
	
}




/*
 Tutorial from Hacking with Swift
 guard let url = URL(string: "https://api.fda.gov/drug/drugsfda.json?search=products.brand_name:\"Advil\"&limit=2")
 else{
	 print("Invalid URL")
	 return
 }
 
 let task = URLSession.shared.dataTask(with: url) { data, reponse, error in
	 do {
		 let breeds = try decoder.decode([Breed].self, from: data)
		 print(breeds)
	 } catch {
		 print(error)
	 }
 }
 do {
	 let(data, _) = try await URLSession.shared.data(from: url)
	 
	 if let decodedResponse = try? JSONDecoder().decode(MedicineData.self, from: data)
	 {
		 results = decodedResponse.products
	 }
 }catch {
	 print("Invalid data")
 }
 // 2. Fetch Data from the URL
 // 3. Decode the result into the Result Struct
}
 */
