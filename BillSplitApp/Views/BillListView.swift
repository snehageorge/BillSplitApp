//
//  BillListView.swift
//  BillSplitApp
//
//  Created by Sneha on 09/04/25.
//

import SwiftUI
import SDWebImageSwiftUI

struct BillListView: View {
    @StateObject var viewModel: BillListViewModel
    
    var onSelectBill: (Bill) -> Void
    var onNotificationsTapped: () -> Void
    
    init(
        viewModel: BillListViewModel,
        onSelectBill: @escaping (Bill) -> Void,
        onNotificationsTapped: @escaping () -> Void
    ) {
        _viewModel = StateObject(wrappedValue: viewModel)
        self.onSelectBill = onSelectBill
        self.onNotificationsTapped = onNotificationsTapped
    }
    
    var body: some View {
        GeometryReader { geometry in
            let isPortrait = geometry.size.height > geometry.size.width
            let screenHeight = geometry.size.height
            ZStack {
                Color.black
                    .frame(maxHeight: .infinity)
                    .ignoresSafeArea()
                    .accessibilityIdentifier("main_background")
                
                ScrollView {
                    VStack {
                        if viewModel.isLoading {
                            ProgressView()
                                .foregroundStyle(.white)
                                .accessibilityIdentifier("loading_indicator")
                        } else if viewModel.bills.isEmpty {
                            Text("No bills found")
                                .accessibilityIdentifier("no_bills_message")
                        } else {
                            BillListTopBarView(
                                bills: viewModel.bills,
                                onNotificationsTapped: onNotificationsTapped
                            )
                            .accessibilityIdentifier("bills_top_bar")
                            
                            if isPortrait {
                                BillCarouselView(bills: viewModel.bills, screenHeight: screenHeight)
                                    .accessibilityIdentifier("carousel_view")
                            }
                            BillRecentSplitListView(bills: viewModel.bills, onSelectBill: onSelectBill)
                                .accessibilityIdentifier("recent_bills_list_view")
                            Spacer()
                        }
                    }
                }
            }
            .task {
                if viewModel.bills.isEmpty {
                    await viewModel.fetchBills()
                }
                
            }
        }
        .navigationTitle("Your Bills")
        .navigationBarTitleDisplayMode(.inline)
        .toolbar {
            ToolbarItem(placement: .navigationBarTrailing) {
                Button(action: {
                    onNotificationsTapped()
                }) {
                    Image(systemName: "bell")
                        .foregroundStyle(Color.white)
                        .accessibilityIdentifier("notification_button_image")
                }
                .accessibilityIdentifier("notification_button")
            }
        }
    }
}

struct BillListTopBarView: View {
    let bills: [Bill]
    let onNotificationsTapped: () -> Void
    
    var body: some View {
        HStack {
            VStack(alignment: .leading, spacing: 3) {
                Text("Hey \(bills[0].userName)")
                    .font(.headline)
                    .fontWeight(.bold)
                    .foregroundStyle(Color.gray)
                
                Text("\(bills.filter{ $0.isPending == true }.count) Pending Bills")
                    .font(.subheadline)
                    .foregroundStyle(Color.white)
            }
            
            Spacer()
        }
        .padding()
    }
}

struct BillCarouselView: View {
    @State var selectedIndex = 0
    let bills: [Bill]
    let screenHeight: CGFloat
    
    var body: some View {
        ZStack {
            Color.yellow
                .clipShape(RoundedRectangle(cornerRadius: 20))
                .accessibilityIdentifier("carousel_background")
            VStack {
                HStack {
                    ForEach(0..<bills.prefix(2).count, id: \.self) { index in
                        Circle()
                            .fill(index == selectedIndex ? Color.black : Color.gray.opacity(0.5))
                            .frame(width: 8, height: 8)
                            .accessibilityIdentifier("carousel_dot_\(index)")
                    }
                }
                .padding(.top)
                TabView(selection: $selectedIndex) {
                    ForEach(Array(bills.prefix(2).enumerated()), id: \.element.id) { index, bill in
                        VStack {
                            WebImage(url: URL(string: bill.foodImage))
                                .resizable()
                                .padding(.top)
                                .scaledToFit()
                                .frame(width: 230, height: 230)
                                .accessibilityIdentifier("carousel_food_image_\(index)")
                            
                            HStack {
                                WebImage(url: URL(string: bill.shopLogo))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                                Spacer()
                                
                                VStack {
                                    Text(String(format: "$%.2f", bill.totalAmount))
                                        .font(.title3)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.black)
                                    
                                    Text("\(bill.shopName)")
                                        .font(.caption)
                                        .fontWeight(.bold)
                                        .foregroundStyle(Color.gray.opacity(0.8))
                                }
                                Spacer()
                                
                                WebImage(url: URL(string: bill.userImage))
                                    .resizable()
                                    .scaledToFit()
                                    .frame(width: 50, height: 50)
                                    .clipShape(Circle())
                            }
                            .padding([.leading, .trailing, .bottom])
                        }
                        .tag(index)
                        .padding(.bottom)
                    }
                }
                .tabViewStyle(.page(indexDisplayMode: .never))
            }
        }
        .padding([.leading, .trailing])
        .frame(height: screenHeight / 2.5)
        .frame(maxWidth: .infinity, maxHeight: .infinity)
    }
}

struct BillRecentSplitListView: View {
    let bills: [Bill]
    let onSelectBill: (Bill) -> Void
    @State private var showAll = false
    
    var body: some View {
        HStack {
            Text("Recent Splits")
                .font(.title2)
                .fontWeight(.bold)
                .foregroundStyle(Color.white)
            Spacer()
            Button(action: {
                withAnimation {
                    showAll.toggle()
                }
            }, label: {
                Text(showAll ? "Show less" : "See all")
                    .foregroundStyle(Color.yellow)
            })
        }
        .padding()
        
        VStack {
            ForEach(showAll ? bills : Array(bills.prefix(2))) { bill in
                BillListRowView(bill: bill, onSelectBill: onSelectBill)
            }
            Spacer()
        }
    }
}

#Preview {
    BillListView(
        viewModel: BillListViewModel(
            billLoader: MockBillProvider()
        ),
        onSelectBill: { bill in
            print("Selected bill: \(bill.shopName)")
        },
        onNotificationsTapped: {
            print("Notifications tapped")
        })
}
