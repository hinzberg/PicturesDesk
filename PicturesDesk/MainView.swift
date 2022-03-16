//  ContentView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI

struct MainView: View {
    
    @StateObject var settings = ApplicationSettings()
    
    init() {
        //FileBookmarkHandler.shared.openFolderSelection()
        //FileBookmarkHandler.shared.saveBookmarksData()
    }
    
    var body: some View {

        NavigationView {
                SidebarFoldersView()
                PictureWrappingView()
        }
        .environmentObject(settings)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
