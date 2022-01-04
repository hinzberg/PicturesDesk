//
//  PicturesDeskApp.swift
//  PicturesDesk
//
//  Created by Holger Hinzberg on 20.09.21.
//

import SwiftUI

@main
struct PicturesDeskApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
    }
}
