//
//  NavMenu.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 4/11/22.
//

import SwiftUI

struct NavMenu: View {
    var body: some View {
		VStack(alignment: .leading) {
			HStack {
				Image(systemName: "text.badge.plus")
					.foregroundColor(.red)
					.imageScale(.large)
				NavigationLink("Medicine List", destination: MainView())
					.foregroundColor(.red)
					.font(.headline)
			}
			.padding(.top, 200)
			HStack {
				Image(systemName: "calendar")
					.foregroundColor(.red)
					.imageScale(.large)
				NavigationLink("Calendar Reminder", destination: CalendarView())
					.foregroundColor(.red)
					.font(.headline)
				
			}
			.padding(.top, 30)
			Spacer()
		}
		.padding()
		.frame(maxWidth: .infinity, alignment: .leading)
		.background(Color(red: 57/255, green: 57/255, blue: 57/255))
		.edgesIgnoringSafeArea(.all)
		.listStyle(SidebarListStyle())
    }
}

struct NavMenu_Previews: PreviewProvider {
    static var previews: some View {
        NavMenu()
    }
}


