//
//  ClubCell.swift
//  AceServe
//
//  Created by D K on 24.09.2024.
//

import SwiftUI

struct ClubCell: View {
    
    let club: Club
    @State private var isShown = false

    
    var body: some View {
        Rectangle()
            .foregroundColor(.white)
            .frame(width: displaySize().width - 50, height: 270)
            .cornerRadius(12)
            .overlay {
                VStack {
                    if let url = URL(string: club.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: displaySize().width - 50, height: 130)
                                .offset(y: club.name == "Plinetko II" ? 0 : 20)
                                .clipShape(
                                    .rect(
                                        topLeadingRadius: 12,
                                        bottomLeadingRadius: 0,
                                        bottomTrailingRadius: 0,
                                        topTrailingRadius: 12
                                    )
                                )
                              
                        } placeholder: {
                            ProgressView()
                                .frame(width: displaySize().width - 50, height: 130)
                        }
                    }
                    
                    HStack {
                        Text(club.name)
                            .foregroundStyle(.black)
                            .font(.system(size: 26, weight: .black))
                        
                        Spacer()
                    }
                    .padding(.horizontal)
                    .padding(.bottom, 5)
                    
                    HStack {
                        VStack {
                            HStack {
                                Text(club.address)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Text(club.time)
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                            
                            HStack {
                                Text("Courts: \(club.courts)")
                                    .foregroundStyle(.black)
                                    .font(.system(size: 16, weight: .regular))
                                
                                Spacer()
                            }
                            .padding(.horizontal)
                        }
                        
                        Button {
                            isShown.toggle()
                        } label: {
                            ZStack {
                                Image("button")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 70, height: 70)
                                
                                Image("book")
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 30, height: 30)
                            }
                        }
                        .padding(.trailing)
                    }
                
                    Spacer()
                }
            }
            .fullScreenCover(isPresented: $isShown) {
                BookView(club: club)
            }
    }
}

#Preview {
    ClubCell(club: .MOCK())
        .preferredColorScheme(.dark)
}
