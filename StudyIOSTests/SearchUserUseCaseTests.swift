//
//  SearchUserUseCaseTests.swift
//  StudyIOSTests
//
//  Created by 홍필화 on 2021/11/30.
//

import XCTest
@testable import StudyIOS

class MockSearchUserRepository: SearchUserRepository {
    
    var searchUserCallsCount = 0
    var repo: [SearchUserDTO.UserProfile]?
    var searchUsersError: StudyError?
    
    func searchUser(text: String, completion: @escaping ([SearchUserDTO.UserProfile]?, StudyError?) -> Void) {
        searchUserCallsCount += 1
        completion(repo, searchUsersError)
    }
}

class SearchUserUseCaseTests: XCTestCase {

    var useCase: SearchUserUseCase!
    var repo: MockSearchUserRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = MockSearchUserRepository()
        useCase = SearchUserUseCase(repository: repo)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        repo = nil
        useCase = nil
    }
}

extension SearchUserUseCaseTests {
    func testSearchWithEmptyKeyword() {
        // given
        let expectation = expectation(description: #function)
        let expectedError = StudyError.emptyKeywordError
        let expectedCallsCount = 0
        repo.searchUsersError = .emptyKeywordError
        
        // when
        useCase.searchUser(text: "") { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTAssertEqual(expectedError, error)
                expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(expectedCallsCount, repo.searchUserCallsCount)
    }
    
    func testSearchWithError() {
        // given
        let expectation = expectation(description: #function)
        let expectedError = StudyError.internalError(message: "error")
        let expectedCallsCount = 1
        repo.searchUsersError = .internalError(message: "error")
        
        // when
        useCase.searchUser(text: "dd") { result in
            switch result {
            case .success:
                break
            case .failure(let error):
                XCTAssertEqual(expectedError, error)
                expectation.fulfill()
            }
        }
        
        // then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(expectedCallsCount, repo.searchUserCallsCount)
    }
    
    func testSearchSuccess() {
        // given
        let expectation = expectation(description: #function)
        let expectedCallsCount = 1
        let expectedUsers: [SearchUserDTO.UserProfile] = [.init(name: "ph7164", profileUrl: ""),
                                                          .init(name: "ph", profileUrl: "")]
        repo.repo = expectedUsers
        
        // when
        var resultUsers: [UserModel]?
        useCase.searchUser(text: "dd") { result in
            switch result {
            case .success(let users):
                resultUsers = users
                expectation.fulfill()
            case .failure:
                break
            }
        }
        
        // then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(expectedCallsCount, repo.searchUserCallsCount)
        XCTAssertEqual(expectedUsers.count, resultUsers?.count)
    }
}
