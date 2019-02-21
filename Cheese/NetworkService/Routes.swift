//
//  Routes.swift
//  Cheese
//
//  Created by Савелий Вепрев on 12/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation
struct Route<Model> {
    let endpoint: String
}

struct Routes {
    static let allChecks = Route<Check>(endpoint: "checks")
    static let signIn = Route<Login>(endpoint: "login")
    static let infoFinance = Route<InfoFinance>(endpoint: "get-finance-info")
    static let allIncomings = Route<Incomings>(endpoint:"get-incomings-all")
    static let createIncoming = Route<MessageId>(endpoint: "create-incomings")
    static let createCheck = Route<MessageId>(endpoint: "create-check")
    static let createItems = Route<MessageId>(endpoint: "create-items")
    static let signUp = Route<MessageId>(endpoint: "create-user")
    static let updateItem = Route<MessageId>(endpoint: "update-item")
    static let deleteCheck = Route<MessageId>(endpoint: "delete-check")
    static let deleteIncoming = Route<MessageId>(endpoint: "delete-incomings")
    static let updateIncoming = Route<MessageId>(endpoint: "update-incomings")
//    static let beagles = Route<Beagles>(endpoint: "breed/beagle/images")
}
