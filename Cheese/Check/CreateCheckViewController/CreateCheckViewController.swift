//
//  CreateCheckViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 18/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit
import Foundation

class CreateCheckViewController: UIViewController{
    static func storyboardInstance() -> CreateCheckViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? CreateCheckViewController
    }
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        storege.checkFilled.name = sender.text!
    }
    @IBAction func totalEditingChanged(_ sender: UITextField) {
        storege.checkFilled.total = sender.text!
    }
    @IBAction func createItemsAction(_ sender: Any) {
        if(storege.checkFilled.name != nil && storege.checkFilled.name != "") {
            let items = CreateItemsViewController.storyboardInstance()
            navigationController?.pushViewController(items!, animated: true)
            if(storege.checkFilled.total == nil || storege.checkFilled.total == ""){
                storege.checkFilled.total = "0"
            }
        }
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Создание чека"
        self.navigationController?.navigationBar.prefersLargeTitles = true        
    }
}

