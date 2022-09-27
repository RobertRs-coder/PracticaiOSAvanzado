//
//  URLSessionMock.swift
//  PracticaFundamentosiOSTests
//
//  Created by Roberto Rojo Sahuquillo on 17/9/22.
//

import Foundation


class URLSessionMock: URLSession {
    override init() {}
    
    var data: Data?
    var response: URLResponse?
    var error: Error?
    
    override func dataTask(with request: URLRequest, completionHandler: @escaping (Data?, URLResponse?, Error?) -> Void) -> URLSessionDataTask {
        return URLSessionDataTaskMock {
            completionHandler(self.data, self.response, self.error)
        }
    }
}


class URLSessionDataTaskMock: URLSessionDataTask {
    private let clousure: () -> Void
    
    init(clousure: @escaping () -> Void) {
        self.clousure = clousure
    }
    
    override func resume() {
        clousure()
    }
}
