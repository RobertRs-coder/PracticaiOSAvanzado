//
//  NetworkModelTests.swift
//  PracticaFundamentosiOSTests
//
//  Created by Roberto Rojo Sahuquillo on 16/9/22.
//

import XCTest

@testable import PracticaFundamentosiOS

enum ErrorMock: Error {
    case mockCase
}

final class NetworkModelTests: XCTestCase {
    private var urlSessionMock: URLSessionMock!
    //sut -> System under testing
    private var sut: NetworkModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        urlSessionMock = URLSessionMock()
        sut = NetworkModel(urlSession: urlSessionMock)
    }
    
    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        sut = nil
    }
    
    func testLoginFailWithNoData() {
        //Given
        var error: NetworkError?
        
        urlSessionMock.data = nil
        
        //When
        sut.login(user: "", password: "") { _, networkError in
            error = networkError
        }
        
        //Then
        XCTAssertEqual(error, .noData)
    }
    
    func testLoginFailWithError() {
            //Given
            var error: NetworkError?
            
            urlSessionMock.data = nil
            urlSessionMock.error = ErrorMock.mockCase
            
            //When
            sut.login(user: "", password: "") { _, networkError in
                error = networkError
            }
        
            //Then
            XCTAssertEqual(error, .otherError)
        }
    
    
    func testLoginFailWithErrorCodeNil() {
            //Given
            var error: NetworkError?
            
            urlSessionMock.data = "TokenString".data(using: .utf8)!
            urlSessionMock.response = nil
            
            //When
            sut.login(user: "", password: "") { _, networkError in
                error = networkError
            }
        
            //Then
            XCTAssertEqual(error, .errorCode(nil))
        }
    
    func testLoginFailWithErrorCode() {
            //Given
            var error: NetworkError?
            
            urlSessionMock.data = "TokenString".data(using: .utf8)!
            urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 404, httpVersion: nil, headerFields: nil)
            
            //When
            sut.login(user: "", password: "") { _, networkError in
                error = networkError
            }
        
            //Then
            XCTAssertEqual(error, .errorCode(404))
        }
    
    
        
    func testLoginSuccessWithMockToken() throws {
        //Given
        var retrievedToken: String?
        var error: NetworkError?
        
        urlSessionMock.data = "TokenString".data(using: .utf8)!
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        //When
        sut.login(user: "", password: "") { token, networkError in
            retrievedToken = token
            error = networkError
        }

        //Then
        XCTAssertNotNil(retrievedToken, "Should have received a token")
        XCTAssertNil(error, "Should no be an error")
    }

    func testGetHeroesSuccess() {
    
        var retrievedHeroes: [Hero]?
        var error: NetworkError?
        
        //Given
        sut.token = "TokenString"
        urlSessionMock.data = getHeroesData()
        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)

        //When
        sut.getHeroes { heroes, networkErrror in
            retrievedHeroes = heroes
            error = networkErrror
        }
        
        //Then
        XCTAssertNotNil(urlSessionMock.data)
        XCTAssertTrue(retrievedHeroes?.count ?? 0 > 0, "Should have received heroes")
        XCTAssertNil(error, "Should no be an error")
        }

//    func testGetTransformationsSuccess() {
//        
//        var retrievedTransformations: [Transformation]?
//        var error: NetworkError?
//        
//        //Given
//        sut.token = "TokenString"
//        urlSessionMock.data = getTransformationsData()
//        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
//        
//        //When
//        sut.getTransformations(id: "") { transformations, networkError in
//            retrievedTransformations = transformations
//            error = networkError
//            
//        }
//            //Then
//            XCTAssertNotNil(urlSessionMock.data)
//            XCTAssertTrue(retrievedTransformations?.count ?? 0 > 0, "Should have received transformations")
//            XCTAssertNil(error, "Should no be an error")
//        }

    
//    func testGetTransformationsSuccess() {
//
//        var retrievedTransformations: [Transformation]?
//        var error: NetworkError?
//        var hero: Hero
//
//        //Given
//        sut.token = "TokenString"
//        urlSessionMock.data = getTransformationsData()
//        urlSessionMock.response = HTTPURLResponse(url: URL(string: "http")!, statusCode: 200, httpVersion: nil, headerFields: nil)
//
//        //When
//
//        sut.getDataApi(id: "D13A40E5-4418-4223-9CE6-D2F9A28EBE94", type: [Transformation].self, completion: {result in
//            switch result {
//
//                case .success(transformations):
//                    retrievedTransformations = transformations
//
//                case .failure(let error):
//                    print("There is an error: \(error)")
//                    break
//            }
//        })
//
//            //Then
//            XCTAssertNotNil(urlSessionMock.data)
//            XCTAssertTrue(retrievedTransformations?.count ?? 0 > 0, "Should have received tranformations")
//            XCTAssertNil(error, "Should no be an error")
//        }
        
}


extension NetworkModelTests {
    
    func getHeroesData() -> Data? {
        
        let bundle = Bundle(for: NetworkModelTests.self)
        
        guard let path = bundle.path(forResource: "heroes", ofType: "json") else { return nil}
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
    
    func getTransformationsData() -> Data? {
        
        let bundle = Bundle(for: NetworkModelTests.self)
        
        guard let path = bundle.path(forResource: "transformations", ofType: "json") else { return nil}
        
        return try? Data(contentsOf: URL(fileURLWithPath: path), options: .mappedIfSafe)
    }
}
