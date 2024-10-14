//
//  ChatToUser.swift
//  
//
//  Created by Baha Ok on 2.10.2024.
//

import SwiftUI
import FirebaseFirestore
import FirebaseAuth
struct ChatToUser: View {
    var chatToUser : UserModel
    @State var messageToSend = ""
    @ObservedObject var chatstore = ChatStore()
    let db = Firestore.firestore()
    var body: some View {
        VStack{
            
            ScrollView{
                ForEach(chatstore.chatArray) { chats in
                    
                    MessageView(chatMessage: chats, userTo: chatToUser)

                }
            }

            
            
            
            HStack {
                TextField("Message write here..." , text: $messageToSend).frame(minHeight: 30).padding()
                Button(action: sendMessages, label: {
                    Image("send").resizable().frame(width: 30, height: 30, alignment: .trailing)
                }).frame(minWidth: 30).padding()
            }
        }
    }
    
    func sendMessages(){
        var ref : DocumentReference? = nil
        
        let myDictionary : [String : Any] = ["chatUserFrom" : Auth.auth().currentUser!.uid,
                                             "chatUserTo" : chatToUser.uidFromFirebase,
                                             "date" : generateDate(),
                                             "message" : self.messageToSend
           ]
        
        ref = self.db.collection("Chats").addDocument(data: myDictionary, completion: { error in
            if error != nil {
                
            }else {
                self.messageToSend = ""
            }
        })
    }
    func generateDate() -> String{
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy_MM_dd_hh_mm_ss"
        return(formatter.string(from:Date()) as NSString) as String
    }
}

#Preview {
    ChatToUser(chatToUser: UserModel(id: 1, Username: "Pars", uidFromFirebase: "asd12312eqew"))
}
