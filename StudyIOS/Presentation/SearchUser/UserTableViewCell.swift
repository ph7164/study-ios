//
//  UserTableViewCell.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import UIKit

class UserTableViewCell: UITableViewCell {
    
    @IBOutlet private weak var profileImageView: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!

    override func awakeFromNib() {
        super.awakeFromNib()
        self.selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
    }
    
    override func prepareForReuse() {
        profileImageView.image = nil
        nameLabel.text = ""
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
