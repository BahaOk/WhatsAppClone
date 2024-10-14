//
//  WhatsAppCloneSwiftUIApp.swift
//  WhatsAppCloneSwiftUI
//
//  Created by Baha Ok on 14.09.2024.
//

import SwiftUI
import FirebaseCore
@main
struct WhatsAppCloneSwiftUIApp: App {
    
    init(){
        FirebaseApp.configure()
    }
    
    
    var body: some Scene {
        WindowGroup {
            AuthView()
        }
    }
}
