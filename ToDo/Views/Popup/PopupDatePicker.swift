//
//  PopupDatePicker.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/9/23.
//

import SwiftUI

struct PopupDatePicker: View {
    
    @Binding var selectedDate: Date
    
    var body: some View {
        VStack {
            Text("DATE")
            
            DatePicker(
                "",
                selection: $selectedDate,
                displayedComponents: [.date]
            )
            .labelsHidden()
            .accentColor(.black)
            .foregroundColor(.black)
            .frame(alignment: .center)
            .cornerRadius(20)
        }
        .font(.system(size: 18, weight: .medium))
        .foregroundColor(Color.customRed)
    }
}

struct PopupDatePicker_Previews: PreviewProvider {
    static var previews: some View {
        PopupDatePicker(selectedDate: .constant(Date()))
    }
}
