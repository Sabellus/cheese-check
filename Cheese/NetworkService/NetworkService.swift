//
//  NetworkService.swift
//  Cheese
//
//  Created by Савелий Вепрев on 12/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation
import Alamofire
import SwiftyJSON
final class NetworkService {
    
    static let shared = NetworkService(withBaseURL: "http://192.168.1.38:8000/")
    
    let baseURL: String
    init(withBaseURL baseURL: String) {
        self.baseURL = baseURL
    }
    
    func fetch<Model: Codable> (fromRoute route: Route<Model>, fromParameters parameters: [String : String]!, fromHeaders headers: [String : String]!,
                then: @escaping (Result<Model>) -> Void) {
        guard let url = URL(string: self.baseURL+route.endpoint)
            else {
            then(.failure(NSError(domain: "warpfactor.io", code: 500)))
            return
        }
        Alamofire
            .request(url, method: .post, parameters: parameters, headers: headers
            )
            .responseData { (response) in
                guard response.error == nil else {
                    then(.failure(response.error!))
                    return
                }
                let formatter = DateFormatter()
                formatter.dateFormat = "E, d MMM yyyy HH:mm:ss Z"
                let decoder = JSONDecoder()
                decoder.dateDecodingStrategy = .formatted(formatter)
                if  let data = response.data,
                    let model = try? decoder.decode(Model.self, from: data) {
                    then(.success(model))
                }
                else {
                    print(JSON(response.data as Any))
                    then(.failure(NSError(  domain: "warpfactor.io",
                                            code: 1000,
                                            userInfo: ["error":"wrong model"]))
                    )
                }
        }
    }
}
let network = NetworkService.shared
