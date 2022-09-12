//  RenameView.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 06.04.22.

import SwiftUI

struct RenameView: View {
    
    @Binding var isPresented: Bool
    @Binding  var url : URL?
    @State private var filename: String = ""
    
    init (isPresented : Binding<Bool> , urlParam : Binding<URL?>)
    {
        _isPresented = isPresented
        _url = urlParam
    }

    var body: some View {
        VStack {
            TextField( "", text: $filename )
                .padding()
            HStack {
                Spacer()
                Button("Rename") { self.rename() }.keyboardShortcut(.defaultAction)
                Button("Cancel") { isPresented = false } .keyboardShortcut(.cancelAction)
            }.padding()
        }
        .frame(width: 400)
        .onAppear(perform: {
            filename =  self.url!.lastPathComponent
        } )
    }
    
    private func rename()
    {
       // let sourceUrl = self.url!
       // let destinationUrl = self.url!.deletingLastPathComponent().appendingPathComponent(self.filename)
        //_ = FileHelper.shared.renameFile(source: sourceUrl, destination: destinationUrl)
        isPresented = false
    }
}

/*
struct RenameView_Previews: PreviewProvider {
    static var previews: some View {
        RenameView(isPresented: .constant(true) , url: URL(string: "")!)
    }
}
 */
