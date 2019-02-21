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
    @IBOutlet var checkTableView: UITableView!
    
    fileprivate func attemptToAssembleGroupedMessages() {
        print("Attempt to group our messages together based on Date property")
        
        for (index, i) in storege.check.enumerated(){
//            let t = Date.dateFromCustomString(customString: i.check_date)
            //storege.check.data[index].check_date = t.toString(format: "dd/MM/yy")
           
        }
        
//        let groupedCheck = Dictionary(grouping: storege.check.data) { (element) -> Date in
//            let dateT = storege.check.data[0].check_date.toDate(format: "MM/dd/yyyy")
//            let t = element.check_date.toDate(format: "E, d MMM yyyy HH:mm:ss Z")
//            return t!.reduceToMonthDayYear()
//        }
        
        // provide a sorting for your keys somehow
//        let sortedKeys = groupedCheck.keys.sorted()
        
//        sortedKeys.forEach { (key) in
//            let values = groupedCheck[key]
////            checkSorted.append(values ?? [])
//        }
        
   
    }
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Чеки"
        self.navigationController?.navigationBar.prefersLargeTitles = true
        checkTableView.delegate = self
        checkTableView.dataSource = self
        
    }
    override func viewWillAppear(_ animated: Bool) {
        getDataApiChecks() {
            self.checkTableView.reloadData()
            self.attemptToAssembleGroupedMessages()
        }
    }
    @IBAction func createCheckActionButton(_ sender: Any) {
        let createVC = CreateCheckViewController.storyboardInstance()
        navigationController?.pushViewController(createVC!, animated: true)
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
   
    func deleteCheckApi(check_id: Int, completion: @escaping () -> Void ){
        let date = Date()
        network.fetch(fromRoute: Routes.deleteCheck, fromParameters: ["check_id":String(check_id),"deleted_date":date.nowToString()!, "token":storege.userInfo.token], fromHeaders: nil) { (result) in
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
    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return storege.check.count
    }
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath) as? CheckTableViewCell
        cell?.nameLabel?.text = storege.check[indexPath.row].check_name
        cell?.priceLabel?.text = String(storege.check[indexPath.row].totalsum)
        let date = NSDate(timeIntervalSince1970: storege.check[indexPath.row].created_date.timeIntervalSince1970)
        let dateFormatter = DateFormatter()
        dateFormatter.dateFormat = "HH:mm dd.MM.yyyy"
        dateFormatter.timeZone = NSTimeZone(name: "UTC") as TimeZone?
        let dateString = dateFormatter.string(from: date as Date)
        print("formatted date is =  \(dateString)")
        cell?.dateLabel?.text = dateString
        return cell!
    }    
    override func tableView(_ tableView: UITableView, willDisplayHeaderView view: UIView, forSection section: Int) {
        let header: UITableViewHeaderFooterView = view as! UITableViewHeaderFooterView
        header.textLabel?.font = UIFont(name: "Arial", size: 11.0)
        header.textLabel?.textAlignment = NSTextAlignment.center
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        let viewItem = ItemViewController.storyboardInstance()
        viewItem?.numberCheck = indexPath.row
        self.navigationController?.pushViewController(viewItem!, animated: true)
        
    }
    override func tableView(_ tableView: UITableView, trailingSwipeActionsConfigurationForRowAt indexPath: IndexPath) -> UISwipeActionsConfiguration? {
        let delete = UIContextualAction(style: .destructive, title: "Delete") { (action, sourceView, completionHandler) in
            print("index path of delete: \(indexPath.row)")
            completionHandler(true)
            self.deleteCheckApi(check_id: storege.check[indexPath.row].id){                
            }
        }
        let swipeActionConfig = UISwipeActionsConfiguration(actions: [delete])
        swipeActionConfig.performsFirstActionWithFullSwipe = false
        return swipeActionConfig
    }
   

}
