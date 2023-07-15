//
//  ItemView.swift
//  ToDo
//
//  Created by Mollie Whaley on 6/24/23.
//

import SwiftUI
import CoreData
import FlexFlex

struct ItemView: View {
    
    @ObservedObject var itemVM: ItemViewModel
    @State var isPresenting = false
    @State var isEditing = false
    @State var itemToEdit = ""
    @State var itemName = ""
    @State var selectedDate = Date()
    private var category: Category
    
    init(category: Category) {
        self.category = category
        self.itemVM = ItemViewModel(category: category)
    }
    
    var body: some View {
        NavigationStack {
            ZStack {
                Color.white
                    .ignoresSafeArea()
                
                ZStack {
                    ScrollView { // section based on dates
                        ForEach(Array(itemVM.itemDict.keys).sorted(by: <), id: \.self) { date in
                            Section(header: Text(date)
                                .foregroundColor(Color.black)
                                .padding(.top)
                                .font(.system(size: 18, weight: .medium))
                            ) {
                                ForEach(itemVM.itemDict[date] ?? [], id: \.id) { item in
                                    ItemRowView(itemVM: itemVM, itemToEdit: $itemToEdit, isPresenting: $isPresenting, isEditing: $isEditing, item: item)
                                        .background(Color.white)
                                        .cornerRadius(20)
                                }
                                .padding(.vertical, 1)
                                .padding(.horizontal, 3)
                            }
                        }
                    }
                    
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
                    enterItemPopup
                }, presenting: $isPresenting, position: .center, closeOnTap: true)
                
            }
            .navigationTitle("TODO")
            .navigationBarTitleDisplayMode(.inline)
            .toolbarColorScheme(.dark, for: .navigationBar)
            .toolbarBackground(Color.customRed, for: .navigationBar)
            .toolbarBackground(.visible, for: .navigationBar)
            .navigationBarBackButtonHidden(true)
            .navigationBarItems(leading: BackButton())
            .navigationBarItems(trailing: CompletedItemsView(itemVM: itemVM, category: category))
        }
    }
    
    // popup
    var enterItemPopup: some View {
        ZStack {
            Color.white
            
            VStack(spacing: 8) {
                PopupTitle(enteredName: $itemName, title: "ADD ITEM")
                
                PopupDatePicker(selectedDate: $selectedDate)
                
                ItemPopupButton(isEditing: $isEditing, isPresenting: $isPresenting, itemName: $itemName, selectedDate: $selectedDate, itemToEdit: itemToEdit, itemVM: itemVM)
            }
            .frame(width: 275, height: 275)
        }
    }
}

struct ItemView_Previews: PreviewProvider {
    static var previews: some View {
        ItemView(category: Category())
    }
}
