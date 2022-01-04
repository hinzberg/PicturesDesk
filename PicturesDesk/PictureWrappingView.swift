//  WrappingHStackView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 04.01.22.

import SwiftUI
import WrappingHStack

struct PictureWrappingView: View {
    
    @ObservedObject var picturesRepository = PicturesRepository()
    @EnvironmentObject var settings : ApplicationSettings
    
    var body: some View {
        ScrollView{
            WrappingHStack(self.picturesRepository.pictureItems, id: \.self ) { item in
                PictureView(item: item)
                    .padding(5)
                    .environmentObject(settings)
            }
        }
    }
}

struct WrappingHStackView_Previews: PreviewProvider {
    static var previews: some View {
        PictureWrappingView()
    }
}
