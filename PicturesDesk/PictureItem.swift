//  PictureItem.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import Foundation

public class PictureItem : Identifiable
{
    public var id = UUID()
    public var fileURL:URL
    
    init(url:URL) {
        self.fileURL = url
    }    
}
