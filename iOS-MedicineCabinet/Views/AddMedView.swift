//
//  AddMedView.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/11/22.
//

import SwiftUI

private let lightGray = Color(red: 201/255, green: 201/255, blue: 201/255)

struct AddMedView: View {
	
	@State var results = [Products]()
	@State var searchText: String = ""
	@State var searching = false
	
	@StateObject var medicineFetcher = MedicineFetcher()
	
	let meds: [Products]
	
	var body: some View {
			Text("Hello")
	}
}

struct AddMedView_Previews: PreviewProvider {
    static var previews: some View {
		NavigationView {
			AddMedView(meds: [Products]())
		}
        
    }
}

extension UIApplication {
	func dismissKeyboard() {
		sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
	}
}

struct SearchBar: View {
	
	@Binding var searchText: String
	@Binding var searching: Bool
	
	
	var body: some View {
		ZStack {
			Rectangle()
				.foregroundColor(lightGray)
			HStack {
				Image(systemName: "magnifyingglass")
				TextField("Search ..", text: $searchText) { edit in
					if edit {
						withAnimation {
							searching = true
						}
					}
				} onCommit: {
					withAnimation {
						searching = false
					}
				}
			}
			.foregroundColor(.gray)
			.padding(.leading, 13)
		}
		.frame(height: 40)
		.cornerRadius(13)
		.padding()
	}
}


/*List(results, id: \.id) { item in
	VStack(alignment: .leading) {
		Text(item.sponsor_name)
			.font(.headline)
 
 
 
 
 AddView:
 
 VStack(alignment: .leading) {
	 SearchBar(searchText: $searchText, searching: $searching)
	 
		 
 }
 .navigationTitle(searching ? "Searching" : "Enter Medicine Name")
 .toolbar {
	 if searching {
		 Button("Cancel") {
			 searchText = ""
			 withAnimation {
				 searching = false
			 }
		 }
	 }
 }
 */
