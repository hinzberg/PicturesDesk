//  PictureView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI

struct PictureView: View {
    
    @Binding var pictureSize: Double
    @ObservedObject var item:PictureItem
  
    init(item : PictureItem, size : Binding<Double>) {
        self.item = item
        self._pictureSize = size
    }
    
    var body: some View {
        VStack {
            
            AsyncImage(url: self.item.fileURL) { image in
                    image
                        .resizable()
                        .scaledToFit()
                } placeholder: {
                    Rectangle()
                        .fill(Color.clear)
                }
                .frame(width: pictureSize, height: pictureSize)
                .cornerRadius(10)
            
            Text(self.item.fileURL.lastPathComponent)
                .foregroundColor(.primary)
        }
        .frame(width: pictureSize + 50, height: pictureSize + 50, alignment: .center)
        
        .if(item.isSelected) { view in
            view.background(Color.accentColor)
        }
        .if(!item.isSelected) { view in
            view.background(Material.thinMaterial)
        }
        .cornerRadius(10)
    }
}

