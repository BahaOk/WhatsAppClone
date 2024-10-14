//
//  UserStore.swift
//  
//
//  Created by Baha Ok on 21.09.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore
import FirebaseCore
import Combine

class UserStore : ObservableObject {
    
    
    let db = Firestore.firestore()
    var userArray : [UserModel] = []

    var objectWillChange = PassthroughSubject<Array<Any>, Never>()
    
    init(){
        db.collection("Users").addSnapshotListener{ (snapshot , error) in
            if error != nil {
                
            }
            else{
                self.userArray.removeAll(keepingCapacity: false)
                
                for document in snapshot!.documents {
                    if let useridfromfirebase = document.get("userIdFromDatabase") as? String {
                        if let username = document.get("username") as? String {
                            
                            let currentIndex = self.userArray.last?.id
                            
                            let createdUser = UserModel(id: (currentIndex ?? -1) + 1 , Username: username, uidFromFirebase: useridfromfirebase)
                            self.userArray.append(createdUser)
                        }
                    }
                }
                self.objectWillChange.send(self.userArray)
            }
        }
    }
}
