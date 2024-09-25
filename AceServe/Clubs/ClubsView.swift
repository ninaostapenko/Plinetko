//
//  BarsView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct ClubsView: View {
    
    @State private var clubs: [Club] = []
    @Environment(\.dismiss) var dismiss
    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Image("setka")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: 3)
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("CLUBS")
                        .foregroundStyle(Color.lightPurple)
                        .font(.system(size: 46, weight: .black))
                        .overlay {
                            Color.purpleGradient
                                .mask(
                                    Text("CLUBS")
                                        .font(Font.system(size: 46, weight: .black))
                                        .multilineTextAlignment(.center)
                                )
                            }
                }
                .padding(.horizontal)
                
                ScrollView {
                    ForEach(clubs, id: \.name) { club in
                        ClubCell(club: club)
                            .padding(.bottom)
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .background {
            BackgroundView(image: .black)
        }
        .task {
            do {
                clubs = try await NetworkManager.shared.loadClubs()
            } catch {
                print(error.localizedDescription)
            }
        }
    }
}

#Preview {
    ClubsView()
}
