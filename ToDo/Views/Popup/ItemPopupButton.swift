//
//  ItemPopupButton.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/9/23.
//

import SwiftUI

struct ItemPopupButton: View {
    
    @Binding var isEditing: Bool
    @Binding var isPresenting: Bool
    @Binding var itemName: String
    @Binding var selectedDate: Date
    let itemToEdit: String
    let itemVM: ItemViewModel
    
    var body: some View {
        Button {
            if isEditing { // edit item
                itemVM.saveChanges(for: itemToEdit, newName: itemName, newDate: selectedDate)
                isEditing.toggle()
                
            } else { // save new item 
                itemVM.addItem(name: itemName, date: selectedDate)
            }
            
            itemName = ""
            selectedDate = Date()
            isPresenting.toggle()
            UIApplication.shared.sendAction(#selector(UIResponder.resignFirstResponder), to: nil, from: nil, for: nil)
            
        } label: {
            VStack {
                Text("SAVE")
                    .foregroundColor(.white)
            }
            .frame(width: 65, height: 40)
            .font(.system(size: 18, weight: .medium))
            .background(Color.customRed)
            .cornerRadius(20)
        }
        .padding(.top) 
    }
}

struct ItemPopupButton_Previews: PreviewProvider {
    static var previews: some View {
        ItemPopupButton(isEditing: .constant(true), isPresenting: .constant(true), itemName: .constant("Item Name"), selectedDate: .constant(Date()), itemToEdit: "Item", itemVM: ItemViewModel(category: Category()))
    }
}
