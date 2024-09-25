//
//  AuthView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct AuthView: View {
    
    @ObservedObject var viewModel: AuthViewModel
    
    @State var email = ""
    @State var password = ""
    
    @State private var isAlertShown = false
    @State private var switcher = true
    
    var body: some View {
        NavigationStack {
            ZStack {
                
                ScrollView {
                    VStack {
                        Image("logo")
                            .resizable()
                            .scaledToFill()
                            .frame(width: 350, height: 350)
                        
                        TextField("", text: $email, prompt: Text("E-mail").foregroundColor(.white.opacity(0.6)))
                            .padding()
                            .padding(.vertical, 5)
                            .background {
                                Rectangle()
                                    .fill(Color.purpleGradient)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal)
                            .padding(.top, -70)
                        
                        TextField("", text: $password, prompt: Text("Password").foregroundColor(.white.opacity(0.6)))
                            .padding()
                            .padding(.vertical, 5)
                            .background {
                                Rectangle()
                                    .fill(Color.purpleGradient)
                                    .cornerRadius(16)
                            }
                            .padding(.horizontal)
                        
                        Button {
                            Task {
                                try await viewModel.signIn(email: email, password: password)
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("LOG IN")
                                .foregroundStyle(.white)
                                .font(.system(size: 25, weight: .black))
                        }
                        .padding()
                        .padding(.horizontal, 30)
                        .background {
                            Rectangle()
                                .fill(Color.blueGradient)
                                .cornerRadius(16)
                        }
                        .padding(.top)
                        
                        Button {
                            Task {
                                await viewModel.signInAnonymously()
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } label: {
                            Text("ANONYMOUS LOG IN")
                                .foregroundStyle(.white)
                                .font(.system(size: 18, weight: .black))
                        }
                        .padding()
                        .padding(.horizontal, 30)
                        .background {
                            Rectangle()
                                .fill(Color.blueGradient)
                                .cornerRadius(16)
                        }
                        .padding(.top)
                        
                        NavigationLink {
                            RegistrationView(viewModel: viewModel)
                        } label: {
                            Text("YOU DON'T HAVE AN ACCOUNT YET? ")
                                + Text("SIGN UP")
                                    .underline()
                                    .foregroundColor(.blue)
                                + Text(" NOW.")
                        }
                        .font(.system(size: 12, weight: .semibold))
                        .foregroundStyle(.white)
                        .padding(.top)
                        
                        Spacer()
                    }
                    
                }
                .scrollIndicators(.hidden)
            }
            .overlay {
                if isAlertShown {
                    ProgressAlertView(text: "Incorrect email or password.", switcher: $switcher) {
                        withAnimation {
                            isAlertShown = false
                            switcher = true
                        }
                    }
                    .onAppear {
                        DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                            switcher = false
                        }
                    }
                }
            }
            .background {
                BackgroundView(image: .black)
            }
        }
        .tint(.white)
        .preferredColorScheme(.dark)
    }
}

//#Preview {
//    AuthView()
//}
