//
//  BillListViewModel.swift
//  BillSplitApp
//
//  Created by Sneha on 09/04/25.
//

import Foundation

@MainActor
class BillListViewModel: ObservableObject {
    @Published var bills = [Bill]()
    @Published var isLoading = false
    
    private let billLoader: BillLoader
    
    init(billLoader: BillLoader) {
        self.billLoader = billLoader
    }
    
    func fetchBills() async {
        isLoading = true
        defer {
            isLoading = false
        }
        
        do {
            bills = try await billLoader.loadBills()
        } catch {
            print("Failed to load bills: \(error)")
        }
        
    }
}
