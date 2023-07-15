//
//  ItemRowView.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/8/23.
//

import SwiftUI

struct ItemRowView: View {
    
    @ObservedObject var itemVM: ItemViewModel
    @Binding var itemToEdit: String
    @Binding var isPresenting: Bool
    @Binding var isEditing: Bool
    var item: Item
    
    var body: some View {
        HStack {
            Button {
                DispatchQueue.main.asyncAfter(deadline: .now() + 0.09) {
                    itemVM.deleteItem(named: item)
                }
                
            } label: {
                Image(systemName: "minus.circle.fill")
            }
            
            Spacer()
            
            Menu {
                Button("Edit", action: {
                    itemToEdit = item.unwrappedName
                    isEditing.toggle()
                    isPresenting.toggle()
                    
                })} label: {
                    Text(item.unwrappedName)
                        .textCase(.uppercase)
                        .strikethrough(item.isCompleted, color: Color.white)
                }
            
            Spacer()
            
            Button {
                itemVM.changeCompletedStatus(for: item)
            } label: {
                Image(systemName: item.isCompleted ? "checkmark.circle.fill" : "circle")
            }
        }
        .foregroundColor(Color.white)
        .font(.system(size: 18, weight: .medium))
        .frame(maxWidth: .infinity)
        .frame(height: 60)
        .padding(.horizontal)
        .background(Color.customRed) 
    }
}

struct ItemRowView_Previews: PreviewProvider {
    static var previews: some View {
        ItemRowView(itemVM: ItemViewModel(category: Category()), itemToEdit: .constant("Item"), isPresenting: .constant(false), isEditing: .constant(false), item: Item())
    }
}
