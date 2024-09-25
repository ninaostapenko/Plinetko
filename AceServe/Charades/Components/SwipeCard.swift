//
//  SwipeCard.swift
//  AceServe
//
//  Created by D K on 24.09.2024.
//

import SwiftUI

import SwiftUI

class SwipeCardViewModel: ObservableObject {
        
    @Published var color: Color =  Color(#colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1529411765, alpha: 1))
    @Published var offset = CGSize.zero
    @Published var rotation = 0.0
    @Published var isSwiped = false
    
    @Published var isKnown = false
    
    func swipeCard(width: CGFloat) {
        switch width {
        case -500...(-150):
            offset = CGSize(width: -500, height: 0)
            isSwiped.toggle()
            isKnown = false
        case 150...(500):
            offset = CGSize(width: 500, height: 0)
            isSwiped.toggle()
            isKnown = true
        default:
            offset = .zero
        }
    }
    
    func changeColor(width: CGFloat) {
        switch width {
        case -500...(-130):
            color = .red
        case 130...(500):
            color = .green
        default:
            color =  Color(#colorLiteral(red: 0.1411764706, green: 0.1411764706, blue: 0.1529411765, alpha: 1))
        }
    }
}

struct SwipeCardView: View {
    
    var isSwipeble: Bool
    var word: String
    var width: CGFloat//350
    var height: CGFloat//520
    @StateObject var viewModel = SwipeCardViewModel()
    var completion: (Bool) -> ()
    
    
    var body: some View {
        if isSwipeble {
            ZStack {
                //MARK: - Card
                Rectangle()
                    .foregroundColor(viewModel.color)
                    .frame(width: width, height: height)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.lightPurple, lineWidth: 1)
                            .opacity(0.4)
                    }
                //MARK: - Word on card
                HStack {
                    VStack {
                        Text(word)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .multilineTextAlignment(.center)
                .frame(width: 250)
            }
            //Card motion
            .offset(x: viewModel.offset.width, y: viewModel.offset.height * 0.4)
            .rotationEffect(.degrees(Double(viewModel.offset.width / 40)))
            .gesture(
                DragGesture()
                    .onChanged{ gesture in
                        viewModel.offset = gesture.translation
                        withAnimation {
                            viewModel.changeColor(width: viewModel.offset.width)
                        }
                    }
                    .onEnded {_ in
                        withAnimation {
                            viewModel.swipeCard(width: viewModel.offset.width)
                            viewModel.changeColor(width: viewModel.offset.width)
                            if viewModel.isSwiped {
                                completion(viewModel.isKnown)
                            }
                        }
                    }
            )
        } else {
            ZStack {
                //MARK: - Card
                Rectangle()
                    .foregroundColor(viewModel.color)
                    .frame(width: width, height: height)
                    .cornerRadius(20)
                    .overlay {
                        RoundedRectangle(cornerRadius: 20)
                            .stroke(Color.lightPurple, lineWidth: 1)
                            .opacity(0.4)
                    }
                //MARK: - Word on card
                HStack {
                    VStack {
                        Text(word)
                            .font(.largeTitle)
                            .foregroundColor(.white)
                    }
                }
                .multilineTextAlignment(.center)
                .frame(width: 250)
            }
        }
        
        
        
    }
}

#Preview {
    SwipeCardView(isSwipeble: false, word: "Some Word", width: 350, height: 520) {_ in}
}
