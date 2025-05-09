//
//  StaticBillProvider.swift
//  BillSplitApp
//
//  Created by Sneha on 09/05/25.
//
import Foundation

struct StaticBillProvider: BillLoader {
    func loadBills() async throws -> [Bill] {
        guard let url = Bundle.main.url(forResource: "bills", withExtension: "json") else {
            throw Errors.fileNotFound
        }
        do {
            let data = try Data(contentsOf: url)
            let decodedResponse = try JSONDecoder().decode(BillResponse.self, from: data)
            return decodedResponse.bills
        } catch {
            throw Errors.decodingFailed
        }
    }
}
