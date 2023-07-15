//
//  AddButton.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/7/23.
//

import SwiftUI

struct AddButton: View {
    
    @Binding var presentPopup: Bool
    
    var body: some View {
        Button {
            withAnimation {
                presentPopup.toggle()
            }
            
        } label: {
            ZStack {
                Circle()
                    .foregroundColor(Color.customRed)
                    .frame(width: 70, height: 70)
                
                Image(systemName: "plus")
                    .foregroundColor(.white)
                    .font(.system(size: 35, weight: .medium))
            }
        }
    }
}

struct AddButton_Previews: PreviewProvider {
    static var previews: some View {
        AddButton(presentPopup: .constant(true))
    }
}

