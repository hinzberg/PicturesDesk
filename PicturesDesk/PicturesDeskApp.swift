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
    @StateObject var settings = ApplicationSettings()
    
    var body: some Scene {
        WindowGroup {
            NavigationView {
                SidebarFoldersView()
                PictureWrappingView()
            }
            .toolbar {
                
                ToolbarItem (placement: .navigation) {
                    Button(action: self.ToggleSidebar, label: {
                        Image(systemName: "sidebar.left").font(.headline)
                    })}
                                
                ToolbarItem (placement: .primaryAction) {
                    Button(action: self.doSomething, label: {
                        Image(systemName: "bookmark.circle.fill").font(.headline)
                    })}
            }
            
            .environmentObject(settings)
        }.windowToolbarStyle(UnifiedCompactWindowToolbarStyle())
    }
    
    func ToggleSidebar() {
        NSApp.keyWindow?.firstResponder?.tryToPerform(#selector(NSSplitViewController.toggleSidebar(_:)), with: nil)
    }
    
    func doSomething () {
        // to do
    }
}
