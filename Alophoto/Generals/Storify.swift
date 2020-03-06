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
        pref.set(false, forKey: Preferences.isLoggedIn)
        pref.set(email, forKey: Preferences.userData)
    }
    
    private func removeData() {
        
    }
    
    func storePhotosCollection(_ data: JSON, _ meta: JSON) {
        page["photosCollection"] = meta
        Notify.post(name: NotifName.getPhotosCollection, sender: self, userInfo: ["success": true])
    }
}
