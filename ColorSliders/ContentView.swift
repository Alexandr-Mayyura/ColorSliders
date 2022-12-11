//
//  ContentView.swift
//  ColorSliders
//
//  Created by Aleksandr Mayyura on 11.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue = Double.random(in: 0...255)
    @State private var greenValue = Double.random(in: 0...255)
    @State private var blueValue = Double.random(in: 0...255)
    @State private var text = "255"
    var body: some View {
        
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Rectangle()
                    .foregroundColor(Color(red: redValue/255, green: greenValue/255, blue: blueValue/255))
                    .frame(width: 350, height: 170)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 4))
                ColorTools(textLabel: "\(lround(redValue))", valueText: $text, value: $redValue)
                ColorTools(textLabel: "\(lround(greenValue))", valueText: $text, value: $greenValue)
                ColorTools(textLabel: "\(lround(blueValue))", valueText: $text, value: $blueValue)
                
                Spacer()
                
            }
            .padding()
        }
    }
}

struct ColorTools: View {
    let textLabel: String
    @Binding var valueText: String
    @Binding var value: Double
    @FocusState var isInputActive: Bool
    
    var body: some View {
        HStack {
            Text(textLabel)
                .foregroundColor(.white)
                .frame(width: 35)
            Slider(value: $value, in: 0...255, step: 1)
            TextField(textLabel, value: $value, format: .number)
                .frame(width: 50, height: 30)
                .background(.white)
                .cornerRadius(6)
                .textFieldStyle(.roundedBorder)
                .focused($isInputActive)
                .keyboardType(.numberPad)
                .toolbar {
                    ToolbarItemGroup(placement: .keyboard) {
                        Spacer()
                        Button("Done") {
                            isInputActive = false
                        }
                    }
                }
        }
    }
        
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
