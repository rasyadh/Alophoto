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
 Class used to handle stored Data using Repository pattern.
 */
class Storify: NSObject {
    static let shared = Storify()
    
    // Paging
    var page = [String: JSON]()
    
    func store(_ data: JSON, _ meta: JSON) {
        page["page"] = meta
        Notify.post(name: NotifName.get, sender: self, userInfo: ["success": true])
    }
}
