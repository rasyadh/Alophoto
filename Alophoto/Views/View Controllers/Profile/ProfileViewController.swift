//
//  ProfileViewController.swift
//  Alophoto
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import SVProgressHUD

class ProfileViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var logoutButton: UIButton!
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "profileView"
        navigationItem.title = Localify.get("profile.title")
        subviewSettings()
    }
    
    override func viewWillLayoutSubviews() {
        super.viewWillLayoutSubviews()
        
        imageContent.setRoundedCorner(isCircular: true)
    }
    
    // MARK: - IBAction
    @IBAction func logoutTouchUpInside(_ sender: Any) {
        Alertify.customConfirmation(title: Localify.get("alertify.logout"), message: "", confirmTitle: Localify.get("alertify.ok"), cancelTitle: Localify.get("alertify.cancel"), sender: self, isDestructive: true, confirmCallback: {
            Storify.shared.handleSuccessfullLogout()
            self.managerViewController?.showLoginScreen(isFromLogout: true)
        }, cancelCallback: nil)
    }
    
    // MARK: - Functions
    private func subviewSettings() {
        if let user = UserDefaults.standard.dictionary(forKey: Preferences.userData) {
            nameLabel.text = "User\((user["userId"] as! Int))"
            emailLabel.text = (user["email"] as! String)
        }
        imageContent.image = UIImage(named: "tab_user_active")?.withRenderingMode(.alwaysTemplate)
        imageContent.tintColor = UIColor.accent
        logoutButton.setTitle(Localify.get("profile.button.logout").uppercased(), for: .normal)
    }
}
