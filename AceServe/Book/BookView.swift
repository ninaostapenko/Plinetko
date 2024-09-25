//
//  BookView.swift
//  AceServe
//
//  Created by D K on 22.09.2024.
//

import SwiftUI
import MessageUI

struct BookView: View {
    
    @Environment(\.dismiss) var dismiss
    
    var club: Club?
    @State var email = ""
    @State var name = ""
    @State var phone = ""
    @State var date = Date()
    @State var time = "07:00"
    @State var selectedClub = "Plinetko I"
    
    var availableTime: [String] = ["07:00", "08:00", "09:00","10:00", "11: 00", "12:00", "13:00","14:00","15:00","16:00","17:00","18:00","19:00","20:00","21:00","22:00","23:00"]
    var clubs = ["Plinetko I", "Plinetko II", "Plinetko III"]
    
    @State private var messageAlert = false
    @State private var isMailShown = false

    
    var body: some View {
        ZStack {
            VStack {
                Spacer()
                
                Image("setka")
                    .resizable()
                    .ignoresSafeArea()
                    .blur(radius: 3)
            }
            
            VStack {
                HStack {
                    Button {
                        dismiss()
                    } label: {
                        Image(systemName: "chevron.left")
                            .font(.system(size: 24, weight: .black))
                            .foregroundColor(.white)
                    }
                    
                    Spacer()
                    
                    Text("BOOK")
                        .foregroundStyle(Color.lightPurple)
                        .font(.system(size: 46, weight: .black))
                        .overlay {
                            Color.purpleGradient
                                .mask(
                                    Text("BOOK")
                                        .font(Font.system(size: 46, weight: .black))
                                        .multilineTextAlignment(.center)
                                )
                        }
                }
                .padding(.horizontal)
                
                ScrollView {
                    VStack(spacing: 20) {
                        if let club = club {
                            VStack(alignment: .leading) {
                                Text("Club Name: ")
                                    .font(.system(size: 22, weight: .light))
                                + Text("\(club.name)".uppercased())
                                    
                                    .font(.system(size: 22, weight: .bold))
                                Text("Time: ")
                                    .font(.system(size: 22, weight: .light))
                                + Text("\(club.time)")
                                    .font(.system(size: 22, weight: .bold))
                                Text("Courts: ")
                                    .font(.system(size: 22, weight: .light))
                                + Text("\(club.courts)")
                                    .font(.system(size: 22, weight: .bold))
                            }
                            .frame(width: displaySize().width - 60, alignment: .leading)
                            .padding()
                            .foregroundColor(.black)
                            .background {
                                Rectangle()
                                    .frame(width: displaySize().width - 30, alignment: .leading)
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                        } else {
                            HStack {
                                Text("CLUBS:")
                                    .foregroundStyle(.gray)
                                    .bold()
                                    .padding(.leading)
                                
                                Spacer()
                                
                                Picker("", selection: $selectedClub) {
                                    ForEach(clubs, id: \.self) { time in
                                        Text(time)
                                    }
                                }
                                .foregroundColor(.gray)
                                .bold()
                                .colorMultiply(.black)
                                .tint(.darkPurple)
                                .padding()
                                
                            }
                            .background {
                                Rectangle()
                                    .foregroundColor(.white)
                                    .cornerRadius(12)
                            }
                            .padding(.horizontal)
                        }
                        
                        TextField("", text: $name, prompt: Text("NAME:").foregroundColor(.gray)
                            .bold())
                        
                        .padding()
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        TextField("", text: $email, prompt: Text("EMAIL:").foregroundColor(.gray)
                            .bold())
                        .padding()
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        TextField("", text: $phone, prompt: Text("PHONE:").foregroundColor(.gray)
                            .bold())
                        .padding()
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("DATE:")
                                .foregroundStyle(.gray)
                                .bold()
                                .padding(.leading)
                            
                            DatePicker("", selection: $date, in: Date()..., displayedComponents: .date)
                                .datePickerStyle(.compact)
                                .foregroundColor(.gray)
                                .bold()
                                .colorMultiply(.black)
                                .tint(.darkPurple)
                                .padding()
                            
                        }
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                        
                        HStack {
                            Text("TIME:")
                                .foregroundStyle(.gray)
                                .bold()
                                .padding(.leading)
                            
                            Spacer()
                            
                            Picker("", selection: $time) {
                                ForEach(availableTime, id: \.self) { time in
                                    Text(time)
                                }
                            }
                            .foregroundColor(.gray)
                            .bold()
                            .colorMultiply(.black)
                            .tint(.darkPurple)
                            .padding()
                            
                        }
                        .background {
                            Rectangle()
                                .foregroundColor(.white)
                                .cornerRadius(12)
                        }
                        .padding(.horizontal)
                    }
                    .foregroundColor(.black)
                    
                    
                    Button {
                        if MFMailComposeViewController.canSendMail() {
                            isMailShown.toggle()
                        } else {
                            messageAlert.toggle()
                        }
                    } label: {
                        ZStack {
                            Rectangle()
                                .fill(Color.blueGradient)
                                .frame(width: displaySize().width - 100, height: 70)
                                .cornerRadius(12)
                            
                            Text("BOOK")
                                .foregroundStyle(.white)
                                .font(.system(size: 32, weight: .black))
                        }
                    }
                    .padding(.top)
                    .padding(.bottom, 200)
                }
                .scrollIndicators(.hidden)
            }
        }
        //MARK: - MessageView
        .sheet(isPresented: $isMailShown) {
            MailComposeView(isShowing: $isMailShown, subject: "RESERVATION MESSAGE", recipientEmail: "plinetkoClubsManager@outlook.com", textBody: makeReservMessage()) { result, error in
                switch result {
                case .cancelled:
                    print("Mail cancelled")
                case .saved:
                    print("Mail saved")
                case .sent:
                    print("Mail sent")
                    dismiss()
                case .failed:
                    print("Mail failed: \(error?.localizedDescription ?? "Unknown error")")
                @unknown default:
                    print("Unknown result")
                }
            }
          
        }
        //MARK: - Message Alert
        .alert("Unable to send email", isPresented: $messageAlert) {
            Button {
                messageAlert.toggle()
            } label: {
                Text("Ok")
            }
        } message: {
            Text("Your device does not have a mail client configured. Please configure your mail or contact support on our website.")
        }
        .background {
            BackgroundView(image: .black)
        }
    }
    
    
    func makeReservMessage() -> String {
        
        let message = """
RESERVATION MESSAGE

CLUB: \(club?.name ?? selectedClub)

Name: \(name)
Email: \(email)
Phone: \(phone)

User Code: \(UserDefaults.standard.string(forKey: "code") ?? "")

Date: \(date)
Start time: \(time)
"""
        
        return message
    }
}

#Preview {
    BookView()
        .preferredColorScheme(.dark)
}


struct MailComposeView: UIViewControllerRepresentable {
    @Binding var isShowing: Bool
    let subject: String
    let recipientEmail: String
    let textBody: String
    var onComplete: ((MFMailComposeResult, Error?) -> Void)?
    
    func makeUIViewController(context: Context) -> MFMailComposeViewController {
        let mailComposer = MFMailComposeViewController()
        mailComposer.setSubject(subject)
        mailComposer.setToRecipients([recipientEmail])
        mailComposer.setMessageBody(textBody, isHTML: false)
        mailComposer.mailComposeDelegate = context.coordinator
        return mailComposer
    }
    
    func updateUIViewController(_ uiViewController: MFMailComposeViewController, context: Context) {}
    
    func makeCoordinator() -> Coordinator {
        Coordinator(self)
    }
    
    class Coordinator: NSObject, MFMailComposeViewControllerDelegate {
        let parent: MailComposeView
        
        init(_ parent: MailComposeView) {
            self.parent = parent
        }
        
        func mailComposeController(_ controller: MFMailComposeViewController, didFinishWith result: MFMailComposeResult, error: Error?) {
            parent.isShowing = false
            parent.onComplete?(result, error)
        }
    }
}
