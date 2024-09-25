//
//  MainView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct MainView: View {
    
    private let adaptiveColumn = [
        GridItem(.adaptive(minimum: 150, maximum: 250))
    ]
    var selection = ["book", "clubs", "charades", "quiz"]
    
    
    var body: some View {
        ZStack {
            
            VStack {
                
                Image("logo")
                    .resizable()
                    .scaledToFill()
                    .frame(width: 350, height: 230)
                    .clipped()
                   // .padding(.top, -50)
                 
                
                Spacer()
                
                LazyVGrid(columns: adaptiveColumn, spacing: 30) {
                    ForEach(selection, id:\.self) { type in
                        NavigationLink {
                            switch type {
                            case "book": BookView().navigationBarBackButtonHidden()
                            case "clubs": ClubsView().navigationBarBackButtonHidden()
                            case "charades": CharadesView().navigationBarBackButtonHidden()
                            case "quiz": QuizView().navigationBarBackButtonHidden()
                            default: BookView().navigationBarBackButtonHidden()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill((type == "book" || type == "clubs") ? Color.blueGradient : Color.purpleGradient)
                                    .frame(width: 170, height: 120)
                                    .cornerRadius(12)
                                
                                VStack {
                                    Image(type)
                                        .resizable()
                                        .scaledToFill()
                                        .frame(width: 60, height: 60)
                                    
                                    Text(String(describing: type).uppercased())
                                        .foregroundStyle(Color.white)
                                        .font(.system(size: 22, weight: .bold))
                                }
                                
                                
                            }
                        }
                    }
                }
                .padding(.bottom, 190)
               
            }
        }
        .background {
            BackgroundView(image: .blue)
                .blur(radius: 4)
        }
        .onAppear {
            DataManager.shared.createInitialData()
        }
    }
}

//#Preview {
//    MainView()
//}

#Preview {
    TabRootView()
}
