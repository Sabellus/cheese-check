//
//  ViewController.swift
//  Cheese
//
//  Created by Савелий Вепрев on 15/01/2019.
//  Copyright © 2019 Saveliy Veprev. All rights reserved.
//

import UIKit

class TabBarController: UITabBarController {    
    static func storyboardInstance() -> TabBarController? {
        let storyboard = UIStoryboard(name: String(describing: self), bundle: nil)
        return storyboard.instantiateInitialViewController() as? TabBarController
    }
    var secondItemImageView: UIImageView!
    var itemsImageView: [UIImageView] = []
    override func viewDidLoad() {
        super.viewDidLoad()        
        let general = UIStoryboard(name: "GeneralViewController", bundle: nil).instantiateViewController(withIdentifier: "root")
        general.tabBarItem = UITabBarItem(title: "Главная", image: UIImage(named: "home"), tag: 0)
        let checks = UIStoryboard(name: "CheckViewController", bundle: nil).instantiateViewController(withIdentifier: "root")
        checks.tabBarItem = UITabBarItem(title: "Чеки", image: UIImage(named: "check"), tag: 1)
        
        let anim = UIStoryboard(name: "CheckViewController", bundle: nil).instantiateViewController(withIdentifier: "root")
        anim.tabBarItem = UITabBarItem(title: "Анимация", image: UIImage(named: "check"), tag: 2)
        let tabBarList = [general,checks,anim]
        
       
        viewControllers = tabBarList
        selectedIndex = 0
        tabBar.tintColor = UIColor(red:0.00, green:0.48, blue:1.00, alpha:1.0)
        //tabBar.shadowImage = UIImage()
        tabBar.backgroundImage = UIImage()
        tabBar.layer.borderWidth = 0.5
        tabBar.layer.borderColor = UIColor.white.cgColor
        tabBar.layer.backgroundColor = UIColor.white.cgColor
        tabBar.clipsToBounds = true
        for (index,_) in self.tabBar.subviews.enumerated(){
            itemsImageView.append(UIImageView())
            let itemView = self.tabBar.subviews[index]
            self.itemsImageView[index] = itemView.subviews.first as! UIImageView
            self.itemsImageView[index].contentMode = .center
        }
    }
    override func tabBar(_ tabBar: UITabBar, didSelect item: UITabBarItem) {
        
        if item.tag != selectedIndex{
            //do our animations
            
            self.itemsImageView[item.tag].transform = CGAffineTransform.identity
            
            UIView.animate(withDuration: 0.4, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
                
                let rotation = CGAffineTransform(rotationAngle: -CGFloat(Double.pi / 10))
                self.itemsImageView[item.tag].transform = rotation
                
            }, completion: { _ in
                UIView.animate(withDuration: 0.6, delay: 0, usingSpringWithDamping: 0.5, initialSpringVelocity: 1, options: .curveEaseInOut, animations: { () -> Void in
                    
                    self.itemsImageView[item.tag].transform = CGAffineTransform.identity
                    
                }, completion: nil)
            })
           
            
        }
    }
}

