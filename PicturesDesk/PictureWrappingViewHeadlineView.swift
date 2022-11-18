//  PictureWrappingViewHeadlineView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 21.03.22.

import SwiftUI

struct PictureWrappingViewHeadlineView: View {
    private var url : URL?
    init(url : URL?) {
        self.url = url
    }
    
    var body: some View {
        HStack {
            Text(url != nil ? url!.lastPathComponent : "Headline")
                .font(.title)
                .foregroundColor(.accentColor)
                .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
            Spacer()
        }.background()
    }
}

struct PictureWrappingViewHeadlineView_Previews: PreviewProvider {
    static var previews: some View {
        PictureWrappingViewHeadlineView(url: nil)
    }
}
