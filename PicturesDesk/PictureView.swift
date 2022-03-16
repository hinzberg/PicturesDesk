//  PictureView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI

struct PictureView: View {
    
    @Binding var pictureSize: Double
    private var fileName: String
    private var fileURL:URL?
    
    init(item : PictureItem, size : Binding<Double>) {
        self.fileURL = item.fileURL
        self.fileName = item.fileURL.lastPathComponent
        self._pictureSize = size
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
                .frame(width: pictureSize, height: pictureSize)
                .cornerRadius(10)
            
            Text(fileName)
                .foregroundColor(.primary)
        }
        .frame(width: pictureSize + 50, height: pictureSize + 50, alignment: .center)
        .background(Material.ultraThin)
        .cornerRadius(10)
    }
}

