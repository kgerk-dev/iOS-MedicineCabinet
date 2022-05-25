//
//  openFDAModel.swift
//  iOS-MedicineCabinet
//
//

import Foundation

//https://api.fda.gov/drug/drugsfda.json?search=products.brand_name:Advil
//Data class that defines the data being searched in a searchTerm API
class APIModel {
	
	private var dataTask: URLSessionDataTask? //optional
	
	
	//load medicines from API
	func loadResults(searchTerm: String, completion: @escaping(([Result]) -> Void)) {
		print("Step 1: Load Results")
		dataTask?.cancel()
		guard let url = buildUrl(forTerm: searchTerm)
		else {
			completion([])
			return
		}
		// URLSession.shared.dataTask(with: <#T##URL#>, completionHandler: <#T##(Data?, URLResponse?, Error?) -> Void#>)
		dataTask = URLSession.shared.dataTask(with: url) { data, _, _ in
			guard let data = data else {
				completion([])
				return
			}
			// JSONDecoder().decode(<#T##type: Decodable.Protocol##Decodable.Protocol#>, from: <#T##Data#>)
			if let response = try? JSONDecoder().decode(FdaJSON.self, from: data) {
				completion(response.results)
				print("JSON Decode message \(response.results)")
			}
		}
		dataTask?.resume()
	}
	
	
	//helper method to build URL based on search results
	private func buildUrl(forTerm searchTerm: String) -> URL? {
		guard !searchTerm.isEmpty
		else {
			print("Search term is empty from search bar")
			return nil
		}
		
		//URL without the searchTerm added
		let components = URLComponents(string: "https://api.fda.gov/drug/drugsfda.json?search=products.brand_name:\(searchTerm)")
		//adds the searchURL to components array
		print("Step 2: URL Request \(String(describing: components))")
		
		return components?.url
	}
}

//This is JSON object that stores the array of results
struct FdaJSON: Codable {
	let meta: Meta
	let results: [Result]
}

struct Meta: Codable {
	let disclaimer: String
	let terms, license: String
	let lastUpdated: String
	let results: Results

	enum CodingKeys: String, CodingKey {
		case disclaimer, terms, license
		case lastUpdated = "last_updated"
		case results
	}
}

struct Results: Codable {
	let skip, limit, total: Int
}

// THis project just needs Result Array
struct Result: Codable {
	let submissions: [Submission]
	let applicationNumber, sponsorName: String
	let openfda: [String: [String]]
	let products: [Product]

	enum CodingKeys: String, CodingKey {
		case submissions
		case applicationNumber = "application_number"
		case sponsorName = "sponsor_name"
		case openfda, products
	}
}
// The Product types is the nested JSON Object that we want to get the data from
// The data we need from the JSON file:
// 1. brandName: String
// 2. dosageForm: String
// 3. activeIngredients: [ActiveIngredients]
struct Product: Codable {
	let productNumber, referenceDrug, brandName: String
	let activeIngredients: [ActiveIngredient]
	let referenceStandard, dosageForm, route, marketingStatus: String

	enum CodingKeys: String, CodingKey {
		case productNumber = "product_number"
		case referenceDrug = "reference_drug"
		case brandName = "brand_name"
		case activeIngredients = "active_ingredients"
		case referenceStandard = "reference_standard"
		case dosageForm = "dosage_form"
		case route
		case marketingStatus = "marketing_status"
	}
}

// From Active Ingredients array these are hte other values we need unique to the Medicine type searched
// 1. strength: String
struct ActiveIngredient: Codable {
	let name, strength: String
}

struct Submission: Codable {
	let submissionType, submissionNumber, submissionStatus, submissionStatusDate: String
	let reviewPriority, submissionClassCode, submissionClassCodeDescription: String
	let applicationDocs: [ApplicationDoc]

	enum CodingKeys: String, CodingKey {
		case submissionType = "submission_type"
		case submissionNumber = "submission_number"
		case submissionStatus = "submission_status"
		case submissionStatusDate = "submission_status_date"
		case reviewPriority = "review_priority"
		case submissionClassCode = "submission_class_code"
		case submissionClassCodeDescription = "submission_class_code_description"
		case applicationDocs = "application_docs"
	}
}

struct ApplicationDoc: Codable {
	let id: String
	let url: String
	let date, type: String
}
