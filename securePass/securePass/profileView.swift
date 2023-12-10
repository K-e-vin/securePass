//
//  profileView.swift
//  securePass
//
//  Created by Kevin Yuan on 4/12/2023.
//

import SwiftUI

@MainActor
final class profileViewModel: ObservableObject{
    
    @Published private(set) var user: DBUser? = nil
    
    func loadCurrentUser() async throws{
        let authDataResult = try AuthenticationManager.shared.getAuthenticatedUser()
        self.user = try await UserManager.shared.getUser(userId: authDataResult.uid)
    }
    
}

struct profileView: View {
    
    @StateObject private var viewModel = profileViewModel()
    
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
    
    @Binding var showSignInView: Bool
    
    let url = ["google.com", "google.com", "github.com", "steampowered.com", "twitter.com", "facebook.com", "microsoft.com", "reddit.com"]
    let email = ["user@mail.com", "uesralt@mail.com", "user@mail.com", "user@mail.com", "user@mail.com", "user@mail.com", "user@mail.com", "user@mail.com"]
    
    var body: some View {
        NavigationStack{
            ScrollView{
                VStack{
                    
                    NavigationLink(destination: homeView(showSignInView: $showSignInView), label: {
                        HStack{
                            Spacer()
                            Image("person")
                        }
                        .foregroundColor(cc_onPrimary)
                        .padding(.top, 36)
                    })
                    
                    
                    
                    HStack{
                        Text("Your Stored Passwords")
                        Spacer()
                    }
                    .font(Font.custom("Roboto", size: 36))
                    .padding(.top, 36)
                    
                    HStack{
                        Text("Add password")
                            .frame(height: 48)
                            .frame(maxWidth: 200)
                            .background(cc_primary)
                            .foregroundColor(cc_onPrimary)
                            .cornerRadius(36)
                            .padding(.top, 48)
                            .font(Font.custom("Roboto", size: 20))
                        Spacer()
                    }
                    .padding(.bottom, 50)
                    
                    
                    ForEach((0...7), id: \.self){i in
                        HStack{
                            //basic info
                            VStack{
                                
                                HStack{
                                    Text(url[i])
                                        .fixedSize(horizontal: true, vertical: true)
                                    Spacer()
                                }
                                .font(Font.custom("Roboto", size: 24))
                                HStack{
                                    Text(verbatim: email[i])
                                    Spacer()
                                }
                                .font(Font.custom("Roboto", size: 16))
                                
                            }
                            
                            Spacer()
                            
                            //edit
                            
                            Image("edit")
                        }
                        .padding(14)
                        .padding(.leading, 18)
                        .padding(.trailing, 18)
                        .background(cc_primaryContainer)
                        .foregroundColor(cc_onPrimaryContainer)
                        .cornerRadius(24)
                        .padding(.top, 24)
                    }
                    
                    

                    
                    Spacer()
                    
                    
                    
                }
                .task{
                    try? await viewModel.loadCurrentUser()
                }
                .padding(36)
                .edgesIgnoringSafeArea(.bottom)
                .font(Font.custom("Roboto", size: 24))
                .foregroundColor(cc_onBackground)
                .background(cc_background)
            }
            .edgesIgnoringSafeArea(/*@START_MENU_TOKEN@*/.all/*@END_MENU_TOKEN@*/)
        }
    }
}

struct profileView_Previews: PreviewProvider {
    static var previews: some View {
        profileView(showSignInView: .constant(false))
    }
}
