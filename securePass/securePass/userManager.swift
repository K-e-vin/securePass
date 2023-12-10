//
//  userManager.swift
//  securePass
//
//  Created by Kevin Yuan on 5/12/2023.
//

import Foundation
import FirebaseFirestore
import FirebaseFirestoreSwift

struct DBUser: Codable{
    let dateCreated: Date?
    let userId: String
    let email: String?
    
    init(auth: AuthDataResultModel){
        self.dateCreated = Date()
        self.userId = auth.uid
        self.email = auth.email
    }
    
    init(
        dateCreated: Date? = nil,
        userId: String,
        email: String? = nil
    ){
        self.dateCreated = dateCreated
        self.userId = userId
        self.email = email
    }
}

final class UserManager{
    
    static let shared = UserManager()
    private init() {}
    
    private let userCollection = Firestore.firestore().collection("users")
    private let passwordsSubFolder = Firestore.firestore().collection("passwords")
    
    private func userDocument(userId: String) -> DocumentReference{
        userCollection.document(userId)
    }
    
    func createNewUser(user: DBUser) throws{
        try userDocument(userId: user.userId).setData(from: user, merge: false)
    }
    
    func getUser(userId: String) async throws -> DBUser{ 
        try await userDocument(userId: userId).getDocument(as: DBUser.self)
    }
    
    
}
