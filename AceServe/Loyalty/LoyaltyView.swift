//
//  LoyaltyView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct LoyaltyView: View {
    
    @State private var code = ""
    @State private var qrImage: UIImage = UIImage()
    @State private var isShown = false
    
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
                    Text("LOYALTY")
                        .foregroundStyle(Color.lightPurple)
                        .font(.system(size: 46, weight: .black))
                        .overlay {
                            Color.purpleGradient
                                .mask(
                                    Text("LOYALTY")
                                        .font(Font.system(size: 46, weight: .black))
                                        .multilineTextAlignment(.center)
                                        .shadow(color: .black, radius: 1)
                                )
                            }
                    
                    Spacer()
                    
                    Button {
                        isShown.toggle()
                    } label: {
                        Text("?")
                            .foregroundStyle(Color.white)
                            .font(.system(size: 46, weight: .black))
                            .shadow(color: .black, radius: 1)
                    }
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack {
                        Rectangle()
                            .frame(width: 250, height: 250)
                            .cornerRadius(12)
                            .foregroundColor(.white)
                            .overlay {
                                Image(uiImage: qrImage)
                                    .interpolation(.none)
                                    .resizable()
                                    .frame(width: 230, height: 230)
                            }
                        
                        HStack {
                            Text("CODE: \(code)")
                                .foregroundStyle(.white)
                                .font(.system(size: 24, weight: .bold))
                                .padding(.top, 40)
                            
                            Spacer()
                        }
                        .padding(.horizontal, 35)
                       
                        
                        HStack {
                            ForEach(0..<5, id: \.self) { index in
                                Image("ball")
                                    .resizable()
                                    .frame(width: 60, height: 60)
                                    .colorMultiply(index == 0 ? .white : .black)
                            }
                        }
                        .padding(.top)
                        .padding(.bottom, 150)
                    }
                    
                    
                }
                .scrollIndicators(.hidden)
            }
        }
        .sheet(isPresented: $isShown) {
            ZStack {
                BackgroundView(image: .black)
                
                VStack {
                    Text("""

Plinetko Tennis Club Loyalty Program

Welcome to our exclusive Tennis Club Loyalty Program! As a valued member, you’re entitled to exciting benefits designed to reward your passion for the game. Participation is simple – each member is provided with a unique QR code and personal ID number, which grants access to exclusive perks.

Every time you make a reservation, just show your QR code to the club manager. After completing five reservations, your next one is on us – completely free! Additionally, your QR code unlocks discounts on merchandise within the club, offering up to 15% off select items.

Join us and enjoy the rewards of loyalty while enhancing your tennis experience!
""")
                    Spacer()
                    
                }
                .padding(.horizontal)
                .padding(.top, 70)
                .foregroundColor(.white)
            }
        }
        .background {
            BackgroundView(image: .blue)
                .blur(radius: 4)
        }
        .onAppear {
            code = UserDefaults.standard.string(forKey: "code") ?? ""
            qrImage = DataManager.shared.generateQRCode(from: code)
        }
    }
}

#Preview {
    LoyaltyView()
}
