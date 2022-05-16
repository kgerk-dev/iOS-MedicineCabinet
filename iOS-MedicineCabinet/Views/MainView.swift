//
//  ContentView.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/11/22.
//

import SwiftUI
import CoreData

//Example how to use an enum within a picker.
/*
enum Priority: String, Identifiable, CaseIterable {
	var id: UUID {
		return UUID()
	}
	
	case low = "Low"
	case medium = "Medium"
	case high = "High"
	
}

extension Priority {
	
	var title: String {
		switch self {
			case .low:
				return "Low"
			case .medium:
				return "Medium"
			case .high:
				return "High"
		}
	}
}
 */


struct MainView: View {
	
	init() {
		// When Nav Bar Title is in display mode this allows the user to modify the text color.
		UINavigationBar.appearance().largeTitleTextAttributes = [.foregroundColor: UIColor.red]
	}
	
	//BoilerPlate for CoreData
	
   // @Environment(\.managedObjectContext) private var viewContext

   // @FetchRequest(
    //    sortDescriptors: [NSSortDescriptor(keyPath: \Medicine.timestamp, ascending: true)],
   //     animation: .default)
   // private var medicine: FetchedResults<Medicine>
	
	@Environment(\.managedObjectContext) var managedObjectContext
	@Environment(\.dismiss) var dismiss
	
	//Boolean to notify on press is menu is open or not
	@State private var displayMenu = false
	@State private var name = ""
	@State private var strength = ""
	@State private var unit = ""

    var body: some View {
		
		let drag = DragGesture()
		.onEnded {
			if $0.translation.width < -100 {
				withAnimation{
					self.displayMenu = false
				}
			}
		}
		
		//A Navigation View will allow Buttons to control the menu actions
		return NavigationView {
			//Geometry Reader allows the main view to bind to entire screen
			GeometryReader { geometry in
				//ZStack adapts objects on the Z-Axis (Forward and Backward or layers. Leading is in front
				ZStack(alignment: .leading) {
					//Main View is our main content view
					ListView(displayMenu: self.$displayMenu)
					//Design the Frame of the Menu since it should only cover half of the screen when open
						.frame(
							width: geometry.size.width,
							height:geometry.size.height
						)
						//While NavMenu is open, we want to disable MainMenu until Nav is closed
					
						//Standard If Statements structure differently when called in a parameter. Use tertiary conditional statements for a cleaner in-line approach, when simple.
						.offset(x: self.displayMenu ? geometry.size.width/2 : 0)
						.disabled(self.displayMenu ? true : false)
					
					
					//Declare the showMenu boolean
					if self.displayMenu {
						NavMenu()
							.frame(width: (geometry.size.width/1.5))
						//Allow for a simnplified transition
							.transition(.move(edge: .leading))
					}
				}
						.gesture(drag)
			}
			//Provide Title for Navigation bar
			.navigationBarTitle("Medicine List 💊", displayMode: .large)
			.navigationBarItems(
				leading: (
					Button(
						action: {
							withAnimation{
								self.displayMenu.toggle()
							}
						}
					) {
						//Logo for the Menu Button inspired by mt favorit App Design WorkFlow for iOS
						Image(systemName: "gear")
							.imageScale(.large)
							.foregroundColor(.red)
					}
				)
			)
			.toolbar {
				ToolbarItem(placement: .navigationBarTrailing) {
					EditButton()
				}
				ToolbarItem(placement: .navigationBarTrailing) {
					//NavigationLink("Add", destination: AddMedView(meds: [Products]))
				}
			}
			
		}
		
    }
}


/*
 Displays the content in the Main Page List of Medicine
 */
struct ListView: View {
	
	@Binding var displayMenu: Bool
	@State var medicines: [String] = [
		"This is the first Title",
		"Second",
		"Third"
	]
	
	var body: some View {
		List {
			ForEach(medicines, id: \.self) {
				medicine in ListRowView(title: medicine)
			}
		}
		.listStyle(PlainListStyle())
	
	}
}


	

//Main Page Preview for all contents in specified Order
struct MainView_Previews: PreviewProvider {
		static var previews: some View {
			
			MainView()
	}
}




	
/*
    private func addItem() {
        withAnimation {
            let newItem = Medicine(context: viewContext)
            newItem.timestamp = Date()

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }

    private func deleteItems(offsets: IndexSet) {
        withAnimation {
            offsets.map { items[$0] }.forEach(viewContext.delete)

            do {
                try viewContext.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nsError = error as NSError
                fatalError("Unresolved error \(nsError), \(nsError.userInfo)")
            }
        }
    }
}

private let itemFormatter: DateFormatter = {
    let formatter = DateFormatter()
    formatter.dateStyle = .short
    formatter.timeStyle = .medium
    return formatter
}()


*/

