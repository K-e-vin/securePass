//
//  emailSignInView.swift
//  securePass
//
//  Created by Kevin Yuan on 1/12/2023.
//

import SwiftUI

@MainActor
final class emailSignInViewModel: ObservableObject{
    @Published var email = ""
    @Published var password = ""
    
    func signIn() async throws{
        try await AuthenticationManager.shared.signInUser(email: email, password: password)
    }
    
    func signUp() async throws{
        let authDataResult = try await AuthenticationManager.shared.createUser(email: email, password: password)
        let user = DBUser(auth: authDataResult)
        try UserManager.shared.createNewUser(user: user)
    }
}

struct emailSignInView: View {
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
    
    @State var showPassword = false
    @State var signInError = ""
    @State var showSignInError = false
    
    @StateObject private var viewModel = emailSignInViewModel()
    @Binding var showSignInView: Bool
    
    var body: some View {
        VStack{
            HStack{
                Text("Email Sign In")
                Spacer()
            }
            .font(Font.custom("Roboto", size: 36))
            
            Spacer()
            
            VStack{
                //user
                HStack{
                    Image("mail")
                        .padding(.trailing, 10)
                    TextField("", text: $viewModel.email)
                        .padding(8)
                        .foregroundColor(cc_onBackground)
                        .border(cc_onBackground, width: 0.5)
                }
                //pwd
                HStack{
                    Image("key")
                        .padding(.trailing, 8)
                    
                    if showPassword{
                        TextField("", text: $viewModel.password)
                            .padding(8)
                            .foregroundColor(cc_onBackground)
                            .border(cc_onBackground, width: 0.5)
                        
                        Button(action: {
                            showPassword.toggle()
                        }){
                            Image("visibility")
                        }
                    } else{
                        
                        SecureField("", text: $viewModel.password)
                            .padding(8)
                            .foregroundColor(cc_onBackground)
                            .border(cc_onBackground, width: 0.5)
                        
                        Button(action: {
                            showPassword.toggle()
                        }){
                            Image("visibility_off")
                        }
                    }
                }
                .padding(.top, 8)
            }
            .font(Font.custom("Roboto", size: 14))
            
            Spacer()
            
            Button{
                Task{
                    do{
                        try await viewModel.signUp()
                        showSignInView = false
                        return
                    } catch{
                        print(error)
                        signInError = String(describing: error)
                    }
                    
                    do{
                        try await viewModel.signIn()
                        showSignInView = false
                        return
                    } catch{
                        print(error)
                        signInError = String(describing: error)
                    }
                    showSignInError = true
                }
            } label:{
                Text("Sign In")
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(cc_tertiaryContainer)
                    .foregroundColor(cc_onTertiaryContainer)
                    .cornerRadius(24)
            }
            .alert(isPresented: $showSignInError){
                Alert(
                    title: Text("Error"),
                    message: Text(signInError),
                    dismissButton: .default(Text("Dismiss"))
                )
            }
        }
        .padding(48)
        .font(Font.custom("Roboto", size: 24))
        .foregroundColor(cc_onBackground)
        .background(cc_background)
    }


}

struct emailSignInView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            emailSignInView(showSignInView: .constant(false))
        }
    }
}
