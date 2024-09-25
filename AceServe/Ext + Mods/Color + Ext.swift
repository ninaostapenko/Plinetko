//
//  Color + Ext.swift
//  AceServe
//
//  Created by Danylo Klymenko on 20.09.2024.
//

import SwiftUI


extension Color {
    static let lightPurple = Color(#colorLiteral(red: 0.6785352826, green: 0.3532397151, blue: 1, alpha: 1))
    static let darkPurple = Color(#colorLiteral(red: 0.368627451, green: 0.02745098039, blue: 0.7137254902, alpha: 1))
    
    static let lightBlue = Color(#colorLiteral(red: 0.2235294118, green: 0.6980392157, blue: 0.9098039216, alpha: 1))
    static let darkBlue = Color(#colorLiteral(red: 0.1333333333, green: 0.06666666667, blue: 0.5647058824, alpha: 1))
    
    static let blueGradient = LinearGradient(colors: [.darkBlue, .lightBlue], startPoint: .bottom, endPoint: .top)
    static let purpleGradient = LinearGradient(colors: [.darkPurple, .lightPurple], startPoint: .bottom, endPoint: .top)
}
