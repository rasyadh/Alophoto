//
//  PhotoCardTableViewCell.swift
//  Alophoto
//
//  Created by Twiscode on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

class PhotoCardTableViewCell: UITableViewCell {
    
    // MARK: - IBOutlets
    @IBOutlet weak var cardView: UIView!
    @IBOutlet weak var imageContent: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var cardViewBottomConstraint: NSLayoutConstraint!
    
    var indexPath: IndexPath!
    var photos = [Photo]()
    var photo: Photo! {
        didSet {
            guard let indexPath = indexPath else { return }
            guard let photo = photo else { return }
            
            imageContent.kf.indicatorType = .activity
            imageContent.kf.setImage(with: URL(string: photo.coverPhoto))
            titleLabel.text = photo.title
            if indexPath.row == photos.count - 1 {
                cardViewBottomConstraint.constant = 0
            }
        }
    }
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        imageContent.image = nil
        titleLabel.text = ""
        cardViewBottomConstraint.constant = 20.0
    }
}
