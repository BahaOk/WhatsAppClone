//
//  MessageView.swift
//  
//
//  Created by Baha Ok on 4.10.2024.
//

import SwiftUI
import FirebaseAuth


struct MessageView: View {
    var chatMessage : ChatModel
    var userTo : UserModel
    var body: some View {
        Group{
            
            if chatMessage.messageFrom == Auth.auth().currentUser?.uid && chatMessage.messageTo == userTo.uidFromFirebase {
                HStack{
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(.black)
                        .padding(10)
                    Spacer()
                }

            }else if chatMessage.messageFrom == userTo.uidFromFirebase && chatMessage.messageTo == Auth.auth().currentUser?.uid {
                HStack{
                    Spacer()
                    Text(chatMessage.message)
                        .bold()
                        .foregroundColor(.red)
                        .padding(10)
                   
                }
            }
            else {
                //No
            }
        }
    }
}

#Preview {
    MessageView(chatMessage: ChatModel(id: 1, message: "asdas", uidFromFirebase: "23edd3", messageFrom: "ewf", messageTo: "wefewf", messageDate: Date(), messageMe: true), userTo: UserModel(id: 1, Username: "Baha", uidFromFirebase: "amdpsfsdm" ))
    
}
