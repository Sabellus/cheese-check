//
//  Result.swift
//  Cheese
//
//  Created by Савелий Вепрев on 12/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation
enum Result<Model> {
    case success(Model)
    case failure(Error)
}
