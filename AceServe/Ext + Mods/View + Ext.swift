//
//  View + Ext.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

extension View {
    func displaySize() -> CGSize {
        guard let window = UIApplication.shared.connectedScenes.first as? UIWindowScene else {
            return .zero
        }
        return window.screen.bounds.size
    }
}
