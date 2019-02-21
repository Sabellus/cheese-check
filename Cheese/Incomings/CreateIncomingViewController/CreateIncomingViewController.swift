//
//  CreateIncomingViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 19/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class CreateIncomingViewController: UIViewController {
    struct IncomingCreate {
        var name_inc: String!
        var total: String!        
    }
    var incomingsCreate = IncomingCreate()
    static func storyboardInstance() -> CreateIncomingViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? CreateIncomingViewController
    }
    @IBOutlet weak var totalTextField: UITextField!
    @IBOutlet weak var nameTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Новое зачисление"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    @IBAction func nameEditingChange(_ sender: UITextField) {
        incomingsCreate.name_inc = sender.text!
        print(sender.text!)
    }
    @IBAction func totalEditingChange(_ sender: UITextField) {
        incomingsCreate.total = sender.text!
        print(sender.text!)
    }
    @IBAction func createIncomingAction(_ sender: Any) {
        if (incomingsCreate.name_inc != nil && incomingsCreate.total != nil) {
            let date = Date()
            network.fetch(fromRoute: Routes.createIncoming, fromParameters: ["token":storege.userInfo.token, "name_inc": incomingsCreate.name_inc, "total":incomingsCreate.total, "inc_date":date.nowToString()!, "created_date":date.nowToString()!], fromHeaders: nil) { (result) in
                switch result {
                case .success(let model):
                    print (model)
                    self.navigationController?.popToRootViewController(animated: true)
                case .failure(let error):
                    print (error)
                }
            }
        }
        
    }
    
}
