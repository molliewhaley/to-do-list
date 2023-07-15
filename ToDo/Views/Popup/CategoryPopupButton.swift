//
//  CategoryPopupButton.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/14/23.
//

import SwiftUI

//  Created by Mollie Whaley on 7/8/23.
//

import SwiftUI

struct CategoryPopupButton: View {
    
    @Binding var isEditing: Bool
    @Binding var isPresenting: Bool
    @Binding var categoryName: String
    let categoryToEdit: String
    let categoryVM: CategoryViewModel
    let selectedColor: Color
    
    var body: some View {
        Button {
            if isEditing { // edit category
                categoryVM.saveChanges(for: categoryToEdit, newName: categoryName)
                isEditing.toggle()
                
            } else { // save new category
                categoryVM.addCategory(name: categoryName)
            }
    
            categoryName = ""
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
    }
}

struct CategoryPopupButton_Previews: PreviewProvider {
    static var previews: some View {
        CategoryPopupButton(isEditing: .constant(true), isPresenting: .constant(true), categoryName: .constant("Category Name"), categoryToEdit: "Category", categoryVM: CategoryViewModel(), selectedColor: Color.white)
    }
}
