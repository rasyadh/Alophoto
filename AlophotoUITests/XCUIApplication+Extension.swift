//
//  XCUIApplication+Extension.swift
//  AlophotoUITests
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import XCTest

extension XCTestCase {
    func get(bundle: Bundle, _ key: String) -> String {
        return NSLocalizedString(key, bundle: bundle, comment: "")
    }
    
    func setLocalizableTest() -> Bundle {
        let localeLanguage = String(Locale.preferredLanguages.first!.prefix(2))
        var language: LanguageName!
        switch localeLanguage {
        case LanguageName.english.rawValue:
            language = LanguageName.english
        default:
            language = LanguageName.english
        }
        
        let bundle =  Bundle(for: type(of: self))
        bundle.path(forResource: language.rawValue, ofType: ".lproj")
        return bundle
    }
}

extension XCUIApplication {
    var isDisplayingLogin: Bool {
        return otherElements["loginView"].exists
    }
    
    var isDisplayingHome: Bool {
        return otherElements["homeView"].exists
    }
    
    var isDisplayingProfile: Bool {
        return otherElements["profileView"].exists
    }
}
