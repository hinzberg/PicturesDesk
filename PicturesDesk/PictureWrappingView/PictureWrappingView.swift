//  WrappingHStackView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 04.01.22.

import SwiftUI
import Quartz
import WrappingHStack
import Hinzberg_SwiftUI

struct PictureWrappingView: View {
    
    @ObservedObject  private var controller = PictureWrappingViewController()
    @State private var pictureSize: Double = 200
    @State var selection = Set<String>()
    @State var renameSheetIsPresented : Bool = false
    @EnvironmentObject var settings : ApplicationSettings
    var currentFolderUrl : URL?
    
    init(url : URL?)
    {
        self.currentFolderUrl = url
        print("Init with \(self.currentFolderUrl?.path ?? "nil URL" )")
    }
    
    var body: some View {
        
        VStack {
            
            PictureWrappingViewHeadlineView(url: self.currentFolderUrl)
            
            ScrollView{
                WrappingHStack(controller.picturesRepository.pictureItems, id: \.self) { item in
                    PictureItemView(item: item, size: $pictureSize)
                        .padding(EdgeInsets(top: 15, leading: 15, bottom: 0, trailing: 0))
                        .contextMenu {
                            Button("Show in Finder") { controller.showInFinder(url: item.fileURL) }
                            Button("Quicklook") { controller.showQuicklook(url: item.fileURL) }
                            Button("Rename") {
                                let pictureItem = controller.picturesRepository.getFirstSelectedItem()
                                if pictureItem != nil
                                {
                                    controller.selectedItem = pictureItem
                                    renameSheetIsPresented = true
                                }
                            }
                            Menu("Move selected to") {
                                ForEach (controller.bookmarksHandler.getBookmarksFolders(), id:\.self) { url in
                                    Button("\(url.lastPathComponent)") { controller.moveSelectedTo(url: url) }
                                }
                            }
                        }.onTapGesture {
                            item.isSelected.toggle()
                            print(item.isSelected)
                        }
                        .sheet(isPresented: $renameSheetIsPresented) {
                            //RenameView(isPresented: $renameSheetIsPresented, urlParam: $currentSelectionUrl)
                            if controller.selectedItem != nil {
                                controller.showTextInputRenameSheet() }
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
    
    private func onViewAppear()
    {
        print("View appear with \(self.currentFolderUrl?.path ?? "nil URL" )")
        if let url = self.currentFolderUrl {
            controller.picturesRepository.loadDataForFolderWithUrl(url)
        }
    }
}

struct WrappingHStackView_Previews: PreviewProvider {
    static var previews: some View {
        PictureWrappingView(url: nil)
    }
}
