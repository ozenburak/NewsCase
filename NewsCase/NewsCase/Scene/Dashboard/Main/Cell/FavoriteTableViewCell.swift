//
//  FavoriteTableViewCell.swift
//  NewsCase
//
//  Created by burak ozen on 21.02.2022.
//

import UIKit

class FavoriteTableViewCell: UITableViewCell {

    @IBOutlet weak var favoriteTitleLabel: UILabel!
    @IBOutlet weak var favoriteExplainLabel: UILabel!
    @IBOutlet weak var favoriteImageView: UIImageView!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
