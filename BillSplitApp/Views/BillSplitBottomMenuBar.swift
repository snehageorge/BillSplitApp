//
//  BillSplitBottomMenuBar.swift
//  BillSplitApp
//
//  Created by Sneha on 09/04/25.
//

import SwiftUI

struct BillSplitBottomMenuBar: View {
    let icons = ["house", "text.document", "camera.metering.none", "bubble.left.and.bubble.right", "person"]
    let tabs: [MainCoordinator.Tab] = [.bills, .documents, .scan, .chat, .profile]
    
    @Binding var selectedTab: MainCoordinator.Tab
    
    var body: some View {
        HStack {
            ForEach(0..<5)  { index in
                Button(action: {
                    selectedTab = tabs[index]
                }) {
                    ZStack {
                        Circle()
                            .foregroundStyle(selectedTab == tabs[index] ? Color.yellow : Color.black)
                            .frame(width: 50, height: 50)
                        Image(systemName: icons[index])
                            .foregroundStyle(Color.gray)
                    }
                    
                }
            }
        }
        .padding()
        .frame(height: 60)
        .background(Color.gray)
        .clipShape(RoundedRectangle(cornerRadius: 15))
    }
}

#Preview {
    @Previewable @State var selectedTab: MainCoordinator.Tab = .bills
    BillSplitBottomMenuBar(selectedTab: $selectedTab)
}
