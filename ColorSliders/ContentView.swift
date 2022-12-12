//
//  ContentView.swift
//  ColorSliders
//
//  Created by Aleksandr Mayyura on 11.12.2022.
//

import SwiftUI

struct ContentView: View {
    @State private var redValue = Double(Int.random(in: 0...255))
    @State private var greenValue = Double(Int.random(in: 0...255))
    @State private var blueValue = Double(Int.random(in: 0...255))
    
    @FocusState var isInputActive: NameColor?
    @State private var isUpDown = false
    
    var body: some View {
        ZStack {
            Color.blue
                .ignoresSafeArea()
            VStack(spacing: 20) {
                Rectangle()
                    .foregroundColor(Color(
                        red: redValue / 255,
                        green: greenValue / 255,
                        blue: blueValue / 255
                    ))
                    .frame(width: 350, height: 170)
                    .cornerRadius(16)
                    .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 4))
                ColorTools(value: $redValue, textLabel: "\(lround(redValue))")
                    .focused($isInputActive, equals: .red)
                ColorTools(value: $greenValue, textLabel: "\(lround(greenValue))")
                    .focused($isInputActive, equals: .green)
                ColorTools(value: $blueValue, textLabel: "\(lround(blueValue))")
                    .focused($isInputActive, equals: .blue)
                Spacer()
            }
            .keyboardType(.numberPad)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        changedTextfieldDown(isOn: !isUpDown)
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    Button {
                        changedTextfieldDown(isOn: isUpDown)
                    } label:  {
                        Image(systemName: "chevron.up")
                    }
                    Spacer()
                    Button("Done") {
                        isInputActive = nil
                    }
                }
            }
            .padding()
        }
    }
    
    private func changedTextfieldDown(isOn: Bool) {
        switch (isInputActive, isOn) {
        case (.red, isOn):
            isInputActive = isOn ? .green : .blue
        case (.green, isOn):
            isInputActive = isOn ? .blue : .red
        default:
            isInputActive = isOn ? .red : .green
        }
    }
}

struct ColorTools: View {
    @Binding var value: Double
    let textLabel: String

    var body: some View {
        HStack {
            Text(textLabel)
                .foregroundColor(.white)
                .frame(width: 35)
            Slider(value: $value, in: 0...255, step: 1)
                .animation(.easeInOut, value: value)
            ColorTextfieldView(value: $value, textLabel: textLabel)
        }
    }
}

struct ColorTextfieldView: View {
    @Binding var value: Double
    let textLabel: String

    var body: some View {
        TextField(textLabel, value: $value, format: .number)
            .frame(width: 50, height: 30)
            .background(.white)
            .cornerRadius(6)
            .textFieldStyle(.roundedBorder)
    }
}

enum NameColor {
    case red, green, blue
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}


