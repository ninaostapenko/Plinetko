//
//  NewsCellView.swift
//  AceServe
//
//  Created by D K on 23.09.2024.
//

import SwiftUI

struct NewsCellView: View {
    
    var newsElement: News
    @State var isOpen = false
    
    var body: some View {
        Rectangle()
            .fill(Color.purpleGradient)
            .frame(width: displaySize().width - 50, height: 280)
            .cornerRadius(12)
            .overlay {
                VStack(alignment: .leading) {
                    if let url = URL(string: newsElement.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: displaySize().width - 50, height: 140)
                                .clipped()
                                .cornerRadius(12)
                        } placeholder: {
                            ProgressView()
                                .controlSize(.large)
                                .frame(width: displaySize().width - 50, height: 140)
                        }
                    }
                    
                    Text(newsElement.title)
                        .foregroundStyle(.white)
                        .font(.system(size: 22, weight: .black))
                        .padding(.horizontal)
                    
                    
                    HStack {
                        Text(newsElement.body)
                            .font(.system(size: 16, weight: .regular))
                        
                        Image(systemName: "chevron.right")
                    }
                    .foregroundStyle(.white)
                    .padding(.horizontal)

                    
                    
                    Spacer()
                }
            }
            .onTapGesture {
                isOpen.toggle()
            }
            .sheet(isPresented: $isOpen) {
                NewsDetailView(newsElement: newsElement)
            }
    }
}

#Preview {
    NewsCellView(newsElement: .MOCK())
}
