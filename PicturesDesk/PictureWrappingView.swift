//  WrappingHStackView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 04.01.22.

import SwiftUI
import WrappingHStack

struct PictureWrappingView: View {
    
    @ObservedObject var picturesRepository = PicturesRepository()
    @State private var pictureSize: Double = 200
    
    @EnvironmentObject var settings : ApplicationSettings
    
    var body: some View {
        
        VStack {
            
            ScrollView{
                WrappingHStack(self.picturesRepository.pictureItems, id: \.self ) { item in
                    PictureView(item: item , size: $pictureSize)
                   .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
                   .contextMenu {
                       Button("Show in Finder") { showInFinder(url: item.fileURL) }
                   }
                }
            }
            Spacer()
            
            HStack {
                Spacer()
                Text("\(pictureSize, specifier: "%.0f")")
                Slider(value: $pictureSize , in: 100...500)
                    .frame(width: 300)
            }.padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 10))
                .background(.thinMaterial)
        }.background(.background)
    }
    
    func showInFinder(url : URL) {
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }
    
    
}

struct WrappingHStackView_Previews: PreviewProvider {
    static var previews: some View {
        PictureWrappingView()
    }
}
