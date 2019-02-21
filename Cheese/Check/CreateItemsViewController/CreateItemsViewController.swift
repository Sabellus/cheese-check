//
//  CreateItemsViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 18/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class CreateItemsViewController: UICollectionViewController{
    struct ItemCheck:Codable {
        var name: String!
        var price: String!
        var quantity: String!
    }
    var flagCheck: Int!
    var itemCheck: [ItemCheck] = []
    @IBOutlet weak var createItemCollectionView: UICollectionView!
    static func storyboardInstance() -> CreateItemsViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? CreateItemsViewController
    }
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Позиции"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        createItemCollectionView.delegate = self
        createItemCollectionView.dataSource = self
        if (flagCheck != nil){
            for i in storege.check[flagCheck].items{
                itemCheck.append(ItemCheck(name: i.name, price: String(i.price), quantity: String(i.quantity)))
            }
            
        }
    }   
    @IBAction func createCheckAction(_ sender: Any) {
        
        if (itemCheck.count != 0) {
            storege.checkFilled.total = "0"
            self.createCheckApi(){
                self.createItemApi() {
                    self.navigationController?.popToRootViewController(animated: true)
                }
            }
        }
        else{
            self.createCheckApi(){
                self.navigationController?.popToRootViewController(animated: true)
            }
        }
    }
    func createItemApi( completion: @escaping () -> Void ){
        let date = Date()
        let jsonData = try? JSONEncoder().encode(itemCheck)
        let jsonString = String(data: jsonData!, encoding: .utf8)!
        print(jsonString)
        network.fetch(fromRoute: Routes.createItems, fromParameters: ["token":storege.userInfo.token,"check_id": storege.message.id, "items": jsonString, "created_date":date.nowToString()!], fromHeaders: nil) { (result) in
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
    
    func createCheckApi(completion: @escaping () -> Void ){
        let date = Date()
        network.fetch(fromRoute: Routes.createCheck, fromParameters: ["token":storege.userInfo.token, "check_name": storege.checkFilled.name, "totalsum":storege.checkFilled.total, "check_date":date.nowToString()!, "created_date":date.nowToString()!], fromHeaders: nil) { (result) in
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
    
    override func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return itemCheck.count
    }
    override func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCell(withReuseIdentifier: "cell", for: indexPath) as! ItemsViewCell
        cell.positionItemLabel.text = "Позиция"+String(indexPath.row)
        cell.nameItemTextField.text = itemCheck[indexPath.row].name
        cell.priceItemTextField.text = itemCheck[indexPath.row].price
        cell.quantityItemTextField.text = itemCheck[indexPath.row].quantity
        
        cell.nameItemTextField.tag = indexPath.row
        cell.priceItemTextField.tag = indexPath.row
        cell.quantityItemTextField.tag = indexPath.row
        cell.nameItemTextField.addTarget(self, action: #selector(nameChanged), for: .editingChanged)
        cell.priceItemTextField.addTarget(self, action: #selector(priceChanged), for: .editingChanged)
        cell.quantityItemTextField.addTarget(self, action: #selector(quantityChanged), for: .editingChanged)
        
        cell.removeItemButton.tag = indexPath.row
        cell.removeItemButton.addTarget(self, action: #selector(removeItemAction), for: .touchUpInside)
        
        return cell
    }
    @IBAction func addItemAction(_ sender: Any) {
        itemCheck.append(ItemCheck(name: "", price: "", quantity: ""))
        createItemCollectionView.reloadData()
    }
    @objc func nameChanged(_ sender: UITextField) {
        itemCheck[sender.tag].name = sender.text!
    }
    @objc func priceChanged(_ sender: UITextField) {
        itemCheck[sender.tag].price = sender.text!
    }
    @objc func quantityChanged(_ sender: UITextField) {
        itemCheck[sender.tag].quantity = sender.text!
    }
    @objc func removeItemAction(sender : UIButton){
        print(sender.tag)
        itemCheck.remove(at: sender.tag)
        createItemCollectionView.reloadData()
    }
}
extension UIViewController {    
    open override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        super.touchesBegan(touches, with: event)
        self.view.endEditing(true)
    }
}
