//
//  ItemViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 20/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class ItemViewController: UITableViewController {
    static func storyboardInstance() -> ItemViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? ItemViewController
    }
    @IBOutlet var itemsTableView: UITableView!
    var numberCheck: Int!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Позиции"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataApiChecks(){
            self.tableView.reloadData()
        }
    }
    func getDataApiChecks(completion: @escaping () -> Void ){
        network.fetch(fromRoute: Routes.allChecks, fromParameters: ["limit":"100","offset":"0", "token":storege.userInfo.token], fromHeaders: nil) { (result) in
            switch result {
            case .success(let model):
                print (model)
                storege.check = model.data
                completion()
            case .failure(let error):
                print (error)
                completion()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storege.check[numberCheck].items.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? CheckTableViewCell
        cell?.nameLabel?.text = storege.check[numberCheck].items[indexPath.row].name
        cell?.priceLabel?.text = String(storege.check[numberCheck].items[indexPath.row].price)
        cell?.dateLabel?.text = storege.check[numberCheck].items[indexPath.row].createdDate.toString(format: "dd-MM HH:mm")
        return cell!
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Arial", size: 11.0)
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
      let item = ItemCreateViewController.storyboardInstance()        
        item!.name = storege.check[numberCheck].items[indexPath.row].name
        item!.price = String(storege.check[numberCheck].items[indexPath.row].price)
        item!.quantity = String(storege.check[numberCheck].items[indexPath.row].quantity)
        item!.itemId = String(storege.check[numberCheck].items[indexPath.row].id)
        self.navigationController?.pushViewController(item!, animated: true)
    }
}
