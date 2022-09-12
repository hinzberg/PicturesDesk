//  ContentView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI

struct MainView: View {
    
    @StateObject var settings = ApplicationSettings()
    @StateObject var bookmarksHandler = FileBookmarkHandler.shared
    private var startUpDirectory : URL?
    
    init() {
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        self.startUpDirectory = URL.init(fileURLWithPath: paths[0])
        self.startUpDirectory = bookmarksHandler.getBookmarksFolders().last
    }
    
    var body: some View {
        NavigationView {
                SidebarFoldersView()
                PictureWrappingView(url: startUpDirectory)
        }
        .environmentObject(settings)
    }
}

struct MainView_Previews: PreviewProvider {
    static var previews: some View {
        MainView()
    }
}
