//
//  ContentView.swift
//  securePass
//
//  Created by Kevin Yuan on 1/12/2023.
//

import SwiftUI

struct ContentView: View {
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
    
    @State private var showAlert = false
    
    @Binding var showSignInView: Bool
    var body: some View {
        VStack {
            HStack{
                Text("SecurePass Login")
                Spacer()
            }
            .font(Font.custom("Roboto", size: 36))
            
            Spacer()
            
            
            VStack{
                NavigationLink{
                    emailSignInView(showSignInView: $showSignInView)
                } label: {
                    Text("Contine with email")
                        .frame(height: 60)
                        .frame(maxWidth: .infinity)
                        .background(cc_tertiaryContainer)
                        .foregroundColor(cc_onTertiaryContainer)
                        .cornerRadius(24)
                    
                }
                
                Button("Contine with Google"){showAlert = true}
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(cc_tertiaryContainer)
                    .foregroundColor(cc_onTertiaryContainer)
                    .cornerRadius(24)
                    .padding(.top, 24)
                    .alert("Coming soon", isPresented: $showAlert){
                        Button("OK", role: .cancel){}
                    }
                
                Button("Contine with Apple"){showAlert = true}
                    .frame(height: 60)
                    .frame(maxWidth: .infinity)
                    .background(cc_tertiaryContainer)
                    .foregroundColor(cc_onTertiaryContainer)
                    .cornerRadius(24)
                    .padding(.top, 24)
                    .alert("Coming soon", isPresented: $showAlert){
                        Button("OK", role: .cancel){}
                    }
                
            }
            
        }
        .padding(36)
        .edgesIgnoringSafeArea(.bottom)
        .font(Font.custom("Roboto", size: 24))
        .foregroundColor(cc_onBackground)
        .background(cc_background)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationStack{
            ContentView(showSignInView: .constant(false))
        }
    }
}
