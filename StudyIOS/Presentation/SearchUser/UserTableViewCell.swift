//
//  UserTableViewCell.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet weak var profileImageView: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}

extension UserTableViewCell {
    func setProfile(imgUrl: String, name: String) {
        if let url = URL(string: imgUrl) {
            let data = try? Data(contentsOf: url)
            profileImageView.image = UIImage(data: data!)
        }
        nameLabel.text = name
    }
}
