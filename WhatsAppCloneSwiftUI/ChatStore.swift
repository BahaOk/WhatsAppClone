//
//  ChatStore.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Baha Ok on 2.10.2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
import Combine

class ChatStore : ObservableObject {
    let db = Firestore.firestore()
    var chatArray : [ChatModel] = []
    var didChange = PassthroughSubject<Array<Any>, Never>()
    
    init(){
        db.collection("Chats").whereField("chatUserFrom", isEqualTo: Auth.auth().currentUser!.uid)
            .addSnapshotListener { snapshot, error in
                if error != nil {
                    
                }else {
                    
                    self.chatArray.removeAll(keepingCapacity: false)
                    
                    for document in snapshot!.documents {
                        let chatUidFromFirebase = document.documentID
                        if let chatmessage = document.get("message") as? String {
                            if let messageFrom = document.get("chatUserFrom") as? String {
                                if let messageTo = document.get("chatUserTo") as? String {
                                    if let messageDate = document.get("date") as? String {
                                        
                                        let dateFormatter = DateFormatter()
                                        dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                        let dateFromFB = dateFormatter.date(from : messageDate)
                                         
                                        let currentIndex = self.chatArray.last?.id
                                        
                                        let createdChat = ChatModel(id: (currentIndex ?? -1) + 1 , message: chatmessage, uidFromFirebase: chatUidFromFirebase, messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageMe: true)
                                        
                                        self.chatArray.append(createdChat)
                                    }
                                }
                            }
                        }
                    }
                    
                    self.db.collection("Chats").whereField("chatUserTo", isEqualTo: Auth.auth().currentUser!.uid)
                        .addSnapshotListener { snapshot, error in
                            if error != nil {
                                
                            }else {
                                
                              
                                
                                for document in snapshot!.documents {
                                    let chatUidFromFirebase = document.documentID
                                    if let chatmessage = document.get("message") as? String {
                                        if let messageFrom = document.get("chatUserFrom") as? String {
                                            if let messageTo = document.get("chatUserTo") as? String {
                                                if let messageDate = document.get("date") as? String {
                                                    
                                                    let dateFormatter = DateFormatter()
                                                    dateFormatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
                                                    let dateFromFB = dateFormatter.date(from : messageDate)
                                                     
                                                    let currentIndex = self.chatArray.last?.id
                                                    
                                                    let createdChat = ChatModel(id: (currentIndex ?? -1) + 1 , message: chatmessage, uidFromFirebase: chatUidFromFirebase, messageFrom: messageFrom, messageTo: messageTo, messageDate: dateFromFB!, messageMe: true)
                                                    
                                                    self.chatArray.append(createdChat)
                                                }
                                            }
                                        }
                                    }
                                }
                                
                                self.chatArray = self.chatArray.sorted(by: {
                                    $0.messageDate.compare($1.messageDate) == .orderedDescending
                                })
                                
                                self.didChange.send(self.chatArray)
                            }
                        }
                }
            }
    }
}
