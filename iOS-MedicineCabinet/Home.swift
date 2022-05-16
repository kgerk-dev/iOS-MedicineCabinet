//
//  Home.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/11/22.
//

import SwiftUI

struct Home: View {
	
	@EnvironmentObject private var slideInMenu: SlideInMenu
	
    var body: some View {
		ScrollView{
			
		}
		.navigationTitle("Home")
		.toolbar {
			ToolbarItem(placement: .primaryAction) {
				Button {
					//didTapMenuButton()
				} label: {
					Image(systemName: "filemenu.and.selection")
				}
			}
		}
    }
	
	func didTapMenuButton() {
		print("didTapMenuButton")
		slideInMenu.isViewed.toggle()
	}
}

struct Home_Previews: PreviewProvider {
    static var previews: some View {
        Home()
    }
}
