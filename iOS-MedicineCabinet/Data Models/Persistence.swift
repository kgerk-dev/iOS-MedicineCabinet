//
//  Persistence.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/11/22.
//

import CoreData

struct PersistenceController {
	//Declare values dependent for Core Date
	//shared makes this the only instance in the app. All data managed in Core Data goes here
	static let shared: PersistenceController = PersistenceController()

	let container: NSPersistentContainer
	

    /*
	 static var preview: PersistenceController = {
        let result = PersistenceController(inMemory: true)
        let viewContext = result.container.viewContext
        for _ in 0..<10 {
            let newItem = Medicine(context: viewContext
          newItem.timestamp = Date()
        }
        do {
           try viewContext.save()
       } catch {
            Replace this implementation with code to handle the error appropriately.
            fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
           let nsError = error as NSError
          fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
       }
        return result
    }()
	*/

   

    init(inMemory: Bool = false) {
		//Init the container to load the persistaence stack with a name of the model. CoreData generted the model name
        container = NSPersistentContainer(name: "iOS_MedicineCabinet")
		
		
        if inMemory {
            container.persistentStoreDescriptions.first!.url = URL(fileURLWithPath: "/dev/null")
        }
        container.viewContext.automaticallyMergesChangesFromParent = true
		
		//
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.

                /*
                Typical reasons for an error here include:
                * The parent directory does not exist, cannot be created, or disallows writing.
                * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                * The device is out of space.
                * The store could not be migrated to the current model version.
                Check the error message to determine what the actual problem was.
                */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
    }
}
