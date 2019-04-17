//
//  ViewController.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 14/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import UIKit
import Lottie
import FirebaseAuth
import Firebase
import GoogleSignIn
import FirebaseUI

class SplashController: UIViewController {

    lazy var animationView : AnimationView = {
        let animation = AnimationView(name: "loading")
        animation.frame = CGRect(x: 0, y: 0, width: 200, height: 200)
        animation.center = self.view.center
        animation.contentMode = .scaleAspectFill
        return animation
    }()

    override func viewDidLoad() {
        super.viewDidLoad()
        view.addSubview(animationView)
        animationView.play { (finished) in
            if(!Defaults.getIsLogin.isLogin!) {
                self.handleLogin()
            }
            else {
                self.performSegue(withIdentifier: Constants.Segue.MEDITATION_SCREEN, sender: self)
            }
        }
    }
    
    func handleLogin() {
        let authUI = FUIAuth.defaultAuthUI()
        authUI?.delegate = self
        let providers: [FUIAuthProvider] = [
            FUIGoogleAuth()]
        authUI?.providers = providers
        let authViewController = authUI!.authViewController()
        self.present(authViewController, animated: true, completion: nil)
    }
}

extension SplashController : FUIAuthDelegate {
    
    func authUI(_ authUI: FUIAuth, didSignInWith user: User?, error: Error?) {
        guard error == nil else {
            print("Login Failed")
            return
        }
        Defaults.setIsLogin(true)
        self.performSegue(withIdentifier: Constants.Segue.MEDITATION_SCREEN, sender: self)
    }
}


