//  PictureView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI

struct PictureView: View {
    
    @EnvironmentObject var settings : ApplicationSettings
    
    public var fileName: String
    public var fileURL:URL?
    
    init(item : PictureItem) {
        self.fileURL = item.fileURL
        self.fileName = item.fileURL.lastPathComponent
    }
    
    var body: some View {
        VStack {
            
            AsyncImage(url: self.fileURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .fill(Color.clear)
                }
                .frame(width: settings.pictureSize , height: settings.pictureSize)
                .cornerRadius(10)
            
            Text(fileName)
                .foregroundColor(.primary)
        }
        .frame(width:  (settings.pictureSize + 30), height: (settings.pictureSize + 30), alignment: .center)
        .background(Material.ultraThin)
        .cornerRadius(10)
    }
}

