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
    
    func showBillDetails(_ bill: Bill) {
        path.append(Route.billDetails(bill))
    }
    
    func showNotifications() {
        path.append(Route.notifications)
    }
    
    func popToRoot() {
        path = NavigationPath()
    }
}
