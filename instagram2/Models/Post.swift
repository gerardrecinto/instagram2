//
//  Post.swift
//  instagram2
//
//  Created by Gerard Recinto on 12/24/17.
//  Copyright © 2017 Gerard Recinto. All rights reserved.
//

import UIKit

// Post model — backed by LocalInstagramService (replaced Parse backend)
struct Post {
    var caption: String
    var author: String
    var image: UIImage?
    var likesCount: Int = 0
    var commentsCount: Int = 0
    var timestamp: Date = Date()
}
