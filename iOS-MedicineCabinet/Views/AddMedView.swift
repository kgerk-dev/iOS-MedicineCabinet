//
//  AddMedView.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 4/11/22.
//

import SwiftUI

//private let lightGray = Color(red: 201/255, green: 201/255, blue: 201/255)

struct AddMedView: View {
	//Use this object to provide data for list of songs
	@ObservedObject var viewModel: MedicineListViewModel
	
	var body: some View {
			VStack {
				SearchBar(searchTerm: $viewModel.searchTerm)
				
				if viewModel.medResults.isEmpty{
					EmptySearch()
					
					NavigationLink("Enter Manually", destination: AddMedManualDetailsView())
				} else {
					List(viewModel.medResults) { meds in
						NavigationLink(destination: AddMedDetailsView(meds: meds)) {
							MedSearchView(meds: meds)
						}
					}
					.listStyle(PlainListStyle())
				}
			}.navigationTitle("Medicine Search")
	}
}

struct MedSearchView: View {
	@ObservedObject var meds: MedicineResultViewModel
	
	var body: some View {
		HStack {
			VStack(alignment: .leading) {
				Text(meds.brandName ?? "")
					.font(.headline)
				HStack {
					Text(meds.route ?? "")
						.font(.footnote)
						.foregroundColor(.gray)
					Text(meds.dosageForm ?? "")
						.font(.footnote)
						.foregroundColor(.gray)
					Text(meds.strength ?? "")
						.font(.footnote)
						.foregroundColor(.gray)
				}
			}
		}
		.padding()
	}
}

struct EmptySearch: View {
	var body: some View {
		VStack {
			Spacer()
			Text("Search Medicine Name")
				.font(.title)
				.padding(.bottom)
				Spacer()
		}
		.padding()
		.foregroundColor(.blue)
	}
}

struct AddMedView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			AddMedView(viewModel: MedicineListViewModel())
		}
        
    }
}

//An attempt to dismiss the keyboard on "Search" or "Cancel" being pressed. For some reason the Emulator having software keyboard and
extension UIApplication {
	func dismissKeyboard() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

struct SearchBar: UIViewRepresentable {
	
	typealias UIViewType = UISearchBar
	@Binding var searchTerm: String
	
	func makeUIView(context: Context) -> UISearchBar {
		let searchBar = UISearchBar(frame: .zero)
		searchBar.delegate = context.coordinator
		searchBar.searchBarStyle = .minimal
		searchBar.placeholder = "Type name of medicine.."
		searchBar.showsCancelButton = true
		return searchBar
	}
	
	func updateUIView(_ uiView: UISearchBar, context: Context) {
	}
	
	func makeCoordinator() -> SearchBarCoordinator {
		return SearchBarCoordinator(searchTerm: $searchTerm)
	}
	
	class SearchBarCoordinator: NSObject, UISearchBarDelegate {
		@Binding var searchTerm: String
		
		init(searchTerm: Binding<String>) {
			self._searchTerm = searchTerm
		}
		
		func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
			searchTerm = searchBar.text ?? ""
			UIApplication.shared.windows.first { $0.isKeyWindow }?.endEditing(true)
		}
		
		func searchBarCancelButtonClicked(_ searchBar: UISearchBar){
			searchBar.text = ""
			searchTerm.removeAll()
		}
	}
}

