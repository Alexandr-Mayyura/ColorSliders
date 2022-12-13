//
//  ColorToolsView.swift
//  ColorSliders
//
//  Created by Aleksandr Mayyura on 13.12.2022.
//

import SwiftUI

struct ColorToolsView: View {
    
    @Binding var value: Double
    @State private var text = ""
    let colorLine: Color
    
    var body: some View {
        HStack {
            ColorTextView(value: value)
            Slider(value: $value, in: 0...255, step: 1)
                .animation(.easeInOut, value: value)
                .accentColor(colorLine)
                .onChange(of: value) { newValue in
                    text = "\(lround(newValue))"
                }
            TextfieldView(text: $text, value: $value)
        }
        .onAppear {
            text = "\(lround(value))"
        }
    }
}

struct ColorToolsView_Previews: PreviewProvider {
    static var previews: some View {
        ColorToolsView(value: .constant(0), colorLine: .blue)
    }
}
