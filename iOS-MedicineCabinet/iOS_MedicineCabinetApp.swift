//
//  iOS_MedicineCabinetApp.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/11/22.
//

import SwiftUI

@main
struct iOS_MedicineCabinetApp: App {
	//Creates the instance of the persistance controller in the app startup.
    @State private var modelController = ModelController()

    var body: some Scene {
        WindowGroup {
			//Inject the environment into the content. This allows it to become accessible from inside any view within the application called from Content View. 
            MainView()
                .environment(\.managedObjectContext, modelController.container.viewContext)
        }
    }
}
