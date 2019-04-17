//
//  FirebaseManager.swift
//  Shafeer Meditation App
//
//  Created by Shafeer Puthalan on 14/04/19.
//  Copyright © 2019 Shafeer Puthalan. All rights reserved.
//

import Foundation
import FirebaseAuth
import Firebase
import GoogleSignIn
import FirebaseUI
import UIKit

struct FirebaseManager  {
    
    struct Database {
        
        static func getMeditions(completion: @escaping (_ result: [Meditation]?) -> Void){
            var meditaions = [Meditation]()
            let db = Firestore.firestore()
            let ref = db.collection(Constants.Firebase.MEDITATION)
            ref.getDocuments { (snap, error) in
                if error != nil {
                    completion(nil)
                    print(error)
                    return
                }
                for data in snap!.documents {
                    meditaions.append(Meditation(data: data.data(), documentId:data.documentID))
                    print(data.data())
                }
                completion(meditaions)
            }
            
        }
        static func getSession(session : String, completion : @escaping (_ result : Session?) -> Void) {
            
            let db = Firestore.firestore()
            let ref = db.collection(Constants.Firebase.MEDITATION).document(session).collection(Constants.Firebase.SESSION);
            ref.getDocuments { (snap, error) in
                if error != nil {
                    completion(nil)
                    return
                }
                for data in snap!.documents {
                    completion(Session(data: data.data()))
                }
            }
        }
    }
        
}

