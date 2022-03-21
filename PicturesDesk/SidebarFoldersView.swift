//  SidebarFoldersView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 16.03.22.

import SwiftUI

struct SidebarFoldersView: View {
    
    @ObservedObject var bookmarksHandler = FileBookmarkHandler.shared
    
    var body: some View {
        VStack {
            List {
                Section (header: Text("Folders")) {
                    ForEach (bookmarksHandler.getBookmarksFolders(), id:\.self) { url in
                        NavigationLink(destination: PictureWrappingView(url: url) ) {
                            SidebarFoldersItemView(url: url)
                                .contextMenu {  Button(action: { self.removeFolder(url: url) }, label: {Label("Remove folder", systemImage: "trash")}
                                )}
                        }
                    }
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
        }
    }
    
    private func addFolder() {
        self.bookmarksHandler.openFolderSelection(save: true)
    }
    
    private func removeFolder( url : URL ) {
        self.bookmarksHandler.deleteBookmark(url: url, save: true)
    }
}

struct SidebarFoldersView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarFoldersView()
    }
}
