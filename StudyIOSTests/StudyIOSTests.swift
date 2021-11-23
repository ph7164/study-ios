//
//  StudyIOSTests.swift
//  StudyIOSTests
//
//  Created by 홍필화 on 2021/11/15.
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

class StudyIOSTests: XCTestCase {
    var sut: SearchUserUseCase!
    var repo: MockSearchUserRepository!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        repo = MockSearchUserRepository()
        sut = SearchUserUseCase(repository: repo)
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
        repo = nil
    }

}

extension StudyIOSTests {
    
    func testSearchWithEmptyKeyword() {
        // given
        let expectation = expectation(description: #function)
        let expectedError = StudyError.emptyKeywordError
        let expectedCallsCount = 0
        repo.searchUsersError = .emptyKeywordError
        
        // when
        sut.searchUser(text: "") { (result, err) in
            // then
            XCTAssertNil(result)
            XCTAssertEqual(expectedError, err)
            expectation.fulfill()
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
        sut.searchUser(text: "dd") { (result, err) in
            // then
            XCTAssertNil(result)
            XCTAssertEqual(expectedError, err)
            expectation.fulfill()
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
        var resultUsers: [SearchUserDTO.UserProfile]?
        sut.searchUser(text: "ss") { (result, err) in
            // then
            resultUsers = result
            XCTAssertNil(err)
            expectation.fulfill()
        }
        
        // then
        wait(for: [expectation], timeout: 2)
        XCTAssertEqual(expectedCallsCount, repo.searchUserCallsCount)
        XCTAssertEqual(expectedUsers.count, resultUsers?.count)
    }
    
}
