//
//  SearchUserUseCase.swift
//  StudyIOS
//
//  Created by 홍필화 on 2021/11/17.
//

import Foundation

protocol SearchUserUseCaseType {
    func searchUser(text: String, completion: @escaping(Result<[UserModel], StudyError>) -> Void)
}

class SearchUserUseCase: SearchUserUseCaseType {
    
    private let repository: SearchUserRepository
    
    init(repository: SearchUserRepository) {
        self.repository = repository
    }
    
    func searchUser(text: String, completion: @escaping (Result<[UserModel], StudyError>) -> Void) {
        repository.searchUser(text: text) { (result, error) in
            if let err = error {
                completion(.failure(err))
                return
            }
            
            if let result = result {
                completion(.success(result.map { $0.toDomain() }))
                return
            }
        }
    }
}
