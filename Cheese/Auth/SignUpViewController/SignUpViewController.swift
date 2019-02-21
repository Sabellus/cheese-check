//
//  SignUpViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 20/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import Foundation

import UIKit

class SignUpViewController: UIViewController {
    struct SignUp {
        var name: String!
        var phone: String!
        var email: String!
        var password: String!
    }
    var signUp = SignUp()
    @IBOutlet weak var signUpButton: UIButton!
    
static func storyboardInstance() -> SignUpViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? SignUpViewController
    }
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        signUp.name = sender.text!
    }
    @IBAction func phoneEditingChanged(_ sender: UITextField) {
        signUp.phone = sender.text!
    }
    
    @IBAction func emailEditingChanged(_ sender: UITextField) {
        signUp.email = sender.text!
    }
    @IBAction func pswEditionChanged(_ sender: UITextField) {
        signUp.password = sender.text!
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    
    @IBAction func signUpAction(_ sender: Any) {
        if (signUp.password != nil && signUp.name != nil && signUp.phone != nil && signUp.email != nil){
            print(signUp)
            let date = Date()
            network.fetch(fromRoute: Routes.signUp, fromParameters: ["username":signUp.name!,"password": signUp.password!,"phone":signUp.phone!, "email": signUp.email!, "created_date":date.nowToString()!], fromHeaders: nil) { (result) in
            
                switch result {
                case .success(let model):
                    Switcher.updateRootVC()
                    print (model)
                case .failure(let error):
                    print (error)
                    Switcher.updateRootVC()
                }
            }
        }
    }
}
