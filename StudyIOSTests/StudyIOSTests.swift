//
//  StudyIOSTests.swift
//  StudyIOSTests
//
//  Created by 홍필화 on 2021/11/15.
//

import XCTest
@testable import StudyIOS

class StudyIOSTests: XCTestCase {
    
    var model: SearchUserModel?

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        model = SearchUserModel()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }

    func testPerformanceExample() throws {
        // This is an example of a performance test case.
        self.measure {
            // Put the code you want to measure the time of here.
        }
    }

}

extension StudyIOSTests {
    func testSearchWithEmptyKeyword_thenEmptyResult() {
        // given
        let expectedResultCount = 0
        let expectedWasCalled = ""
        
        // when
        model?.searchUser(text: "") { (result, err) in
            if err == nil {
                
            }
        }
        
        // then
//        XCTAssertEqual(expectedKeyword, sut.keyword)
//        XCTAssertEqual(expectedResultCount, sut.result.count)
    }
    
    func testSearchWithUserName() {
        // given
        let expectedResultCount = 1
        let usersExpectation = expectation(description: "users")
        var usersResponse: [SearchUserDTO.UserProfile]?
        
        // when
        model?.searchUser(text: "jayce1116") { (result, err) in
            if err == nil {
                usersResponse = result
                usersExpectation.fulfill()
            }
        }
        // then
        waitForExpectations(timeout: 2) { error in
            if error == nil {
                XCTAssertEqual(expectedResultCount, usersResponse?.count)
            }
        }
    }
    
    func testSearchWithUserName_thenUnexpectedError() {
        // given
        /// TBD
        
        // when
        /// TBD
        
        // then
        /// TBD
    }
}
