//  NavigationManagerMainView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 18.11.22.

import SwiftUI

struct NavigationManagerMainView : View {
    
    @ObservedObject var bookmarksHandler = FileBookmarkHandler.shared
    @State var sideBarVisibility : NavigationSplitViewVisibility = .doubleColumn
    @State var selectedIdentifier : URL =  URL.init(fileURLWithPath: NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)[0])
    
    var body: some View {
        
        NavigationSplitView(columnVisibility: $sideBarVisibility) {
            List(bookmarksHandler.getBookmarksItems(), selection: $selectedIdentifier) { item in
                NavigationLink (value:  item.url) {
                    SidebarFoldersItemView(url: item.url)
                }
            }
            Spacer()
            HStack {
                Button(action: { self.addFolder() } ) {
                    Label("Add Folder", systemImage: "folder.badge.plus")
                }.buttonStyle(.plain)
                    .padding(5)
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 10))
            
        } detail: {
            PictureWrappingView(url: selectedIdentifier)
        }
    }
    
    private func addFolder() {
        self.bookmarksHandler.openFolderSelection(save: true)
    }
}

