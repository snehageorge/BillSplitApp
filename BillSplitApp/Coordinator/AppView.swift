//
//  AppView.swift
//  BillSplitApp
//
//  Created by Sneha on 11/04/25.
//

import SwiftUI

struct AppView: View {
    @StateObject private var coordinator = MainCoordinator()
        
    var body: some View {
        NavigationStack(path: $coordinator.path) {
            ZStack {
                    Group {
                        switch coordinator.selectedTab {
                        case .bills:
                            BillListView(onSelectBill: { bill in
                                coordinator.showBillDetails(bill)
                            }, onNotificationsTapped: {
                                coordinator.showNotifications()
                            })
                            .frame(maxWidth: .infinity, maxHeight: .infinity)
                        case .documents:
                            BillSplitDocumentsView()
                        case .scan:
                            BillSplitScanView()
                        case .chat:
                            BillSplitChatView()
                        case .profile:
                            BillSplitProfileView()
                        }
                    }
                    .frame(maxWidth: .infinity)
                    // Custom bottom menu bar
                    VStack {
                        Spacer()
                        BillSplitBottomMenuBar(
                            selectedTab: $coordinator.selectedTab
                        )
                    }
                    .ignoresSafeArea(.keyboard)
            }
            .navigationDestination(for: Route.self) { route in
                switch route {
                    case .billDetails(let bill):
                        BillDetailsView(bill: bill)
                    case .notifications:
                        NotificationListView()
                }
            }
        }
    }
}

#Preview {
    AppView()
}
