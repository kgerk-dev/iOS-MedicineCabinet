//
//  Results.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/12/22.
//
import Foundation

struct MedicineData: Codable {
	let products: [Products]
}

struct Products: Codable {
	let product_number: String
	let reference_drug: String
	let brand_name: String
	let active_ingredients: [Ingredients]
	let reference_standard: String
	let doage_form: String
	let route: String
	let marketing_Status: String
	let te_code: String
}

struct Ingredients: Codable {
	let name: String
	let strength: String
}
