//
//  MockBillLoader.swift
//  BillSplitApp
//
//  Created by Sneha on 09/05/25.
//

import Foundation
@testable import BillSplitApp

struct MockBillLoader: BillLoader {
    var mockBills: [Bill] = [.mock]
    var shouldThrowError = false
    
    func loadBills() async throws -> [BillSplitApp.Bill] {
        if shouldThrowError {
            throw MockError.failedToLoad
        }
        return mockBills
    }

    
}
