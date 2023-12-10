//
//  emailUpdateView.swift
//  securePass
//
//  Created by Kevin Yuan on 2/12/2023.
//

import SwiftUI

@MainActor
final class emailUpdateViewModel: ObservableObject{
    @Published var newEmail = ""
    
    func updateEmail() async throws{
        try await AuthenticationManager.shared.updateEmail(email: newEmail)
    }
}

struct emailUpdateView: View {
    let cc_primary = Color(red: 81/255, green: 215/255, blue: 238/255)
    let cc_onPrimary = Color(red: 0/255, green: 54/255, blue: 62/255)
    let cc_primaryContainer = Color(red: 0/255, green: 78/255, blue: 89/255)
    let cc_onPrimaryContainer = Color(red: 159/255, green: 239/255, blue: 255/255)

    let cc_secondary = Color(red: 177/255, green: 203/255, blue: 209/255)
    let cc_onSecondary = Color(red: 28/255, green: 52/255, blue: 57/255)
    let cc_secondaryContainer = Color(red: 51/255, green: 75/255, blue: 79/255)
    let cc_onSecondaryContainer = Color(red: 205/255, green: 231/255, blue: 237/255)

    let cc_tertiary = Color(red: 188/255, green: 197/255, blue: 235/255)
    let cc_onTertiary = Color(red: 37/255, green: 47/255, blue: 77/255)
    let cc_tertiaryContainer = Color(red: 60/255, green: 70/255, blue: 101/255)
    let cc_onTertiaryContainer = Color(red: 219/255, green: 225/255, blue: 255/255)

    let cc_background = Color(red: 25/255, green: 28/255, blue: 29/255)
    let cc_onBackground = Color(red: 225/255, green: 227/255, blue: 227/255)
    
    @StateObject private var viewModel = emailUpdateViewModel()

    var body: some View {
        VStack{
            Spacer()
            
            HStack{
                Text("To Our Valued SecurePass Customers,\n\nWe regret to inform you that we are currently facing a technical issue with our cloud provider that has impacted our email change service. As a result of this issue, you are temporarily unable to change your email address linked to your SecurePass account.\n\nWe sincerely apologize for any inconvenience or frustration this may cause you. We know how vital it is for you to have a secure and dependable password manager. We are working diligently to resolve this issue as quickly as possible and restore the full functionality of our service.\n\nYour security and satisfaction are our utmost priorities. We appreciate your patience and cooperation during this time. We will keep you updated as soon as we have more information.\n\nThank you for choosing SecurePass.\n\nRespectfully,\n\nThe SecurePass Team")
                Spacer()
            }
            
            Spacer()
        }
        .padding(48)
        .font(Font.custom("Roboto", size: 14))
        .foregroundColor(cc_onBackground)
        .background(cc_background)
    }
}

struct emailUpdateView_Previews: PreviewProvider {
    static var previews: some View {
        emailUpdateView()
    }
}
