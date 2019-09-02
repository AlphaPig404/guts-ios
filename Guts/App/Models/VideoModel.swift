//
//  VideoModel.swift
//  Guts
//
//  Created by chris on 1/9/19.
//  Copyright © 2019 mozat. All rights reserved.
//

import Foundation
import UIKit

class Video {
    var id: Int
    var url: String
    var favorites: Int
    var comments: Int
    var shares: Int
    var favorited: Bool
    
    init(id:Int, url: String, favorites: Int, comments: Int, shares: Int, favorited: Bool) {
        self.id = id
        self.url = url
        self.favorites = favorites
        self.comments = comments
        self.shares = shares
        self.favorited = favorited
    }
}
