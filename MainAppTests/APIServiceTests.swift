//
//  APIServiceTests.swift
//  FindMyIPTests
//
//  Created by Rahul Lokhande on 09/01/24.
//

import XCTest

import XCTest
@testable import FindMyIP

class APIServiceTests: XCTestCase {

    func testFetchIPInfoSuccess() async throws {
        let mockService = MockNetworkService()
        mockService.mockError = nil
        mockService.mockIPInfo = IPResponse(ip: "127.0.0.1", city: "Mock City")

        let ipInfo = try await mockService.fetchIPInfo()

        XCTAssertEqual(ipInfo.ip, "127.0.0.1")
        XCTAssertEqual(ipInfo.city, "Mock City")
    }

    func testFetchIPInfoFailure() async {
        let mockService = MockNetworkService()
        mockService.mockError = NSError(domain: "com.FindMyIp.error", code: 0, userInfo: nil)

        do {
            _ = try await mockService.fetchIPInfo()
            XCTFail("Expected an error, but the call succeeded")
        } catch {
            // Test passes if an error is thrown
        }
    }
}
