//  FileBookmarkHandler.swift
//  Created by Holger Hinzberg on 26.11.20.
// based on
// https://github.com/sidmhatre/GetFolderAccessMacOS.git

// 1. Add this to the Entitlements File
// <key>com.apple.security.files.user-selected.read-write</key>
// <true/>
// <key>com.apple.security.files.bookmarks.app-scope</key>
// <true/>

// 2. Add a folder to the bookmark list anytime you access a folder
// FileBookmarkHandler.shared.storeFolderInBookmark(url: url)
// FileBookmarkHandler.shared.saveBookmarksData()

// 3. Restore saved bookmarks in applicationDidFinishLaunching
// FileBookmarkHandler.shared.loadBookmarks()

import Cocoa

class FileBookmarkHandler : ObservableObject {
    
    static let shared = FileBookmarkHandler()
    @Published private var bookmarks = [URL: Data]()
    
    private init() {  }
    
    /// Show an NSOpenPanel and saves the selected folder in the bookmarks
    /// - Returns: Selected URL
    public func openFolderSelection(save : Bool)
    {
        let openPanel = NSOpenPanel()
        openPanel.allowsMultipleSelection = false
        openPanel.canChooseDirectories = true
        openPanel.canCreateDirectories = true
        openPanel.canChooseFiles = false
        openPanel.begin
        { (result) -> Void in
            if result.rawValue == NSApplication.ModalResponse.OK.rawValue
            {
                let url = openPanel.url
                self.storeFolderInBookmark(url: url!)
                if (save == true){
                    self.saveBookmarksArchive()
                }
            }
        }
    }
    
    ///  Adds another Url to the dicitionary of booksmarks
    ///  Does not save the bookmark file.
    ///  Use saveBookmarksArchive to save
    /// - Parameter url: url
    public func storeFolderInBookmark(url: URL)
    {
        do
        {
            let data = try url.bookmarkData(options: NSURL.BookmarkCreationOptions.withSecurityScope, includingResourceValuesForKeys: nil, relativeTo: nil)
            bookmarks[url] = data
        }
        catch
        {
            Swift.print ("Error storing bookmarks")
        }
    }
    
    /// Location of archived bookmarks directory
    /// - Returns: Location folder
    private func getBookmarkPath() -> String
    {
        var url = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask)[0] as URL
        url = url.appendingPathComponent("Bookmarks.dict")
        return url.path
    }
    
    /// Saves bookmarks to file
    public func saveBookmarksArchive()
    {
        let path = getBookmarkPath()
        print(bookmarks.count)
        NSKeyedArchiver.archiveRootObject(bookmarks, toFile: path)
    }
    
    /// Loads bookmarks from file
    func loadBookmarksArchive()
    {
        let path = getBookmarkPath()
        
        let bookmarksTemp = NSKeyedUnarchiver.unarchiveObject(withFile: path) as? [URL: Data]
        
        if bookmarksTemp != nil {
            self.bookmarks = bookmarksTemp!
            for bookmark in bookmarks
            {
                restoreBookmark(bookmark)
            }
        }
    }
    
    /// Restores a bookmark (typical after loading from file)
    /// - Parameter bookmark: a bookmark
    private func restoreBookmark(_ bookmark: (key: URL, value: Data))
    {
        let restoredUrl: URL?
        var isStale = false
        
        print ("Restoring \(bookmark.key)")
        do
        {
            restoredUrl = try URL.init(resolvingBookmarkData: bookmark.value, options: NSURL.BookmarkResolutionOptions.withSecurityScope, relativeTo: nil, bookmarkDataIsStale: &isStale)
        }
        catch
        {
            print ("Error restoring bookmarks")
            restoredUrl = nil
        }
        
        if let url = restoredUrl
        {
            if isStale
            {
                print ("URL is stale")
            }
            else
            {
                if !url.startAccessingSecurityScopedResource()
                {
                    Swift.print ("Couldn't access: \(url.path)")
                }
            }
        }
    }
    
    public func getBookmarksFolders() ->[URL] {
        return Array(self.bookmarks.keys).sorted{$0.lastPathComponent < $1.lastPathComponent   }
    }
    
    public func deleteBookmark(url :URL, save : Bool) {
        self.bookmarks.removeValue(forKey: url)
        
        if (save == true){
            self.saveBookmarksArchive()
        }
    }
}
