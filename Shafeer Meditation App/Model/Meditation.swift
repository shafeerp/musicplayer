//
//  Meditation.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 15/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import Foundation

struct Meditation {
    var name : String
    var doingRightNow : String
    var documentId : String
    var image : String
    
    init(data : [String:Any], documentId : String) {
        self.name = data["name"] as! String
        self.doingRightNow = data["doing_right_now"] as! String
        self.documentId = documentId
        self.image = data["image"] as! String
    }
}
