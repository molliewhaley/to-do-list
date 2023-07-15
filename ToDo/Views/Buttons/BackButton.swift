//
//  BackButton.swift
//  ToDo
//
//  Created by Mollie Whaley on 7/8/23.
//

import SwiftUI

struct BackButton: View {
    
    @Environment(\.presentationMode) var presentationMode
    
    var body: some View {
        Button {
            presentationMode.wrappedValue.dismiss()
            
        } label: {
            Image(systemName: "chevron.left")
                .foregroundColor(.white)
                .font(.system(size: 15, weight: .bold))
        }
    }
}

struct BackButton_Previews: PreviewProvider {
    static var previews: some View {
        BackButton()
    }
}
