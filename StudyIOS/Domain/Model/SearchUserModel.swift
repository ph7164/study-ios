//
//  SearchUserModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation

struct UserModel: Equatable {
    var name: String
    var profileUrl: String
    
    init(name: String,
         profileUrl: String) {
        self.name = name
        self.profileUrl = profileUrl
    }
}
