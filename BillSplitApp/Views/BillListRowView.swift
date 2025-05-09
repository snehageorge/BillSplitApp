//
//  BillListRowView.swift
//  BillSplitApp
//
//  Created by Sneha on 09/05/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct BillListRowView: View {
    let bill: Bill
    let onSelectBill: (Bill) -> Void
    
    var body: some View {
        Button(action: {
            onSelectBill(bill)
        }) {
            HStack {
                WebImage(url: URL(string: bill.shopLogo))
                    .resizable()
                    .scaledToFill()
                    .frame(width: 70, height: 70)
                    .clipShape(Circle())
                
                VStack(alignment: .leading, spacing: 10) {
                    Text("\(bill.shopName)")
                        .font(.headline)
                        .fontWeight(.bold)
                        .foregroundStyle(Color.white)
                    
                    Text("\(bill.date)")
                        .font(.caption2)
                        .foregroundStyle(Color.white)
                    
                }
                
                Spacer()
                Text("$\(bill.totalAmount, specifier: "%.2f")")
                    .font(.subheadline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.white)
            }
            .frame(maxWidth: .infinity)
            .frame(height: 80)
            .padding()
            .background(Color.gray.opacity(0.3))
            .clipShape(RoundedRectangle(cornerRadius: 20))
        }
    }
}

#Preview {
    BillListRowView(bill: .mock, onSelectBill: { bill in
        print("Selected bill: \(bill.shopName)")
    })
}
