//
//  TextfieldView.swift
//  ColorSliders
//
//  Created by Aleksandr Mayyura on 13.12.2022.
//

import SwiftUI

struct TextfieldView: View {
    @Binding var text: String
    @Binding var value: Double
    
    @State private var showAlert = false
    
    var body: some View {
        TextField("", text: $text) { _ in
            if let value = Int(text), (0...255).contains(value) {
                self.value = Double(value)
                return
            }
            showAlert.toggle()
            text = "0"
            value = 0
        }
        .frame(width: 55, alignment: .trailing)
        .multilineTextAlignment(.trailing)
        .textFieldStyle(.roundedBorder)
        .keyboardType(.decimalPad)
        .alert("Wrong value", isPresented: $showAlert, actions: {}) {
            Text("Please enter value from 0 to 255")
        }
    }
}

struct TextfieldView_Previews: PreviewProvider {
    static var previews: some View {
        TextfieldView(text: .constant("0"), value: .constant(0))
    }
}
