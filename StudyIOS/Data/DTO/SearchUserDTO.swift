//
//  SearchUserDTO.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import Foundation

enum SearchUserDTO {
    struct Request: Codable {
        let query: String
        
        enum CodingKeys: String, CodingKey {
            case query = "q"
        }
    }
    
    struct Response: Codable {
        let items: [UserProfile]
    }
    
    struct UserProfile: Codable {
        let name: String
        let profileUrl: String
        
        enum CodingKeys: String, CodingKey {
            case name = "login"
            case profileUrl = "avatar_url"
        }
        
        func toDomain() -> UserModel {
            return .init(name: name, profileUrl: profileUrl)
        }
    }
}
