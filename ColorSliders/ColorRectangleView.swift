//
//  ColorRectangleView.swift
//  ColorSliders
//
//  Created by Aleksandr Mayyura on 13.12.2022.
//

import SwiftUI

struct ColorRectangleView: View {
    let redColor: Double
    let greenColor: Double
    let blueColor: Double
    
    var body: some View {
        Rectangle()
            .foregroundColor(Color(
                red: redColor / 255,
                green: greenColor / 255,
                blue: blueColor / 255
            ))
            .frame(width: 350, height: 170)
            .cornerRadius(16)
            .overlay(RoundedRectangle(cornerRadius: 16).stroke(Color.white, lineWidth: 4))
    }
}

struct ColorRectangleView_Previews: PreviewProvider {
    static var previews: some View {
        ColorRectangleView(redColor: 0, greenColor: 0, blueColor: 0)
    }
}
