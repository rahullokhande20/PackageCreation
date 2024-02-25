//
//  MockNetworkService.swift
//  FindMyIPTests
//
//  Created by Rahul Lokhande on 09/01/24.
//

import Foundation
@testable import FindMyIP
class MockNetworkService: APIService {
    var mockIPInfo: IPResponse?
    var mockError: Error?

    func fetchIPInfo() async throws -> IPResponse {
        if let error = mockError {
            throw error
        }
        return mockIPInfo ?? IPResponse(ip: "Invalid ip", city: "invalid city")
    }
}
