//
//  MockBillProvider.swift
//  BillSplitApp
//
//  Created by Sneha on 10/05/25.
//

import Foundation

#if DEBUG
struct MockBillProvider: BillLoader {
    var mockBills: [Bill] = [.mock]
    var shouldThrowError = false
    
    func loadBills() async throws -> [Bill] {
        if shouldThrowError {
            throw MockError.failedToLoad
        }
        print("🔧 Returning mock bills")
        return mockBills
    }
    
}
#endif
