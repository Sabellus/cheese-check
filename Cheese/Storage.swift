//
//  Storage.swift
//  Cheese
//
//  Created by Савелий Вепрев on 15/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//


import UIKit
import Foundation

class Storage{
    struct UserInfo {
        var token: String!
    }
    struct CheckFilled {
        var name: String!
        var total: String!
    }
    struct MessageIdStore {
        var id: String!
    }
    var checkFilled = CheckFilled()
    var userInfo = UserInfo()
    var check = [Checks] ()
    var incoming = [Incoming] ()
    var message = MessageIdStore ()
    private init () { }
    static let shared = Storage()
}
let storege = Storage.shared




