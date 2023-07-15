//
//  CompletedItemsView.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/10/23.
//

import SwiftUI

struct CompletedItemsView: View {
    
    @ObservedObject var itemVM: ItemViewModel
    var category: Category
    
    var body: some View {
        Text("\(itemVM.countCompletedItems(for: category)) / \(itemVM.countItems(for: category))")
            .foregroundColor(.white)
            .font(.system(size: 16, weight: .bold))
    }
}

struct CompletedItemsView_Previews: PreviewProvider {
    static var previews: some View {
        CompletedItemsView(itemVM: ItemViewModel(category: Category()), category: Category())
    }
}
