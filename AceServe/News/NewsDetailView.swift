//
//  NewsDetailView.swift
//  AceServe
//
//  Created by D K on 23.09.2024.
//

import SwiftUI

struct NewsDetailView: View {
    
    var newsElement: News
    
    var body: some View {
        ZStack {
            Rectangle()
                .fill(Color.purpleGradient)
                .ignoresSafeArea(edges: .bottom)
            
            
            ScrollView {
                VStack(alignment: .leading) {
                    if let url = URL(string: newsElement.image) {
                        AsyncImage(url: url) { image in
                            image
                                .resizable()
                                .scaledToFill()
                                .frame(width: displaySize().width, height: 240)
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
                        .font(.system(size: 26, weight: .black))
                        .padding(.horizontal)
                    
                    
                    Text(newsElement.body)
                    .font(.system(size: 20, weight: .regular))
                    .foregroundStyle(.white)
                    .padding(.horizontal)
                    .padding(.top)
                    .padding(.bottom, 200)
            }
            }
            .scrollIndicators(.hidden)
        }       
    }
}

#Preview {
    NewsDetailView(newsElement: .MOCK())
}
