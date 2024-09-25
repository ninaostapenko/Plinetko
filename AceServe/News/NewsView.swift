//
//  NewsView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct NewsView: View {
    
    @State private var newsList: [News] = []
    
    var body: some View {
        ZStack {
            VStack {
                Rectangle()
                    .frame(width: displaySize().width, height: 140)
                    .blur(radius: 10)
                    .ignoresSafeArea()
                    .padding(.top, -90)
                
                Spacer()
                
            }
            
            VStack {
                HStack {
                    Text("NEWS")
                        .foregroundStyle(Color.lightPurple)
                        .font(.system(size: 46, weight: .black))
                        .overlay {
                            Color.purpleGradient
                                .mask(
                                    Text("NEWS")
                                        .font(Font.system(size: 46, weight: .black))
                                        .multilineTextAlignment(.center)
                                )
                        }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    ForEach(newsList, id: \.title) { newsElement in
                        NewsCellView(newsElement: newsElement)
                            .padding(.bottom, 20)
                    }
                    
                }
                .shadow(radius: 10)
                .scrollIndicators(.hidden)
                .padding(.bottom, 70)
                .task {
                    do {
                        newsList = try await NetworkManager.shared.loadNews()
                    } catch {
                        print(error.localizedDescription)
                    }
                }
            }
        }
        .background {
            BackgroundView(image: .blue)
                .blur(radius: 4)
        }
    }
}

#Preview {
    NewsView()
}
