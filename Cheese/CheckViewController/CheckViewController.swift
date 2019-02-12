//
//  CheckViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 15/01/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit


class CheckViewController: UITableViewController {    
    static func storyboardInstance() -> CheckViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? CheckViewController
    }    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Чеки"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
