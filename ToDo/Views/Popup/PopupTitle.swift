//
//  PopupTitle.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/9/23.
//

import SwiftUI

struct PopupTitle: View {
    
    @Binding var enteredName: String
    let title : String

    var body: some View {
        VStack {
            Text(title)
                .foregroundColor(Color.customRed)
            
            VStack {
                TextField("", text: $enteredName)
                    .font(.system(size: 18))
                    .padding(.horizontal)
                    .frame(width: 150, height: 35)
                    .background(Color.gray.opacity(0.1))
                    .cornerRadius(10)
                    .overlay(
                        Text("Enter text")
                            .foregroundColor(.gray)
                            .frame(alignment: .center)
                            .opacity(enteredName.isEmpty ? 1 : 0)
                        )
                }
            .padding(.top, 10)
        }
        .padding(.bottom, 8)
        .font(.system(size: 20, weight: .medium))
    }
}

struct ItemPopupTitleView_Previews: PreviewProvider {
    static var previews: some View {
        PopupTitle(enteredName: .constant("Entered name"), title: "Title")
    }
}
