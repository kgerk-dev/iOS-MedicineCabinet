//
//  MyDatePicker.swift
//  iOS-MedicineCabinet
//
//

import SwiftUI

struct MyDatePicker: View {
	//@Binding var currentDate: Date
	
    var body: some View {
		VStack(spacing: 35) {
			
			//Navigate by Days on calendar
			let days: [String] = ["Sun", "Mon", "Tue", "Wed", "Thu", "Fri", "Sat"]
			
			
			HStack(spacing: 20) {
				VStack(alignment: .leading, spacing: 10) {
					//Displays Current Date in Title
					Text("2022").font(.caption)
						.fontWeight(.bold)
					Text("May").font(.title.bold())
					
					Spacer()
					Button{
						
					} label: {
						//allow the user to navigate betweeen months
						Image(systemName: "chevron.left").font(.title2)
					}
					Button{
						
					} label: {
						//allow the user to navigate betweeen months
						Image(systemName: "chevron.right").font(.title2)
					}
				}
				.padding(.horizontal)
			}
			
			//Display Days Below the Months
			
			HStack(spacing: 0){
				ForEach(days, id: \.self){ day in
					Text(day)
						.font(.callout)
						.fontWeight(.semibold)
						.frame(maxWidth: .infinity)
				}
			}
			
			//Dates
			
			
		}
	}
}

struct MyDatePicker_Previews: PreviewProvider {
    static var previews: some View {
		MyDatePicker()
    }
}

//Extending Date

extension Date {
	func getAllDates() ->[Date] {
		let calendar = Calendar.current
		
		let range = calendar.range(of: .day, in: .month, for: self)!

		
		//Get the current dat and its values using a haashp map
		
		return range.compactMap{ day -> Date in
			
			return calendar.date(byAdding: .day, value: day, to: self)!
			
		}
	}
}
