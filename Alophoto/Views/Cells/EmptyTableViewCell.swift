//
//  EmptyTableViewCell.swift
//  Alophoto
//
//  Created by Twiscode on 06/03/20.
//  Copyright © 2020 rasyadh. All rights reserved.
//

import UIKit

class EmptyTableViewCell: UITableViewCell {

    // MARK: - IBOutlet
    @IBOutlet weak var titleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

    }
    
    override func prepareForReuse() {
        super.prepareForReuse()
        
        titleLabel.text = ""
    }
}
