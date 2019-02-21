//
//  MessageId.swift
//  Cheese
//
//  Created by Савелий Вепрев on 19/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation
struct MessageId: Codable {
    var data: MessageData
    var message: String!
}
struct MessageData: Codable {
    var id: Int
}
