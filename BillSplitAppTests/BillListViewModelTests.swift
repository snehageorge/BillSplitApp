//
//  BillListViewModelTests.swift
//  BillSplitAppTests
//
//  Created by Sneha on 09/05/25.
//

import XCTest
@testable import BillSplitApp

final class BillListViewModelTests: XCTestCase {

    var viewModel: BillListViewModel!
    
    override func setUpWithError() throws {
        viewModel = BillListViewModel(billLoader: MockBillProvider())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testFetchBillsLoadsMockData() async throws {
        XCTAssertTrue(viewModel.bills.isEmpty)
        
        await viewModel.fetchBills()
        
        XCTAssertEqual(viewModel.bills.count, 1)
        XCTAssertEqual(viewModel.bills.first?.shopName, "Pizza Hut")
    }

}
