//
//  LocalDataModelTests.swift
//  PracticaFundamentosiOSTests
//
//  Created by Roberto Rojo Sahuquillo on 16/9/22.
//

import XCTest

@testable import PracticaiOSAvanzado

final class LocalDataModelTests: XCTestCase {
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        LocalDataModel.deleteToken()
    }
    
    func testSaveToken() throws {
        //Given
        let storedToken = "TestToken"
        //When
        LocalDataModel.saveToken(token: storedToken)
        //Then
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertEqual(retrievedToken, storedToken, "Retrieved token doesn't match stored token")
    }
    
    func testGetTokenWhenNoTokenSaved() throws {
        //Given
        
        //When
        
        //Then
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertNil(retrievedToken, "There should be no saved token")
    }
    
    func testDeleteToken() throws {
        //Given
        let storedToken = "TestToken"
        LocalDataModel.saveToken(token: storedToken)
        //When
        LocalDataModel.deleteToken()
        //Then
        let retrievedToken = LocalDataModel.getToken()
        XCTAssertNil(retrievedToken, "There should be no saved token")
    }
    
}
