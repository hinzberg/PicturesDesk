//  PictureWrappingViewController.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 06.04.22.

import SwiftUI
import Hinzberg_SwiftUI

public class PictureWrappingViewController : ObservableObject
{
    @ObservedObject var picturesRepository = PicturesRepository()
    @ObservedObject var bookmarksHandler = FileBookmarkHandler.shared
    @Published var selectedItem : PictureItem?
    
    /// Creates a Sheet Window to rename a single file.
    /// Filename on disk and ViewModel Filename will be updated
    /// - Returns: TextInputView
    func showTextInputRenameSheet() -> some View
    {
        var filename: NSString = NSString(string: (selectedItem?.fileURL.path)!)
        filename = NSString(string: filename.lastPathComponent)
        let fileNameOnly : String =  filename.deletingPathExtension
        
        return TextInputView(text: fileNameOnly) { textContent in
            let destinationPath : URL = (self.selectedItem?.fileURL.deletingLastPathComponent())!
            let destinationFileName = textContent
            let destinationExtention = self.selectedItem?.fileURL.pathExtension
            let destination = destinationPath.appendingPathComponent(destinationFileName + "." + destinationExtention!)

            if  FileHelper.shared.renameFile(source: self.selectedItem!.fileURL, destination: destination) == true {
                self.selectedItem?.fileURL = destination
            }
        }
    }
    
    public func showQuicklook(url : URL)
    {
        _ = QuicklookWrapper(url: url)
    }
    
    public func showInFinder(url : URL)
    {
        NSWorkspace.shared.activateFileViewerSelecting([url])
    }
    
    public func moveSelectedTo(url : URL)
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
