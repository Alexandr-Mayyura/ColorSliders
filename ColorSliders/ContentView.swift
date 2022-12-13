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
    
    @State private var redText = 0.0
    @State private var greenText = 0.0
    @State private var blueText = 0.0
    
    @FocusState var isInputActive: NameColor?
    @FocusState private var nameInFocus: Bool
    
    @State private var isUpDown = false
    @State private var alertPresented = false
    
    var body: some View {
        ZStack {
            Color.cyan
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
                ColorTools(
                    value: $redValue,
                    textLabel: "\(lround(redValue))",
                    textTextfield: $redText,
                    colorLine: .red
                )
                    .focused($isInputActive, equals: .red)
                    .onAppear {
                        redText = redValue
                    }
                ColorTools(
                    value: $greenValue,
                    textLabel: "\(lround(greenValue))",
                    textTextfield: $greenText,
                    colorLine: .green
                )
                    .focused($isInputActive, equals: .green)
                    .onAppear {
                        greenText = greenValue
                    }
                ColorTools(
                    value: $blueValue,
                    textLabel: "\(lround(blueValue))",
                    textTextfield: $blueText,
                    colorLine: .blue
                )
                    .focused($isInputActive, equals: .blue)
                    
                    .onAppear {
                        blueText = blueValue
                    }
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
                        changedTextfield()
                        isInputActive = nil
                        nameInFocus = false
                    }
                    .alert("Wrong format", isPresented: $alertPresented, actions: {}) {
                        Text("Enter your name")
                    }
                }
            }
            .padding()
        }
    }
    
    private func changedTextfield() {
        if redText > 255 || greenText > 255 || blueText > 255 {
            alertPresented.toggle()
           return
        } else {
            switch isInputActive{
            case .red:
                redValue = redText
            case .green:
                greenValue = greenText
            default:
                blueValue = blueText
            }
        }
    }
    
    private func changedTextfieldDown(isOn: Bool) {
        if redText > 255 || greenText > 255 || blueText > 255 {
            alertPresented.toggle()
           return
        } else {
            switch (isInputActive, isOn) {
            case (.red, isOn):
                isInputActive = isOn ? .green : .blue
                redValue = redText
                
            case (.green, isOn):
                isInputActive = isOn ? .blue : .red
                greenValue = greenText
                
            default:
                isInputActive = isOn ? .red : .green
                blueValue = blueText
                
            }
        }
    }
    
//    private func changedTextfieldDown() {
//
//        if redText > 255 || greenText > 255 || blueText > 255 {
//            alertPresented.toggle()
//           return
//        }
//    }
}

struct ColorTools: View {
    @Binding var value: Double
    var textLabel: String
    @Binding var textTextfield: Double
    let colorLine: Color

    var body: some View {
        HStack {
            Text(textLabel)
                .foregroundColor(.white)
                .frame(width: 35)
            
            Slider(value: $value, in: 0...255, step: 1)
                .animation(.easeInOut, value: value)
                .accentColor(colorLine)
                .onChange(of: value) { newValue in
                    textTextfield = newValue
                }
            ColorTextfieldView(textLabel: $textTextfield)
        }
    }
}

struct ColorTextfieldView: View {
    
    @Binding var textLabel: Double

    var body: some View {
        TextField("", value: $textLabel, format: .number)
            .background(.white)
            .frame(width: 50, height: 30)
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


