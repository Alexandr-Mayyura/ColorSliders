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
    
    @FocusState var isInputActive: Bool
    @FocusState var nameColor: NameColor?
    
    @State private var alertPresented = false
    @State private var upOrDown = false
    
    var body: some View {
        ZStack {
            Color.cyan
                .ignoresSafeArea()
            VStack(spacing: 20) {
                ColorRectangleView(redColor: redValue, greenColor: greenValue, blueColor: blueValue)
                ColorToolsView(value: $redValue, colorLine: .red)
                    .focused($nameColor, equals: .red)
                ColorToolsView(value: $greenValue, colorLine: .green)
                    .focused($nameColor, equals: .green)
                ColorToolsView(value: $blueValue, colorLine: .blue)
                    .focused($nameColor, equals: .blue)
                Spacer()
            }
            .focused($isInputActive)
            .toolbar {
                ToolbarItemGroup(placement: .keyboard) {
                    Button {
                        upOrDown = true
                        checkTextfield()
                    } label: {
                        Image(systemName: "chevron.down")
                    }
                    
                    Button {
                        upOrDown = false
                        checkTextfield()
                    } label: {
                        Image(systemName: "chevron.up")
                    }

                    Spacer()
                    Button("Done") {
                        isInputActive = false
                    }
                }
            }
            .padding()
        }
    }
    
    private func checkTextfield() {
        switch (nameColor, upOrDown) {
        case (.red, upOrDown):
            nameColor = upOrDown ? .green : .blue
        case (.green, upOrDown):
            nameColor = upOrDown ? .blue : .red
        default:
            nameColor = upOrDown ? .red : .green
        }
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


