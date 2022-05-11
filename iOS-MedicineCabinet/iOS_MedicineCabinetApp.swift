//
//  iOS_MedicineCabinetApp.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/11/22.
//

import SwiftUI

@main
struct iOS_MedicineCabinetApp: App {
    let persistenceController = PersistenceController.shared

    var body: some Scene {
        WindowGroup {
            ContentView()
                .environment(\.managedObjectContext, persistenceController.container.viewContext)
        }
    }
}
