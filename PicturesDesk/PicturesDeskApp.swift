//  PicturesDeskApp.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI
import Hinzberg_Foundation

@main
struct PicturesDeskApp: App {
    
    @NSApplicationDelegateAdaptor(AppDelegate.self) var delegate
    @StateObject var settings = ApplicationSettings()
    private var startUpDirectory : URL?
    
    var body: some Scene {
        WindowGroup {
            NavigationManagerMainView()
            .navigationTitle(getWindowTitle())
            .environmentObject(settings)
        }
    }
    
    func getWindowTitle() -> String
    {
        return "Pictures Desk - Version \(Bundle.main.releaseVersionNumber)"
    }
        
    func ToggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func doSomething () {
        // to do
    }
}
