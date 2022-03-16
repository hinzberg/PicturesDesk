//  SidebarFoldersItemView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 16.03.22.

import SwiftUI

struct SidebarFoldersItemView: View {
    public var url : URL?
    var body: some View {
        HStack {
            Image(systemName: "folder")
            Text( url != nil  ? "\(url!.lastPathComponent)" : "None")
        }
    }
}

struct SidebarFoldersItemView_Previews: PreviewProvider {
    static var previews: some View {
        SidebarFoldersItemView(url: nil)
    }
}
