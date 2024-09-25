//
//  ProfileView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI
import MessageUI


struct ProfileView: View {
    
    @EnvironmentObject var authViewModel: AuthViewModel
    @State var isDeleteAlertShown = false
    @State var isAlertShown = false
    @State var isSuggestionShown = false
    @State var isErrorShown = false
    
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
                    Text("PROFILE")
                        .foregroundStyle(Color.lightPurple)
                        .font(.system(size: 46, weight: .black))
                        .overlay {
                            Color.purpleGradient
                                .mask(
                                    Text("PROFILE")
                                        .font(Font.system(size: 46, weight: .black))
                                        .multilineTextAlignment(.center)
                                )
                            }
                    
                    Spacer()
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 20) {
                        
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                isSuggestionShown.toggle()
                            } else {
                                isAlertShown.toggle()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.purpleGradient)
                                    .frame(width: displaySize().width - 60, height: 70)
                                    .cornerRadius(12)
                                
                                Text("Suggest improvements".uppercased())
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                    
                            }
                        }
                        .padding(.top, 20)
                        .sheet(isPresented: $isSuggestionShown) {
                            MailComposeView(isShowing: $isSuggestionShown, subject: "Improvement suggestion", recipientEmail: "", textBody: "")
                        }
                        
                        Button {
                            if MFMailComposeViewController.canSendMail() {
                                isErrorShown.toggle()
                            } else {
                                isAlertShown.toggle()
                            }
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.purpleGradient)
                                    .frame(width: displaySize().width - 60, height: 70)
                                    .cornerRadius(12)
                                
                                Text("Report a bug".uppercased())
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                    
                            }
                        }
                        .sheet(isPresented: $isErrorShown) {
                            MailComposeView(isShowing: $isErrorShown, subject: "Error message", recipientEmail: "", textBody: "")
                        }
                        
                        Button {
                            openPrivacyPolicy()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.purpleGradient)
                                    .frame(width: displaySize().width - 60, height: 70)
                                    .cornerRadius(12)
                                
                                Text("Privacy Policy".uppercased())
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                    
                            }
                        }
                        
                        Button {
                            authViewModel.signOut()
                        } label: {
                            ZStack {
                                Rectangle()
                                    .fill(Color.purpleGradient)
                                    .frame(width: displaySize().width - 60, height: 70)
                                    .cornerRadius(12)
                                
                                Text("log out".uppercased())
                                    .foregroundStyle(.white)
                                    .font(.system(size: 18))
                                    
                            }
                        }
                        
                        if authViewModel.currentuser != nil {
                            Button {
                                isDeleteAlertShown.toggle()
                            } label: {
                                ZStack {
                                    Rectangle()
                                        .fill(Color.blueGradient)
                                        .frame(width: displaySize().width - 190, height: 60)
                                        .cornerRadius(12)
                                    
                                    Text("Delete account".uppercased())
                                        .foregroundStyle(.white)
                                        .font(.system(size: 14))
                                    
                                }
                            }
                            .padding(.top)
                            .padding(.bottom, 100)
                        }
                    }
                }
                .scrollIndicators(.hidden)
            }
        }
        .background {
            BackgroundView(image: .blue)
                .blur(radius: 3)
        }
        .alert("Are you sure you want to delete your account?", isPresented: $isDeleteAlertShown) {
            Button {
                authViewModel.deleteUserAccount { result in
                    switch result {
                    case .success():
                        print("Account deleted successfully.")
                        authViewModel.userSession = nil
                        authViewModel.currentuser = nil
                    case .failure(let error):
                        print("ERROR DELELETING: \(error.localizedDescription)")
                    }
                }
            } label: {
                Text("Yes")
            }
            
            Button {
                isDeleteAlertShown.toggle()
            } label: {
                Text("No")
            }
        } message: {
            Text("To access your reserves you will need to create a new account.")
        }
        .alert("Unable to send email", isPresented: $isAlertShown) {
            Button {
                isAlertShown.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
    }
    
    
     func openPrivacyPolicy() {
         if let url = URL(string: "https://sites.google.com/view/plinetko/privacy-policy") {
             UIApplication.shared.open(url)
         }
     }
}

#Preview {
    ProfileView()
}
