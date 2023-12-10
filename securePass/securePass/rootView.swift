//
//  rootView.swift
//  securePass
//
//  Created by Kevin Yuan on 1/12/2023.
//

import SwiftUI

struct rootView: View {
    @State private var showSignInView: Bool = false
    
    var body: some View {
        ZStack{
            NavigationStack{
                profileView(showSignInView: $showSignInView)
            }
        }
        .onAppear{
            let authUser =  try? AuthenticationManager.shared.getAuthenticatedUser()
            self.showSignInView = authUser == nil
        }
        .fullScreenCover(isPresented: $showSignInView) {
            NavigationStack{
                ContentView(showSignInView: $showSignInView)
            }
        }
    }
}

struct rootView_Previews: PreviewProvider {
    static var previews: some View {
        rootView()
    }
}
