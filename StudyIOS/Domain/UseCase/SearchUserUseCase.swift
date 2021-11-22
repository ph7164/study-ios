//
//  SearchUserUseCase.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation

protocol SearchUserUseCaseType {
    func searchUser(text: String, completion: @escaping([SearchUserDTO.UserProfile]?, StudyError?) -> Void)
}

class SearchUserUseCase: SearchUserUseCaseType {
    
    private let repository: SearchUserRepository
    
    init(repository: SearchUserRepository) {
        self.repository = repository
    }
    
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
        repository.searchUser(text: text) { (result, err) in
            guard let result = result, !result.isEmpty else {
                completion(nil, nil)
                return
            }
            if err == nil {
                completion(result, nil)
            } else {
                completion(nil, err)
            }
            
        }
    }
    
    
}
