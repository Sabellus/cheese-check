//
//  UpdateIncomingViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 22/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class UpdateIncomingViewController: UIViewController {
    static func storyboardInstance() -> UpdateIncomingViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? UpdateIncomingViewController
    }
    var name: String!
    var price: String!
    var id: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Зачисления"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        nameTextField.text = name
        priceTextField.text = price
        // Do any additional setup after loading the view.
    }
    func updateItemApi(completion: @escaping () -> Void ){
        let date = Date()
        network.fetch(fromRoute: Routes.updateIncoming, fromParameters: ["incomings_id": String(id), "token":storege.userInfo.token, "name_inc": name, "total":price ,"updated_date":date.nowToString()!], fromHeaders: nil) { (result) in
            switch result {
            case .success(let model):
                print (model)
                storege.message.id = String(model.data.id)
                completion()
            case .failure(let error):
                print (error)
                completion()
            }
        }
    }
    @IBAction func updateIncoming(_ sender: Any) {
        updateItemApi(){
            self.navigationController?.popViewController(animated: true)
        }
    }
    @IBOutlet weak var nameTextField: UITextField!
    
    @IBOutlet weak var priceTextField: UITextField!
    
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        name=sender.text!
    }
    
    @IBAction func priceEditingChanged(_ sender: UITextField) {
        price=sender.text!
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
