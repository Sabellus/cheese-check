//
//  IncomingViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 18/02/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class IncomingViewController: UITableViewController {
    static func storyboardInstance() -> IncomingViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? IncomingViewController
    }
    @IBOutlet var incomingsTableView: UITableView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Зачисления"
        self.navigationController?.navigationBar.prefersLargeTitles = true
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataApiChecks() {
            self.incomingsTableView.reloadData()
        }
    }
    @IBAction func createIncoming(_ sender: Any) {
        let incoming = CreateIncomingViewController.storyboardInstance()
        navigationController?.pushViewController(incoming!, animated: true)
    }
    @IBAction func createCheckActionButton(_ sender: Any) {
        let createVC = CreateCheckViewController.storyboardInstance()
        navigationController?.pushViewController(createVC!, animated: true)
    }
    func getDataApiChecks(completion: @escaping () -> Void ){
        network.fetch(fromRoute: Routes.allIncomings, fromParameters: ["limit":"100","offset":"0", "token":storege.userInfo.token], fromHeaders: nil) { (result) in
            switch result {
            case .success(let model):
                print(model)                
                storege.incoming = model.data
                completion()
            case .failure(let error):
                print (error)
                completion()
            }
        }
    }
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {       
        return  storege.incoming.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = storege.incoming[indexPath.row].name_inc
        cell.detailTextLabel!.text = String(storege.incoming[indexPath.row].total)
        return cell
    }
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Arial", size: 11.0)
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let update = UpdateIncomingViewController.storyboardInstance()
        update?.name = storege.incoming[indexPath.row].name_inc
        update?.price = String(storege.incoming[indexPath.row].total)
        update?.id = storege.incoming[indexPath.row].id
        self.navigationController?.pushViewController(update!, animated: true)
    }
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        return true
    }
    
//    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
//        if (editingStyle == .delete) {
//            // handle delete (by removing the data from your array and updating the tableview)
//        }
//    }
    func deleteCheckApi(incoming_id: Int, completion: @escaping () -> Void ){
        let date = Date()
        network.fetch(fromRoute: Routes.deleteIncoming, fromParameters: ["incomings_id":String(incoming_id),"deleted_date":date.nowToString()!, "token":storege.userInfo.token], fromHeaders: nil) { (result) in
            switch result {
            case .success(let model):
                print (model)
                completion()
            case .failure(let error):
                print (error)
                completion()
            }
        }
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Удалить") { (action, sourceView, completionHandler) in
            print("index path of delete: \(indexPath.row)")
            completionHandler(true)
            self.deleteCheckApi(incoming_id: storege.incoming[indexPath.row].id){
                
            }
        }
       
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }

    

}
