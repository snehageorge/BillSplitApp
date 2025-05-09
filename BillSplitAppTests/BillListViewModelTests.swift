//
//  BillListViewModelTests.swift
//  BillSplitAppTests
//
//  Created by Sneha on 09/05/25.
//

import XCTest

@testable import BillSplitApp

@MainActor
final class BillListViewModelTests: XCTestCase {

    var viewModel: BillListViewModel!
    
    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.
        viewModel = BillListViewModel(billLoader: MockBillLoader())
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
        viewModel = nil
    }
    
    func testFetchBillsLoadsMockData() async throws {
        XCTAssertTrue(viewModel.bills.isEmpty)
        
        await viewModel.fetchBills()
        
        XCTAssertEqual(viewModel.bills.count, 1)
        XCTAssertEqual(viewModel.bills.first?.shopName, "Pizza Hut")
    }

}
