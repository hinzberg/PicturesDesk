//  WrappingHStackView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 04.01.22.

import SwiftUI
import WrappingHStack

struct PictureWrappingView: View {
    
    @ObservedObject var picturesRepository = PicturesRepository()
    @ObservedObject var bookmarksHandler = FileBookmarkHandler.shared
    
    @State private var pictureSize: Double = 200
    @State var selection = Set<String>()
    @EnvironmentObject var settings : ApplicationSettings
    var currentUrl : URL?
    
    init(url : URL?)
    {
        self.currentUrl = url
        print("Init with \(self.currentUrl?.path ?? "nil URL" )")
    }
    
    var body: some View {
        
        VStack {
            
            PictureWrappingViewHeadlineView(url: self.currentUrl)
            
            ScrollView{
                WrappingHStack(self.picturesRepository.pictureItems, id: \.self) { item in
                    PictureView(item: item, size: $pictureSize)
                        .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
                        .contextMenu {
                            Button("Show in Finder") { showInFinder(url: item.fileURL) }
                            Menu("Move selected to") {
                                ForEach (bookmarksHandler.getBookmarksFolders(), id:\.self) { url in
                                    Button("\(url.lastPathComponent)") { self.moveSelectedTo(url: url) }
                                }
                            }
                        }.onTapGesture {
                            item.isSelected.toggle()
                            print(item.isSelected)
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
            .onAppear(perform: { onViewAppear() })
    }
    
    private func onViewAppear() {
        print("View appear with \(self.currentUrl?.path ?? "nil URL" )")
        if let url = self.currentUrl
        {
            self.picturesRepository.loadDataForFolderWithUrl(url)
        }
    }
    
    private func showInFinder(url : URL)
    {
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }
    
    private func moveSelectedTo(url : URL)
    {
        print("Move selected to \(url.lastPathComponent)")
        
        let selectedItems = self.picturesRepository.getSelectedItems()
        for item in selectedItems {
            let destination = url.appendingPathComponent(item.fileURL.lastPathComponent)
            let success = FileHelper.shared.renameFile(source: item.fileURL, destination: destination)
            if success { _ = self.picturesRepository.remove(item: item) }
        }
    }
}

struct WrappingHStackView_Previews: PreviewProvider {
    static var previews: some View {
        PictureWrappingView(url: nil)
    }
}
