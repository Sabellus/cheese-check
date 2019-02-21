//
//  Switcher.swift
//  Cheese
//
//  Created by Савелий Вепрев on 15/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation

import UIKit

class Switcher {
    
    static func updateRootVC(){
        
        var rootVC : UIViewController?
       
        if UserDefaults.standard.string(forKey: "token") != nil{
            rootVC = TabBarController.storyboardInstance()
            storege.userInfo.token = UserDefaults.standard.string(forKey: "token")
        }
        else {
            rootVC = LoginViewController.storyboardInstance()
        }
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        appDelegate.window?.rootViewController = rootVC
        
    }
    
}
