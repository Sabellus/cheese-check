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
class GeneralViewController: UIViewController, UIScrollViewDelegate{
    
    
    static func storyboardInstance() -> GeneralViewController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? GeneralViewController
    }
    @IBAction func logautButtonAction(_ sender: Any) {
        UserDefaults.standard.removeObject(forKey: "token")
        Switcher.updateRootVC()
    }
    
    @IBOutlet weak var scrollViewConstraint: NSLayoutConstraint!
    @IBOutlet weak var heightHistoryTableView: NSLayoutConstraint!
    @IBOutlet weak var historyTableView: UITableView!
    @IBOutlet weak var scrollView: UIScrollView!
    
    @IBOutlet weak var activityIndicator: UIActivityIndicatorView!

    let cellReuseIdentifier = "cell"
    var fetchingMore = false
    var refreshControl:UIRefreshControl!
    
    @IBOutlet weak var costsLabel: UILabel!
    @IBOutlet weak var incomingsLabel: UILabel!
    @IBOutlet weak var balanceLabel: UILabel!
    @IBOutlet weak var dollarBalanceLabel: UILabel!
    @IBOutlet weak var euroBalanceLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.title = "Главная"
        scrollView.delegate = self
        refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "Идет обновление...")
        refreshControl.addTarget(self, action: #selector(refresh), for: .valueChanged)
        scrollView.addSubview(refreshControl)
    }
    override func viewWillAppear(_ animated: Bool) {
        self.getData(){
            
        }
    }
   
    func getData(completion: @escaping () -> Void ){
        getDataApi(){
            completion()
        }
    }
    func getDataApi(completion: @escaping () -> Void ){
        let numberOfPlaces = 2.0
        let multiplier = pow(10.0, numberOfPlaces)
        let dateFormatter : DateFormatter = DateFormatter()
        dateFormatter.dateFormat = "yyyy-MM-dd HH:mm:ss"
        let date = Date()
        let dateString = dateFormatter.string(from: date)
        network.fetch(fromRoute: Routes.infoFinance, fromParameters: ["now_date":dateString, "token":storege.userInfo.token], fromHeaders: nil) {(result) in
            switch result {
            case .success(let model):
                
                print (model)
                let data = model.data[0]
                if (data.costs == "null"){
                    self.costsLabel.text = "0"
                }
                else{
                    self.costsLabel.text = data.costs
                }
                if(data.incomings == "null"){
                    self.incomingsLabel.text = "0"
                }
                else {
                    self.incomingsLabel.text = data.incomings
                }
                self.balanceLabel.text = data.balance
                self.dollarBalanceLabel.text = String(round((Double(data.balance)!/65) * multiplier) / multiplier)+"$"
                self.euroBalanceLabel.text = String(round((Double(data.balance)!/75) * multiplier) / multiplier)+"€"
                completion()
            case .failure(let error):
                print (error)
                completion()
            }
        }
    }
    @objc func refresh() {
        refreshBegin(newtext: "",refreshEnd: {(x:Int) -> () in
            self.historyTableView.reloadData()
            self.refreshControl.endRefreshing()
        })
    }
    
    func refreshBegin(newtext:String, refreshEnd:@escaping (Int) -> ()) {
        DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
            self.getData {
                self.refreshControl.attributedTitle = NSAttributedString(string: newtext)
                DispatchQueue.main.asyncAfter(deadline: .now(), execute: {
                    refreshEnd(0)
                })
            }
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
