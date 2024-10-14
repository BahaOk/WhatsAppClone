//
//  ChatModel.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Baha Ok on 2.10.2024.
//

import SwiftUI

struct ChatModel : Identifiable {
    var id : Int
    var message : String
    var uidFromFirebase : String
    var messageFrom : String
    var messageTo : String
    var messageDate : Date
    var messageMe : Bool
}
