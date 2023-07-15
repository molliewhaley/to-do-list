//
//  CategoryRowView.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/7/23.
//

import SwiftUI

struct CategoryRowView: View {
    
    @Binding var categoryToEdit: String
    @Binding var isEditing: Bool
    @Binding var isPresenting: Bool
    let category: Category
    let categoryVM: CategoryViewModel
    
    var body: some View {
        
        HStack {
            Menu {
                Button("Edit", action: {
                    categoryToEdit = category.unwrappedName
                    isEditing.toggle()
                    isPresenting.toggle()
                })
                
                Button("Delete", action: {
                    categoryVM.deleteCategory(named: category)
                })
                
            } label: {
                Text(category.unwrappedName)
                    .textCase(.uppercase)
            }
            
            Spacer()
            NavigationLink(destination: ItemView(category: category)) {
                Image(systemName: "arrow.right")
            }
        }
        .foregroundColor(Color.customRed)
        .font(.system(size: 40))
        .padding(.horizontal)
        .frame(maxWidth: .infinity)
        .frame(height: 115)
        .background(Color.white)
        .cornerRadius(20)
    }
}

var previews: some View {
    CategoryRowView(categoryToEdit: .constant("Category"), isEditing: .constant(false), isPresenting: .constant(false), category: Category(), categoryVM: CategoryViewModel())
}

