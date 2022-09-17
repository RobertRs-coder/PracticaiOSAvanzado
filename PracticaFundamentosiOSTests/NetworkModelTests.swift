//
//  NetworkModelTests.swift
//  PracticaFundamentosiOSTests
//
//  Created by Roberto Rojo Sahuquillo on 16/9/22.
//

import XCTest

@testable import PracticaFundamentosiOS

final class NetworkModelTests: XCTestCase {
    //sut -> System under testing
    private var sut: NetworkModel!

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        sut = NetworkModel ()
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }

    func testLoginSuccess() throws {
        let expectation = expectation(description: "Login Success")
        var retrievedToken: String?
        var error: NetworkError?
        
        sut.login(user: "rrojo.va@gmail.com", password: "123456") { token, networkError in
            retrievedToken = token
            error = networkError
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNotNil(retrievedToken, "Should have received a token")
        XCTAssertNil(error, "Should no be an error")
    }
    
    func testLoginFail() throws {
        let expectation = expectation(description: "Login Fail")
        var retrievedToken: String?
        var error: NetworkError?
        
        sut.login(user: "", password: "") { token, networkError in
            retrievedToken = token
            error = networkError
            expectation.fulfill()
        }
        waitForExpectations(timeout: 5)
        XCTAssertNil(retrievedToken, "Should have not received a token")
        XCTAssertNotNil(error, "Should be an error")
        
    }
    
    

}
