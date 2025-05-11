//
//  TestBillLoaderFactory.swift
//  BillSplitApp
//
//  Created by Sneha on 10/05/25.
//

import Foundation

enum TestBillLoaderFactory {
    static func make() -> BillLoader {
        return MockBillProvider()
    }
}
