//  FileManager.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 22.03.22.

import Foundation

public class FileHelper
{
    static let shared = FileHelper()
    private init() {  }
    
    public func deleteFile(source:URL) -> Bool
    {
        let filemanager = FileManager.default
        do
        {
            try filemanager.removeItem(at: source)
            return true
        }
        catch
        {
            print("delete error")
        }
        return false
    }
    
    public func renameFile(source:URL, destination:URL) -> Bool
    {
        let filemanager = FileManager.default
        do
        {
            print(source.absoluteString)
            print(destination.absoluteString)
            try filemanager.moveItem(at: source, to: destination)
            return true
        }
        catch let error
        {
            dump(error)
            print("rename error")
        }
        return false
    }
}
