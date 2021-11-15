//
//  Api.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import Foundation
import Alamofire

class API {
    static let shared = API()
    
    enum Constants {
        static let baseURL = "https://api.github.com"
        static let searchUserURL = "/search/users"
    }
}

extension API {
    func searchUser(text: String, completion: @escaping([SearchUserDTO.UserProfile]) -> Void) {
        let tempItems: [SearchUserDTO.UserProfile] = []
        let url = Constants.baseURL + Constants.searchUserURL
        
        AF.request(url, method: .get, parameters: SearchUserDTO.Request(query: text).toDictionary, encoding: URLEncoding.queryString).responseDecodable(of: SearchUserDTO.Response.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.items)
            case .failure(let error):
                print(error.localizedDescription)
                completion(tempItems)
            }
        }
    }
}
