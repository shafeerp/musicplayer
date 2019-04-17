//
//  Session.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 15/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import Foundation
struct Session {
    var imageLink : String
    var musicLink : String
    
    init(data : [String:Any]) {
        self.imageLink = data["imageLink"] as! String
        self.musicLink = data["musicLink"] as! String
    }
}
