//
//  BillModel.swift
//  BillSplitApp
//
//  Created by Sneha on 09/04/25.
//

struct Bill: Codable, Identifiable, Hashable {
    var id: Int
    var shopName: String
    var foodImage: String
    var shopLogo: String
    var totalAmount: Double
    var date: String
    var userName: String
    var userImage: String
    var isPending: Bool
    var friends: [Friend]
}

struct Friend: Codable, Hashable {
    var friendId: Int
    var name: String
    var amount: Double
    var userImage: String
    var isPaid: Bool
}

struct BillResponse: Codable {
    var bills: [Bill]
}

extension Bill {
    static let mock = Bill(
        id: 1,
        shopName: "Pizza Hut",
        foodImage: "https://i.imghippo.com/files/UpNG4121vao.png",
        shopLogo: "https://i.imghippo.com/files/wq1072IP.jpg",
        totalAmount: 80,
        date: "2025-03-30",
        userName: "Rakib",
        userImage: "https://i.imghippo.com/files/BZX1663ePA.jpg",
        isPending: true,
        friends: [
            Friend(
                friendId: 1,
                name: "Vitalii",
                amount: 15,
                userImage: "https://i.imghippo.com/files/BZX1663ePA.jpg",
                isPaid: true
            ),
            Friend(
                friendId: 2,
                name: "Alice",
                amount: 15,
                userImage: "https://i.imghippo.com/files/BZX1663ePA.jpg",
                isPaid: false
            ),
            Friend(
                friendId: 3,
                name: "Aurelian",
                amount: 20,
                userImage: "https://i.imghippo.com/files/BZX1663ePA.jpg",
                isPaid: false
            ),
            Friend(
                friendId: 4,
                name: "Rakib",
                amount: 15,
                userImage: "https://i.imghippo.com/files/BZX1663ePA.jpg",
                isPaid: false
            ),
            Friend(
                friendId: 5,
                name: "Emma",
                amount: 15,
                userImage: "https://i.imghippo.com/files/BZX1663ePA.jpg",
                isPaid: true
            )
        ]
    )
}
