//  PictureGridView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import SwiftUI

struct PictureGridView: View {
    
    @ObservedObject var picturesRepository = PicturesRepository()
    @EnvironmentObject var settings : ApplicationSettings
    
    var columns: [GridItem] =
        Array(repeating: GridItem(.adaptive(minimum:250)), count: 4)
    
    
    var body: some View {
        ScrollView {
            LazyHStack(alignment: .center, spacing: 10)  {
                ForEach(self.picturesRepository.pictureItems, id: \.id ) {item in
                    PictureView(item: item)
                }
            }
        }
    }
}

struct PictureGridView_Previews: PreviewProvider {
    static var previews: some View {
        PictureGridView()
    }
}
