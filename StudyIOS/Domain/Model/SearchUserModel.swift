//
//  SearchUserModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation

struct UserModel {
    var name: String
    var profileUrl: String
    
    init() {
        self.init(name: "", profileUrl: "")
    }
    
    init(name: String,
         profileUrl: String) {
        self.name = name
        self.profileUrl = profileUrl
    }
}
