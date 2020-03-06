//
//  Photo.swift
//  Alophoto
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import Foundation
import SwiftyJSON

class Photo {
    var id: Int = 0
    var title: String = ""
    var coverPhoto: String = ""
    var previewPhotos = [String]()
    
    convenience init(_ data: JSON) {
        self.init()
        self.id = data["id"].intValue
        self.title = data["title"].stringValue
        self.coverPhoto = data["cover_photo"]["urls"]["small"].stringValue
        self.previewPhotos = data["preview_photos"].arrayValue.map { $0["urls"]["small"].stringValue }
    }
}
