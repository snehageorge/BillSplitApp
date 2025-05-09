//
//  BillLoader.swift
//  BillSplitApp
//
//  Created by Sneha on 09/05/25.
//

protocol BillLoader {
    func loadBills() async throws -> [Bill]
}
