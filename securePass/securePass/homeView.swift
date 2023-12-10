//
//  homeView.swift
//  securePass
//
//  Created by Kevin Yuan on 1/12/2023.
//

import SwiftUI

@MainActor
final class homeViewModel: ObservableObject{
    
    func signOut() throws{
        try AuthenticationManager.shared.signOut()
    }
    
    func resetPassword() async throws{
        let authUser = try AuthenticationManager.shared.getAuthenticatedUser()
        
        guard let email = authUser.email else{
            throw URLError(.fileDoesNotExist)
        }
        
        try await AuthenticationManager.shared.resetPassword(email: email)
    }
    
    func delete() async throws{
        try await AuthenticationManager.shared.delete()
    }
    
}

struct homeView: View {
    private let cc_primary = Color(red: 81/255, green: 215/255, blue: 238/255)
    private let cc_onPrimary = Color(red: 0/255, green: 54/255, blue: 62/255)
    private let cc_primaryContainer = Color(red: 0/255, green: 78/255, blue: 89/255)
    private let cc_onPrimaryContainer = Color(red: 159/255, green: 239/255, blue: 255/255)

    private let cc_secondary = Color(red: 177/255, green: 203/255, blue: 209/255)
    private let cc_onSecondary = Color(red: 28/255, green: 52/255, blue: 57/255)
    private let cc_secondaryContainer = Color(red: 51/255, green: 75/255, blue: 79/255)
    private let cc_onSecondaryContainer = Color(red: 205/255, green: 231/255, blue: 237/255)

    private let cc_tertiary = Color(red: 188/255, green: 197/255, blue: 235/255)
    private let cc_onTertiary = Color(red: 37/255, green: 47/255, blue: 77/255)
    private let cc_tertiaryContainer = Color(red: 60/255, green: 70/255, blue: 101/255)
    private let cc_onTertiaryContainer = Color(red: 219/255, green: 225/255, blue: 255/255)

    private let cc_background = Color(red: 25/255, green: 28/255, blue: 29/255)
    private let cc_onBackground = Color(red: 225/255, green: 227/255, blue: 227/255)
        
    @State private var pwdResetMsg = ""
    @State private var pwdResetMsgTitle = ""
    @State private var showPwdResetMsg = false
    
    @State private var deleteAccMsg = ""
    @State private var deleteAccMsgTitle = ""
    @State private var showDeleteAccMsg = false
    
    @StateObject private var viewModel = homeViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("User Settings")
                Spacer()
            }
            .font(Font.custom("Roboto", size: 36))
            
            Spacer()
            
            Button("Reset password"){
                Task{
                    showPwdResetMsg = true
                    do{
                        try await viewModel.resetPassword()
                        print("pwd reset")
                        pwdResetMsg = "Check your email for further steps"
                        pwdResetMsgTitle = "Success"
                    } catch{
                        print(error)
                        pwdResetMsg = String(describing: error)
                        pwdResetMsgTitle = "Error"
                    }
                }
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(cc_tertiaryContainer)
            .foregroundColor(cc_onTertiaryContainer)
            .cornerRadius(24)
            .alert(isPresented: $showPwdResetMsg){
                Alert(
                    title: Text(pwdResetMsgTitle),
                    message: Text(pwdResetMsg),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
            
            NavigationLink{
                emailUpdateView()
            } label: {
                Text("Change email")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(cc_tertiaryContainer)
                    .foregroundColor(cc_onTertiaryContainer)
                    .cornerRadius(24)
                    .padding(.top, 24)
                
            }
            
            NavigationLink{
                passwordUpdateView()
            } label: {
                Text("Change password")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(cc_tertiaryContainer)
                    .foregroundColor(cc_onTertiaryContainer)
                    .cornerRadius(24)
                    .padding(.top, 24)
                
            }
            
            Button("Sign out"){
                Task{
                    do{
                        try viewModel.signOut()
                        showSignInView = true
                    } catch{
                        print(error)
                    }
                }
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(cc_tertiaryContainer)
            .foregroundColor(cc_onTertiaryContainer)
            .cornerRadius(24)
            .padding(.top, 24)
            
            Button("Delete account"){
                Task{
                    showDeleteAccMsg = true
                    
                    do{
                        try await viewModel.delete()
                        print("acc deleted")
                        deleteAccMsg = "Please log in again"
                        deleteAccMsgTitle = "Success"
                        showSignInView = true
                    } catch{
                        print(error)
                        deleteAccMsg = String(describing: error)
                        deleteAccMsgTitle = "Error"
                    }
                    
                }
            }
            .frame(height: 60)
            .frame(maxWidth: .infinity)
            .background(cc_tertiaryContainer)
            .foregroundColor(cc_onTertiaryContainer)
            .cornerRadius(24)
            .padding(.top, 24)
            .alert(isPresented: $showDeleteAccMsg){
                Alert(
                    title: Text(deleteAccMsgTitle),
                    message: Text(deleteAccMsg),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
            
            
        }
        .padding(36)
        .edgesIgnoringSafeArea(.bottom)
        .font(Font.custom("Roboto", size: 24))
        .foregroundColor(cc_onBackground)
        .background(cc_background)
    }
}

struct homeView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            homeView(showSignInView: .constant(false))
        }
    }
}
