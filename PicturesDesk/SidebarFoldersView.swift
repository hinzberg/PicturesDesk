//  SidebarFoldersView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 16.03.22.

import SwiftUI

struct SidebarFoldersView: View {
    var body: some View {
        
        VStack {
            List {
                Section (header: Text("Folders")) {
                    ForEach (FileBookmarkHandler.shared.getBookmarksFolders(), id:\.self) { url in
                        SidebarFoldersItemView(url: url)
                    }
                }
            }
            
            Spacer()
            HStack {
                Button(action: {} ) {
                    Label("Add Folder", systemImage: "folder.badge.plus")
                }.buttonStyle(.plain)
                    .padding(5)
                Spacer()
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 10))
        }
    }
}

struct SidebarFoldersView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarFoldersView()
    }
}
