//
//  AddMedDetailsView.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/12/22.
//

import SwiftUI

struct AddMedDetailsView: View {
	//Inject Database w/ Enivronment Object
	@Environment(\.managedObjectContext) var managedObjectContext
	@Environment(\.dismiss) var dismiss
	
	//Local variables that will be modified and added to the DB
	@State var strength: String = ""
	@State var units: String = ""
	
	
	///Main View of page stored here
    var body: some View {
		Form {
			Section {
				Text("Text")
			}
		}
    }
}

struct AddMedDetailsView_Previews: PreviewProvider {
    static var previews: some View {
        AddMedDetailsView()
    }
}
