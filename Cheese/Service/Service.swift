//
//  Service.swift
//  Cheese
//
//  Created by Савелий Вепрев on 24/01/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//


import UIKit
import Alamofire
import Foundation
import SwiftyJSON
import SystemConfiguration


class NetworkManager {
    
    var manager: SessionManager?
    
    init() {
        let configuration = URLSessionConfiguration.default
        manager = Alamofire.SessionManager(configuration: configuration)
    }
}

protocol NetDelegate {
    func netResults(withType: Net.RequestType)
}

class Net {
    static var delegate : NetDelegate?
    private static var sessionManager = Alamofire.SessionManager()
    private static let timeoutInterval: TimeInterval = 5
    static let baseUrl = "http://127.0.0.1:5000/"     //  для разработки
    private static var isRequestProcessed = false
    static var currentRequestUrl: String {
        
        
        switch Net.currentRequest {
        case .none:
            return ""
        case .getCheck:
            return "check"
        case .getChecks:
            return "checks"
        }
        
    }
    enum RequestType: String {
        case none
        case getCheck
        case getChecks
    }
    
    private(set) static var currentRequest: RequestType = .none
    static let dispatchGroup = DispatchGroup()

    static func sendRequest (type: RequestType, header: Dictionary<String, String>?) {
      
        Net.currentRequest = type
        var url = "%@%@"
        url = String(format: url, baseUrl, currentRequestUrl)
        
        switch type {
       
        case .getCheck:
            alamofireRequest(withType: type, url: url, headers: ["token": "eyJ0eXAiOiJKV1QiLCJhbGciOiJIUzI1NiJ9.eyJpZCI6MSwiZXhwIjoxNTgwNTY4MDkyfQ.Z_EQnKRzD0-nCSmB23tZA7_GjAUFWTMBFBrN5tn-CBs"], parameters: ["check_id":"1"])
            
        case .none:
            break
   
        case .getChecks:
            print(1)
        }

    }
  
    private static func alamofireRequest(withType type: RequestType, url: String, headers: Dictionary<String, String>, parameters: Dictionary<String, String>) {
      
        isRequestProcessed = true
      
        let configuration = URLSessionConfiguration.default
        configuration.timeoutIntervalForRequest = 0.01
        
        self.sessionManager.request(url, method: .post, parameters: parameters, headers: headers).response  { response in
            isRequestProcessed = false
            
            if let json = try? JSON(data: response.data!) {
                print("JSON: \(json)")
                
                // ошибочные параметры запроса в url
                if json["error"].stringValue == "1" {
                    let errorMessage = json["message"].stringValue
                }
                
                self.delegate?.netResults(withType: type)
            }
            
        }
    }
    
    
    
}







