//
//  ColorTextView.swift
//  ColorSliders
//
//  Created by Aleksandr Mayyura on 13.12.2022.
//

import SwiftUI

struct ColorTextView: View {
    
    let value: Double
    
    var body: some View {
        Text("\(lround(value))")
            .foregroundColor(.white)
            .frame(width: 35)
    }
}

struct ColorTextView_Previews: PreviewProvider {
    static var previews: some View {
        ColorTextView(value: 0)
    }
}
