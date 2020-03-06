//
//  Storify.swift
//  Alophoto
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import SwiftyJSON

/**
 UserDefaults Identifier.
 */
struct Preferences {
    static let isLoggedIn = "is_logged_in"
    static let userData = "user_data"
}

/**
 Class used to handle stored Data using Repository pattern.
 */
class Storify: NSObject {
    static let shared = Storify()
    
    // Paging
    var page = [String: JSON]()
    
    var photos = [Photo]()
    
    // MARK: Authentications
    func handleSuccessfullLogin(email: String) {
        storeUserData(email)
    }
    
    func handleSuccessfullLogout() {
        let pref = UserDefaults.standard
        pref.set(false, forKey: Preferences.isLoggedIn)
        pref.removeObject(forKey: Preferences.userData)
        removeData()
    }
    
    private func storeUserData(_ email: String) {
        let pref = UserDefaults.standard
        pref.set(true, forKey: Preferences.isLoggedIn)
        let userData = [
            "userId": Int.random(in: 0..<1000),
            "email": email,
            ] as [String : Any]
        pref.set(userData, forKey: Preferences.userData)
    }
    
    private func removeData() {
        photos.removeAll()
    }
    
    func storePhotosCollection(_ data: JSON) {
        photos = data.arrayValue.map { Photo($0) }
        Notify.post(name: NotifName.getPhotosCollection, sender: self, userInfo: ["success": true])
    }
}
