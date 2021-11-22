//
//  Api.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/15.
//

import Foundation
import Alamofire

enum StudyError: Error {
    case internalError(message: String)
    case networkError(message: String)
}

class API: SearchUserRepository {
    
    static let shared = API()
    
    enum Constants {
        static let baseURL = "https://api.github.com"
        static let searchUserURL = "/search/users"
    }
}

extension API {
    func searchUser(text: String, completion: @escaping([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
        let url = Constants.baseURL + Constants.searchUserURL
        AF.request(url, method: .get,
                   parameters: SearchUserDTO.Request(query: text).toDictionary,
                   encoding: URLEncoding.queryString).responseDecodable(of: SearchUserDTO.Response.self) { response in
            switch response.result {
            case .success(let data):
                completion(data.items, nil)
            case .failure(let error):
                completion(nil, .networkError(message: error.localizedDescription))
            }
        }
    }
    
}
