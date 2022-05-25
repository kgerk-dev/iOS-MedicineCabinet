//
//  MedicineSearchViewModel.swift
//  iOS-MedicineCabinet
//
//

import Combine
import Foundation
import SwiftUI

class MedicineListViewModel: ObservableObject {
	@Published var searchTerm: String = ""
	//private(set) allows the view to see the data but not modify the contents
	@Published public private(set) var medResults: [MedicineResultViewModel] = []
	
	//loads data from api model class
	private let apiModel: APIModel = APIModel()
	
	//From Combine import class
	private var disposables = Set<AnyCancellable>()
	
	//Create class initializer
	init(){
		$searchTerm
			.sink(receiveValue: loadMedResults(searchTerm:))
			.store(in: &disposables)
	}
	
	private func loadMedResults(searchTerm: String) {
		//empty the list each time the search function runs
		medResults.removeAll()
		
		//dataModel.loadProduct(searchTerm: searchTerm, completion: <#T##(([Result]) -> Void)##(([Result]) -> Void)##([Result]) -> Void#>)
		apiModel.loadResults(searchTerm: searchTerm) { meds in
			meds.forEach {
				self.appendMeds(medResults: $0) //$0 is the object of song
			}
		}
	}
	private func appendMeds(medResults: Result) {
		let medsViewModel = MedicineResultViewModel(result: medResults)
		DispatchQueue.main.async {
			self.medResults.append(medsViewModel)
		}
	}
}

class MedicineResultViewModel: Identifiable, ObservableObject {
	//Three values that we want to load form the results to the UI
	let submissions: [Submission]
	let applicationNumber, sponsorName: String
	let openfda: [String: [String]]
	let products: [Product]
	//Product values
	var productNumber, referenceDrug, brandName: String?
	var activeIngredients: [ActiveIngredient]?
	var referenceStandard, dosageForm, route, marketingStatus: String?
	//Active Ingredients
	var name, strength: String?
	
	
	init(result: Result){
		self.submissions = result.submissions
		self.applicationNumber = result.applicationNumber
		self.sponsorName = result.sponsorName
		self.openfda = result.openfda
		//This is the only value that I need from this API
		self.products = result.products
		
		result.products.forEach{ product in
			self.brandName = product.brandName
			self.productNumber = product.productNumber
			self.referenceDrug = product.referenceDrug
			self.activeIngredients = product.activeIngredients
			self.referenceStandard = product.referenceStandard
			self.dosageForm = product.dosageForm
			self.route = product.route
			self.marketingStatus = product.marketingStatus
			
			product.activeIngredients.forEach{ ingredients in
				self.name = ingredients.name
				self.strength = ingredients.strength
			}
		}
	}
}


