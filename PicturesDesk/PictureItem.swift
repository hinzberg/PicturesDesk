//  PictureItem.swift
//  PicturesDesk
//  Created by Holger Hinzberg on 20.09.21.

import Foundation

public class PictureItem : Identifiable, ObservableObject, Equatable
{
    public static func == (lhs: PictureItem, rhs: PictureItem) -> Bool {
        if lhs.id == rhs.id { return true }
        return false
    }
    
    public var id = UUID()
    public var fileURL:URL
    @Published public var isSelected : Bool
    
    init(url:URL) {
        self.fileURL = url
        self.isSelected = false
    }    
}
