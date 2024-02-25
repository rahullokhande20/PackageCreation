//
//  IPInfoViewModelTests.swift
//  FindMyIPTests
//
//  Created by Rahul Lokhande on 09/01/24.
//
import XCTest
@testable import FindMyIP

class IPInfoViewModelTests: XCTestCase {
    var viewModel: IPInfoViewModel!
    var mockNetworkService: MockNetworkService!

    override func setUp() {
        super.setUp()
        mockNetworkService = MockNetworkService()
        viewModel = IPInfoViewModel(service:  mockNetworkService)
    }

    override func tearDown() {
        viewModel = nil
        mockNetworkService = nil
        super.tearDown()
    }

    func testFetchIPInfoSuccess() {
        let expectation = XCTestExpectation(description: "fetchIPInfo succeeds")

        // Mock success response
        let expectedIPInfo = IPResponse(ip: "127.0.0.1", city: "Test City")
        mockNetworkService.mockIPInfo = expectedIPInfo

        viewModel.fetchIPInfo()

        // Wait for async task to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertEqual(self.viewModel.ipInfo, expectedIPInfo)
            XCTAssertFalse(self.viewModel.isLoading)
            XCTAssertNil(self.viewModel.errorMessage)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }

    func testFetchIPInfoFailure() {
        let expectation = XCTestExpectation(description: "fetchIPInfo fails")

        // Mock failure response
        let expectedError = NSError(domain: "TestError", code: -1, userInfo: nil)
        mockNetworkService.mockError = expectedError

        viewModel.fetchIPInfo()

        // Wait for async task to complete
        DispatchQueue.main.asyncAfter(deadline: .now() + 1) {
            XCTAssertNotNil(self.viewModel.errorMessage)
            XCTAssertFalse(self.viewModel.isLoading)
            expectation.fulfill()
        }

        wait(for: [expectation], timeout: 2)
    }
}
