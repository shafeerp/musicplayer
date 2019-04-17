//
//  Defaults.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 14/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import Foundation

struct Defaults {
    
    static let isLoginKey = "isLogin"
    
    struct Login {
        
        var isLogin : Bool?
        init(isLogin : Bool) {
            self.isLogin = isLogin
        }
    }
    static var setIsLogin = { (isLogin:Bool) in
        UserDefaults.standard.set(isLogin, forKey: Defaults.isLoginKey)
    }
    
    static var getIsLogin = {_ -> Login in
        return Login(isLogin: (UserDefaults.standard.value(forKey: Defaults.isLoginKey) != nil))
    }(())
    
    static func clearLogin(){
        UserDefaults.standard.removeObject(forKey: Defaults.isLoginKey)
    }
    
}
