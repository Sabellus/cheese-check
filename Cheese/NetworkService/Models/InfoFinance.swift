//
//  InfoFinance.swift
//  Cheese
//
//  Created by Савелий Вепрев on 16/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation
struct InfoFinance: Codable{
    let data: [Info]
    let message: String
}
struct Info: Codable {
    let balance: String
    let costs: String
    let incomings: String
}   
