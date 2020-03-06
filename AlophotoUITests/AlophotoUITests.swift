//
//  AlophotoUITests.swift
//  AlophotoUITests
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import XCTest

class AlophotoUITests: XCTestCase {

    var app: XCUIApplication!
    private var languageBundle: Bundle!
    
    override func setUp() {
        super.setUp()
        
        continueAfterFailure = false
        app = XCUIApplication()
        languageBundle = setLocalizableTest()
    }
    
    override func tearDown() {
        super.tearDown()
    }
    
    func testLoginInitialView() {
        app.launchArguments.append("--uitesting")
        app.launch()
        
        XCTAssertTrue(app.isDisplayingLogin)
    }
    
    func testLoginElements() {
        app.launchArguments.append("--uitesting")
        app.launch()
        
        let emailField = app.textFields[get(bundle: languageBundle, "login.field.email")]
        let passwordField = app.secureTextFields[
            get(bundle: languageBundle, "login.field.password")]
        let signinButton = app.buttons[get(bundle: languageBundle, "login.button.login").uppercased()]
        
        XCTAssertTrue(emailField.exists)
        XCTAssertTrue(passwordField.exists)
        XCTAssertTrue(signinButton.exists)
    }
    
    func testLoginShowingAlertWhenCredentialEmpty() {
        app.launchArguments.append("--uitesting")
        app.launch()
        
        let signinButton = app.buttons[get(bundle: languageBundle, "login.button.login").uppercased()]
        signinButton.tap()
        
        XCTAssertTrue(app.alerts[get(bundle: languageBundle, "field_validation.invalid.title")]
            .waitForExistence(timeout: 5))
    }
    
    func testLoginShowingAlertWhenEmailEmpty() {
        app.launchArguments.append("--uitesting")
        app.launch()
        
        let passwordField = app.secureTextFields[
            get(bundle: languageBundle, "login.field.password")]
        let signinButton = app.buttons[get(bundle: languageBundle, "login.button.login").uppercased()]
        
        passwordField.tap()
        passwordField.typeText("123456")
        signinButton.tap()
        
        XCTAssertTrue(app.alerts[get(bundle: languageBundle, "field_validation.invalid.title")]
            .waitForExistence(timeout: 5))
    }

    func testLoginShowingAlertWhenPasswordEmpty() {
        app.launchArguments.append("--uitesting")
        app.launch()
        
        let emailField = app.textFields[get(bundle: languageBundle, "login.field.email")]
        let signinButton = app.buttons[get(bundle: languageBundle, "login.button.login").uppercased()]
        
        emailField.tap()
        emailField.typeText("rasyadhabdulaziz@gmail.com")
        signinButton.tap()
        
        XCTAssertTrue(app.alerts[get(bundle: languageBundle, "field_validation.invalid.title")]
            .waitForExistence(timeout: 5))
    }
    
    func testLoginSuccessfull() {
        app.launchArguments.append("--uitesting")
        app.launch()
        
        let emailField = app.textFields[get(bundle: languageBundle, "login.field.email")]
        let passwordField = app.secureTextFields[
            get(bundle: languageBundle, "login.field.password")]
        let signinButton = app.buttons[get(bundle: languageBundle, "login.button.login").uppercased()]
        
        emailField.tap()
        emailField.typeText("rasyadhabdulaziz@gmail.com")
        passwordField.tap()
        passwordField.typeText("123456")
        signinButton.tap()
        
        let tabBarView = app.otherElements["tabBarView"]
        XCTAssert(tabBarView.waitForExistence(timeout: 5))
    }
    
    func testPhotoHomeView() {
        app.launch()
        
        XCTAssertTrue(app.isDisplayingHome)
    }
    
    func testPhotoHomeElement() {
        app.launch()
        
        let window = app.windows.element(boundBy: 0)
        let title = app.navigationBars[get(bundle: languageBundle, "app.name")]
        let tableView = app.tables
        
        XCTAssertTrue(title.exists)
        XCTAssert(window.frame.contains(tableView.accessibilityFrame))
    }
    
    func testProfileInitialView() {
        app.launch()
        
        app.tabBars.buttons[get(bundle: languageBundle, "profile.title")].tap()
        
        XCTAssertTrue(app.isDisplayingProfile)
    }
    
    func testProfileElements() {
        app.launch()
        
        app.tabBars.buttons[get(bundle: languageBundle, "profile.title")].tap()
        let title = app.navigationBars[get(bundle: languageBundle, "profile.title")]
        let image = app.images.element(boundBy: 0)
        let nameLabel = app.staticTexts.element(boundBy: 0)
        let emailLabel = app.staticTexts.element(boundBy: 1)
        let logoutButton = app.buttons[get(bundle: languageBundle, "profile.button.logout").uppercased()]
        
        XCTAssertTrue(title.exists)
        XCTAssertTrue(image.exists)
        XCTAssertTrue(nameLabel.exists)
        XCTAssertTrue(emailLabel.exists)
        XCTAssertTrue(logoutButton.exists)
    }
    
    func testProfileLogout() {
        app.launch()
        
        app.tabBars.buttons[get(bundle: languageBundle, "profile.title")].tap()
        let logoutButton = app.buttons[get(bundle: languageBundle, "profile.button.logout").uppercased()]
        let loginView = app.otherElements["loginView"]
        let exists = NSPredicate(format: "exists == true")
        expectation(for: exists, evaluatedWith: loginView, handler: nil)
        
        logoutButton.tap()
        app.alerts[get(bundle: languageBundle, "alertify.logout")]
            .scrollViews.otherElements.buttons[get(bundle: languageBundle, "alertify.ok")].tap()
        
        waitForExpectations(timeout: 5, handler: nil)
        XCTAssert(loginView.exists)
    }

    func testZLaunchPerformance() {
        if #available(iOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTOSSignpostMetric.applicationLaunch]) {
                XCUIApplication().launch()
            }
        }
    }
}
