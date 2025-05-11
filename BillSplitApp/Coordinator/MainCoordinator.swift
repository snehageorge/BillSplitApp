//
//  MainCoordinator.swift
//  BillSplitApp
//
//  Created by Sneha on 10/04/25.
//

import SwiftUI

final class MainCoordinator: ObservableObject {
    @Published var path = NavigationPath()
    @Published var selectedTab: Tab = .bills
    
    enum Tab {
        case bills, documents, scan, chat, profile
    }
    
    private let billLoader: BillLoader
    
    init() {
    #if DEBUG
        if ProcessInfo.processInfo.arguments.contains("UI_TESTING") {
            billLoader = TestBillLoaderFactory.make()
        } else {
            billLoader = StaticBillProvider()
        }
    #else
        billLoader = StaticBillProvider()
    #endif
    }
    
    func showBillDetails(_ bill: Bill) {
        path.append(Route.billDetails(bill))
    }
    
    func showNotifications() {
        path.append(Route.notifications)
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
    
    func makeBillListView() -> some View {
        let billListViewModel = BillListViewModel(billLoader: billLoader)
        
        return BillListView(
            viewModel: billListViewModel,
            onSelectBill: { [weak self] bill in
                self?.showBillDetails(bill)
            },
            onNotificationsTapped: { [weak self] in
                self?.showNotifications()
            }
        )
    }
}
