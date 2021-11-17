//
//  SearchUserModel.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation
import Alamofire

protocol SearchUserModelProtocol {
    func searchUser(text: String, completion: @escaping([SearchUserDTO.UserProfile]?, AFError?) -> Void)
}

class SearchUserModel: SearchUserModelProtocol {
    
    func searchUser(text: String, completion: @escaping([SearchUserDTO.UserProfile]?, AFError?) -> Void) {
        API.shared.searchUser(text: text) { (result, err) in
            if err == nil {
                if !result!.isEmpty {
                    completion(result, nil)
                }
            } else {
                completion(nil, err)
            }
            
        }
        
    }
}
