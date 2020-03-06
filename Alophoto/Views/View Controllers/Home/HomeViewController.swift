//
//  HomeViewController.swift
//  Alophoto
//
//  Created by Rasyadh Abdul Aziz on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit
import SVProgressHUD
import Lightbox

class HomeViewController: UIViewController {

    // MARK: - IBOutlets
    @IBOutlet weak var tableView: UITableView!
    
    // MARK: - Outlet Instance
    var refreshControl = UIRefreshControl()
    
    // MARK: - Variables
    var photos = [Photo]() {
        didSet {
            tableView.reloadData()
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        view.accessibilityIdentifier = "homeView"
        navigationItem.title = Localify.get("app.name")
        
        refreshControl.addTarget(self, action: #selector(refreshData(_:)), for: .valueChanged)
        tableView.addSubview(refreshControl)
        tableView.register(
            UINib(nibName: "PhotoCardTableViewCell", bundle: nil), forCellReuseIdentifier: "photoCardCell")
        tableView.dataSource = self
        tableView.delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        Notify.shared.listen(
            self,
            selector: #selector(photosReceived(_:)),
            name: NotifName.getPhotosCollection,
            object: nil)
        Apify.shared.getPhotosCollection()
        SVProgressHUD.show()
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        
        SVProgressHUD.dismiss()
        Notify.shared.removeListener(self)
    }
    
    // MARK: - Notification Handler
    @objc func photosReceived(_ notification: Notification) {
        SVProgressHUD.dismiss()
        if refreshControl.isRefreshing { refreshControl.endRefreshing() }
        if notification.userInfo!["success"] as! Bool {
            photos = Storify.shared.photos
        } else {
            Alertify.showErrorMessage(sender: self, manager: managerViewController, notification: notification)
        }
    }
    
    // MARK: - Selector
    @objc private func refreshData(_ sender: UIRefreshControl) {
        if sender.isRefreshing {
            Apify.shared.getPhotosCollection()
        }
    }
    
    // MARK: - Functions
    private func setImagePreview(previewPhotos: [String]) -> [LightboxImage] {
        return previewPhotos.map { LightboxImage(imageURL: URL(string: $0)!) }
    }
}

// MARK: - UITableViewDataSource
extension HomeViewController: UITableViewDataSource {
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if photos.isEmpty {
            tableView.setEmptyView(
                title: Localify.get("empty_state.home.title"))
        } else {
            tableView.restore(style: .none)
        }
        return photos.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        return createPhotoCard(tableView, indexPath)
    }
    
    func createPhotoCard(_ tableView: UITableView, _ indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(
            withIdentifier: "photoCardCell", for: indexPath)
            as! PhotoCardTableViewCell
        
        cell.indexPath = indexPath
        cell.photos = photos
        cell.photo = photos[indexPath.row]
        cell.selectionStyle = .none
        
        return cell
    }
}

// MARK: - UITableViewDelegate
extension HomeViewController: UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let lightbox = LightboxController(images:
            setImagePreview(previewPhotos: photos[indexPath.row].previewPhotos))
        lightbox.dynamicBackground = true
        lightbox.modalPresentationStyle = .fullScreen
        present(lightbox, animated: true, completion: nil)
        tableView.deselectRow(at: indexPath, animated: true)
    }
}
