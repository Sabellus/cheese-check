//
//  Check.swift
//  Cheese
//
//  Created by Савелий Вепрев on 12/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation
struct Check: Codable {
    let data: [Checks]
}
struct Checks: Codable{
    let check_date: Date
    let check_name: String
    let created_date:Date
    let id: Int
    let totalsum: Double
    let items: [Item]
}
struct Item: Codable{
    let createdDate: Date
    let deleted_date: Date
    let id: Int
    let name: String
    let price: Int
    let quantity: Int
    let updated_date: Date
    enum CodingKeys: String, CodingKey {
        case createdDate = "created_date"
        case deleted_date
        case id
        case name
        case price
        case quantity
        case updated_date
    }
}
//struct Check: Codable {
//    struct Checks: Codable {
////        struct Item: Codable{
////            let created_date: String
////            let deleted_date: String
////            let id: Int
////            let name: String
////            let price: Int
////            let quantity: Int
////            let updated_date: String
////        }
////        let check_date: String
////        let check_name: String
////        let created_date:String
////        let id: Int
////        let total_sum: Double
////        let items: [Item]
//
//    }
//    //let data: String!
//    let check_date: String
//    let check_name: String
//    let created_date:String
//    let id: Int
//    let total_sum: Double
//}

