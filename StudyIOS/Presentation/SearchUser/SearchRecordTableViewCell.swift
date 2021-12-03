//
//  SearchRecordTableViewCell.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/12/01.
//

import UIKit

class SearchRecordTableViewCell: UITableViewCell {
    
    @IBOutlet weak var searchRecordLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
        selectionStyle = .none
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    override func prepareForReuse() {
        searchRecordLabel.text = ""
    }
    
}

extension SearchRecordTableViewCell {
    func setData(keyword: String) {
        searchRecordLabel.text = keyword
    }
}
