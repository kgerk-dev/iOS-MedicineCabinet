//
//  ListRowView.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/11/22.
//

import SwiftUI

//Defines the List Row Details form Medicine List
struct ListRowView: View {
	
	let title: String
	
	var body: some View {
		HStack {
			Text("This is the first Line")
			Spacer()
		}
	}
}

struct ListRowView_Previews: PreviewProvider {
    static var previews: some View {
		ListRowView(title: "Title of Medicine")
    }
}
