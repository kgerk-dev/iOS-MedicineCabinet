//
//  CalendarView.swift
//  iOS-MedicineCabinet
//
//  Created by Kyle Gerken on 5/12/22.
//

import SwiftUI

struct CalendarView: View {
	
	@State var currentDate: Date = Date()
	
	
	
    var body: some View {
		ScrollView(.vertical, showsIndicators: false) {
			VStack(spacing: 20) {
				//Call the datePicker file
				MyDatePicker()
			}
		}
    }
}

struct CalendarView_Previews: PreviewProvider {
    static var previews: some View {
        CalendarView()
    }
}
