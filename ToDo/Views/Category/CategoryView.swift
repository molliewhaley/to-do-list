//
//  CategoryView.swift
//  ToDo
//
//  Created by Mollie Whaley on 6/24/23.
//

import SwiftUI
import CoreData
import FlexFlex

struct CategoryView: View {
    
    @ObservedObject var categoryVM = CategoryViewModel()
    @State var isPresenting = false
    @State var isEditing = false
    @State var categoryToEdit = ""
    @State var categoryName = ""
    @State var selectedColor: Color = .white
    
    var body: some View {
        NavigationStack {
            ZStack {
                Image("Gingham")
                    .resizable()
                    .edgesIgnoringSafeArea(.all)
                
                ZStack {
                    ScrollView {
                        ForEach(categoryVM.categoriesArray, id: \.id) { category in
                            CategoryRowView(categoryToEdit: $categoryToEdit, isEditing: $isEditing, isPresenting: $isPresenting, category: category, categoryVM: categoryVM)
                                .padding(.horizontal, 5)
                                .padding(.vertical, 5)
                        }
                    }
                    .padding(.top, 10)

                    VStack {
                        Spacer()
                        HStack {
                            Spacer()
                            AddButton(presentPopup: $isPresenting)
                                .padding(.horizontal)
                        }
                        .padding(.bottom, 10)
                    }
                }
                
                FlexPopup({
                    enterCategoryPopup
                }, presenting: $isPresenting, position: .center, closeOnTap: true)
                
            }
            .navigationTitle("CATEGORIES")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.customRed, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
        }
    }
    
    // Popup
    var enterCategoryPopup: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 25) {
                PopupTitle(enteredName: $categoryName, title: "NEW CATEGORY")
                                
                CategoryPopupButton(isEditing: $isEditing, isPresenting: $isPresenting, categoryName: $categoryName, categoryToEdit: categoryToEdit, categoryVM: categoryVM, selectedColor: selectedColor)
            }
            .frame(width: 275, height: 225)
        }
    }
}

struct CategoryView_Previews: PreviewProvider {
    static var previews: some View {
        CategoryView().environment(\.managedObjectContext, CoreDataManager.shared.container.viewContext)
    }
}


