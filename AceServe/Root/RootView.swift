//
//  RootView.swift
//  AceServe
//
//  Created by D K on 25.09.2024.
//

import SwiftUI

struct RootView: View {
    
    @StateObject private var viewModel = AuthViewModel()
    
    var body: some View {
        Group {
            if viewModel.userSession != nil {
                TabRootView()
                    .environmentObject(viewModel)
            } else {
                AuthView(viewModel: viewModel)
                  
            }
        }
    }
}

#Preview {
    RootView()
}
