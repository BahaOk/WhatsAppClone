//
//  ContentView.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Baha Ok on 14.09.2024.
//

import SwiftUI
import FirebaseAuth
import FirebaseFirestore

struct AuthView: View {
    @ObservedObject var userArray = UserStore()
    let db = Firestore.firestore()
    
    @State var username = ""
    @State var useremail = ""
    @State var password = ""
    @State var showUserAuth = true
    var body: some View {
        
        
        NavigationView{
            
            if showUserAuth == true {
               
        List{
            Text("Whatsapp Clone")
                .font(.largeTitle)
                .bold()
            Section{
                Section {
                    VStack(alignment: .leading){
                        subtitleView(subtitle: "User-Email")
                        TextField(username, text: $useremail)
                    }
                }
                Section {
                    VStack(alignment: .leading){
                        subtitleView(subtitle: "Password")
                        TextField(username, text: $password)
                    }
                }
                Section {
                    VStack(alignment: .leading){
                        subtitleView(subtitle: "Username")
                        TextField(username, text: $username)
                    }
                }
            }
            
            Section{
             
                Section{
                    HStack{
                        Spacer()
                        Button {
                            //Sign in
                            Auth.auth().signIn(withEmail: self.useremail, password: self.password) { (result , error) in
                                if error != nil {
                                    print(error?.localizedDescription as Any)
                                }else {
                                    self.showUserAuth = false
                                }
                            }
                        } label: {
                            Text("Sign In")
                        }
                        Spacer()
                    }
                }
                Section{
                    HStack{
                        Spacer()
                        Button {
                            Auth.auth().createUser(withEmail: self.useremail, password: self.password) { (result,error)  in
                                if error != nil {
                                    print(error?.localizedDescription ?? "error")
                                }else {
                                    //user created
                                    //database
                                    var ref : DocumentReference? = nil
                                    
                                    let myUserDictionary : [String : Any] = [
                                        "username" : self.username,
                                        "useremail" : self.useremail,
                                        "userIdFromDatabase" : result?.user.uid ?? 0
                                        
                                    ]
                                    
                                    
                                    ref = self.db.collection("Users").addDocument(data: myUserDictionary, completion: { (error) in
                                        if(error != nil){
                                            print(error?.localizedDescription ?? "error")
                                        }
                                    })
                                    //go to user screen
                                    self.showUserAuth = false
                                }
                            }
                            
                        } label: {
                            Text("Sign Up")
                        }
                        Spacer()
                    }
                }
        
            }
        }
            }
            else {
                NavigationView{
                    List(userArray.userArray){ user in
                        
                        NavigationLink(destination: ChatToUser(chatToUser: user)) {
                            Text(user.Username)
                        }
                        
                    }
                }.navigationBarTitle("Chat with users!")
                    .navigationBarItems(leading: Button(action: {
                        self.showUserAuth = true
                    }, label: {
                        Text("Log Out")
                    }))
            }
        }
    }
}

struct subtitleView : View {
    var subtitle : String
    var body: some View {
        return Text(subtitle)
            .font(.subheadline)
            .foregroundStyle(Color(.gray))
            .bold()
        
    }
}


#Preview {
    AuthView(showUserAuth: false)
}


