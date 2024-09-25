//
//  BlackBackgroundView.swift
//  AceServe
//
//  Created by Danylo Klymenko on 20.09.2024.
//

import SwiftUI

enum BG: String {
    case black = "blackBG"
    case purple = "purpleBG"
    case blue = "blueBG"
}

struct BackgroundView: View {
    
    var image: BG
    
    var body: some View {
        Image(image.rawValue)
            .resizable()
            .scaledToFill()
            .frame(width: displaySize().width, height: displaySize().height + 40)
    }
}

#Preview {
    BackgroundView(image: .blue)
}

