//
//  LoginViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 15/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class LoginViewController: UIViewController {
    @IBOutlet weak var emailTextFiled: UITextField!
    @IBOutlet weak var passwordTextField: UITextField!
    static func storyboardInstance() -> LoginViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? LoginViewController
    }
    @IBAction func signInButtonAction(_ sender: Any) {
        let autorisation = String(emailTextFiled.text!+":"+passwordTextField.text!).base64Encoded()
        let headers = ["Authorization": "Basic \(autorisation!)"]
        network.fetch(fromRoute: Routes.signIn, fromParameters: nil, fromHeaders: headers) { (result) in
            switch result {
            case .success(let model):
                UserDefaults.standard.set(model.token, forKey: "token")
                Switcher.updateRootVC()
                print (model)
            case .failure(let error):
                print (error)
            }
        }
    }
    
    @IBAction func signUpToAction(_ sender: Any) {
        let signUp = SignUpViewController.storyboardInstance()
        navigationController?.pushViewController(signUp!, animated: true)
    }
    override func viewDidLoad() {
        super.viewDidLoad()

    }
}


extension String {
    //: ### Base64 encoding a string
    func base64Encoded() -> String? {
        if let data = self.data(using: .utf8) {
            return data.base64EncodedString()
        }
        return nil
    }
    
    //: ### Base64 decoding a string
    func base64Decoded() -> String? {
        if let data = Data(base64Encoded: self) {
            return String(data: data, encoding: .utf8)
        }
        return nil
    }
}
