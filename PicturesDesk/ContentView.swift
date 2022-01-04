//  ContentView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI

struct ContentView: View {
    
    @StateObject var settings = ApplicationSettings()
    
    init() {
        //FileBookmarkHandler.shared.openFolderSelection()
        //FileBookmarkHandler.shared.saveBookmarksData()
    }
    
    var body: some View {

            VStack {
                PictureWrappingView()
                .padding()
            Spacer()
                
                Slider(value: $settings.pictureSize , in: 100...1000)
                    .padding(EdgeInsets(top: 0, leading: 5, bottom: 5, trailing: 5))
                
                Text("\(settings.pictureSize)")
                                
            }//.frame(width: 800, height: 800)
            .environmentObject(settings)
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}
