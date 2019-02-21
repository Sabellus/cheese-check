//
//  ItemCreateViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 20/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class ItemCreateViewController: UIViewController {
    static func storyboardInstance() -> ItemCreateViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? ItemCreateViewController
    }
    var name: String!
    var price: String!
    var quantity: String!
    var itemId: String!
    @IBOutlet weak var nameTextField: UITextField!
    @IBOutlet weak var priceTextField: UITextField!
    @IBOutlet weak var quantityTextField: UITextField!
    override func viewDidLoad() {
        super.viewDidLoad()
        nameTextField.text = name
        priceTextField.text = price
        quantityTextField.text = quantity
    }
    func updateItemApi(completion: @escaping () -> Void ){
        let date = Date()
        network.fetch(fromRoute: Routes.updateItem, fromParameters: ["token":storege.userInfo.token, "name": name, "price":price, "quantity":quantity ,"updated_date":date.nowToString()!, "item_id": itemId], fromHeaders: nil) { (result) in
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
    @IBAction func nameEditingChanged(_ sender: UITextField) {
        name = sender.text
    }    
    @IBAction func priceEditingChanged(_ sender: UITextField) {
        price = sender.text
    }
    @IBAction func quantityEditingChanged(_ sender: UITextField) {
        quantity = sender.text
    }
    @IBAction func updateItemAction(_ sender: Any) {
        updateItemApi(){
          self.navigationController?.popViewController(animated: true)
        }
    }
    

}
