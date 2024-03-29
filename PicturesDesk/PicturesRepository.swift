//  PicturesRepository.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import Foundation

public class PicturesRepository : ObservableObject
{
    @Published var pictureItems = [PictureItem]()
    private var currentDirectory:URL
    
    init() {
        // The Startup path for the application is the desktop
        // You will see all images on the desktop first
        let paths = NSSearchPathForDirectoriesInDomains(.desktopDirectory, .userDomainMask, true)
        self.currentDirectory = URL.init(fileURLWithPath: paths[0])
    }
    
    func removeAll() {
        self.pictureItems.removeAll()
    }
    
    func loadDataForFolderWithUrl(_ folderURL: URL)
    {
        let urls = getFilesURLFromFolder(folderURL)
        if let urls = urls {
            print("\(urls.count) images found in directory \(folderURL.lastPathComponent)")
            
            for url in urls {
                let item = PictureItem(url: url)
                self.pictureItems.append(item)
            }
        }
    }
    
    fileprivate func getFilesURLFromFolder(_ folderURL: URL) -> [URL]? {
        
        let options: FileManager.DirectoryEnumerationOptions =
            [.skipsHiddenFiles, .skipsSubdirectoryDescendants, .skipsPackageDescendants]
        let fileManager = FileManager.default
        let resourceValueKeys = [URLResourceKey.isRegularFileKey, URLResourceKey.typeIdentifierKey]
        
        guard let directoryEnumerator = fileManager.enumerator(at: folderURL, includingPropertiesForKeys: resourceValueKeys,
                                                               options: options, errorHandler: { url, error in
                                                                print("`directoryEnumerator` error: \(error).")
                                                                return true
                                                               }) else { return nil }
        
        var urls: [URL] = []
        for case let url as URL in directoryEnumerator {
            do {
                let resourceValues = try (url as NSURL).resourceValues(forKeys: resourceValueKeys)
                guard let isRegularFileResourceValue = resourceValues[URLResourceKey.isRegularFileKey] as? NSNumber else { continue }
                guard isRegularFileResourceValue.boolValue else { continue }
                guard let fileType = resourceValues[URLResourceKey.typeIdentifierKey] as? String else { continue }
                guard UTTypeConformsTo(fileType as CFString, "public.image" as CFString) else { continue }
                urls.append(url)
            }
            catch {
                print("Unexpected error occured: \(error).")
            }
        }
        return urls
    }
    
    public func getSelectedItems() -> [PictureItem] {
        return self.pictureItems.filter{ $0.isSelected == true}
    }

    public func getFirstSelectedItem() -> PictureItem? {
        return self.pictureItems.filter{ $0.isSelected == true}.first
    }
        
    public func remove(item : PictureItem) -> Bool {
        if let index = self.pictureItems.firstIndex(of: item) {
            self.pictureItems.remove(at: index)
            item.isSelected = false
            return true
        }
        return false
    }
}
