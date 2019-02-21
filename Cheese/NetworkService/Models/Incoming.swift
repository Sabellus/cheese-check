//
//  Incoming.swift
//  Cheese
//
//  Created by Савелий Вепрев on 18/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation
struct Incomings:Codable {
    var data: [Incoming]
}
struct Incoming:Codable {
    let id: Int
    let inc_date:Date
    let name_inc: String
    let total: Double
    let deleted_date: Date
    let created_date:Date
    let updated_date: Date
}

