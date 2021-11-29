//
//  SearchUserUseCase.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation

protocol SearchUserUseCaseType {
    func searchUser(text: String, completion: @escaping([UserModel]?, StudyError?) -> Void)
}

class SearchUserUseCase: SearchUserUseCaseType {
    
    private let repository: SearchUserRepository
    
    init(repository: SearchUserRepository) {
        self.repository = repository
    }
    
    func searchUser(text: String, completion: @escaping ([UserModel]?, StudyError?) -> Void) {
        repository.searchUser(text: text) { (result, error) in
            guard error == nil else {
                completion(nil, error)
                return
            }
            guard let result = result else { return }
            let userModels = result.map { $0.toDomain() }
            completion(userModels, nil)
        }
    }
}
