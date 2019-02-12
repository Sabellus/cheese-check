//
//  GeneralViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 15/01/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class GeneralViewController: UIViewController, UITableViewDelegate, UITableViewDataSource, UIScrollViewDelegate, NetDelegate{
    func netResults(withType: Net.RequestType) {
        switch withType {
        case .getCheck:
            print("финиш")
        case .getChecks:
            print("финиш2")
        default:
            break
        }
    }
    
    static func storyboardInstance() -> GeneralViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? GeneralViewController
    }
    
    @IBOutlet weak var scrollViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightHistoryTableView: NSLayoutConstraint!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!
    let items = [ ["ЧикенБургер", "БигМак", "Кола", "Картошка 60гр", "Соус Чили"], ["Картошка", "Перец", "Зелень"], ["Руби", "Гиннес"],["Руби", "Гиннес"]]
    let sections = ["Ресторан MacDonalds","ГиперМаркет Семья", "Бар Sheimus","Бар Sheimus"]
    let cellReuseIdentifier = "cell"
    var fetchingMore = false
    var refreshControl:UIRefreshControl!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Главная"
        historyTableView.delegate = self
        historyTableView.dataSource = self
        scrollView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        
        scrollView.addSubview(refreshControl)        
        
    }    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sections.count
    }
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
       return items[section].count
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell", for: indexPath as IndexPath)
        cell.textLabel?.text = items[indexPath.section][indexPath.row]
        cell.detailTextLabel!.text = "-200Р"        
        heightHistoryTableView.constant = tableView.contentSize.height        
        return cell
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return sections[section]
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        print("You tapped cell number \(indexPath.row).")
        Net.delegate = self
        Net.sendRequest(type: .getCheck, header: ["only_filled": "true"])
    }
    @objc func refresh() {
        refreshBegin(newtext: "Refresh",refreshEnd: {(x:Int) -> () in
            self.historyTableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:@escaping (Int) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now() + .seconds(4), execute: {
            print("refreshing")
            self.refreshControl.attributedTitle = NSAttributedString(string: newtext)
            DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                refreshEnd(0)
            })
        })
    }
    override func viewDidDisappear(_ animated: Bool) {
        refreshControl.endRefreshing()        
    }
    

    func scrollViewDidScroll(_ scrollView: UIScrollView) {
        let offcetY = scrollView.contentOffset.y
        let contentHeight = scrollView.contentSize.height
        if offcetY < contentHeight - scrollView.frame.height {
            if !fetchingMore {
                beginBatchFetch()
            }
        }
    }
    func beginBatchFetch(){
        fetchingMore = true
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            //print("Запрос")
            self.fetchingMore = false
        })
        
    }
    
    

}
