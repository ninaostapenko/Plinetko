//
//  RegistrationView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI

struct RegistrationView: View {
    
    @State var email = ""
    @State var name = ""
    @State var password = ""
    @State var confirm = ""
    
    @Environment(\.dismiss) var dismiss
    @ObservedObject var viewModel: AuthViewModel
    
    @State private var isNotificationShown = false
    @State private var switcher = true
    @State private var isAlertShown = false
    
    var body: some View {
        ZStack {
            
            Rectangle()
                .foregroundColor(.black)
                .ignoresSafeArea()
            
            Image("ball")
               .offset(x: 180, y: 120.0)
               .blur(radius: 3)
            
            Image("ball")
               .offset(x: -180, y: 290.0)
               .blur(radius: 3)
            
            Image("ball")
               .offset(x: -220, y: -90.0)
               .scaleEffect(0.8)
               .blur(radius: 3)
            
            Image("ball")
               .offset(x: 90, y: -330.0)
               .blur(radius: 3)

            
            ScrollView {
                VStack(spacing: 30) {
                    TextField("", text: $email, prompt: Text("E-mail").foregroundStyle(.white.opacity(0.6)))
                        .padding()
                        .padding(.vertical, 5)
                        .background {
                            Rectangle()
                                .fill(Color.purpleGradient)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                        .padding(.top, 50)
                    
                    TextField("", text: $name, prompt: Text("Name").foregroundStyle(.white.opacity(0.6)))
                        .padding()
                        .padding(.vertical, 5)
                        .background {
                            Rectangle()
                                .fill(Color.purpleGradient)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    
                    TextField("", text: $password, prompt: Text("Password").foregroundStyle(.white.opacity(0.6)))
                        .padding()
                        .padding(.vertical, 5)
                        .background {
                            Rectangle()
                                .fill(Color.purpleGradient)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    
                    TextField("", text: $confirm, prompt: Text("Confirm password").foregroundStyle(.white.opacity(0.6)))
                        .padding()
                        .padding(.vertical, 5)
                        .background {
                            Rectangle()
                                .fill(Color.purpleGradient)
                                .cornerRadius(16)
                        }
                        .padding(.horizontal)
                    
                    Button {
                        if isFormValid {
                            Task {
                                try await viewModel.createUser(withEmail: email, password: password, fullname: name)
                            }
                            withAnimation {
                                isAlertShown.toggle()
                            }
                        } else {
                            isNotificationShown.toggle()
                        }
                    } label: {
                        Text("SIGN UP")
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
                        dismiss()
                    } label: {
                        Text("DO YOU ALREADY ")
                            + Text("HAVE")
                                .underline()
                                .foregroundColor(.blue)
                            + Text(" AN ACCOUNT?.")
                    }
                    .font(.system(size: 12, weight: .semibold))
                    .foregroundStyle(.white)
                    .padding(.top)
                }
            }
            .scrollIndicators(.hidden)
        }
        .preferredColorScheme(.dark)
        .background {
            BackgroundView(image: .black)
        }
        .overlay {
            if isAlertShown {
                ProgressAlertView(text: "Incorrect data or a user with this email already exists.", switcher: $switcher) {
                    withAnimation {
                        isAlertShown = false
                        switcher = true
                        
                        email = ""
                        password = ""
                        name = ""
                        confirm = ""
                    }
                }
                .onAppear {
                    DispatchQueue.main.asyncAfter(deadline: .now() + 5) {
                        switcher = false
                    }
                }
            }
        }
    }
}
//
//#Preview {
//    RegistrationView()
//}

extension RegistrationView: AuthViewModelProtocol {
    var isFormValid: Bool {
        return !email.isEmpty
        && email.contains("@")
        && !password.isEmpty
        && password.count > 5
        && confirm == password
        && !name.isEmpty
        
    }
}
